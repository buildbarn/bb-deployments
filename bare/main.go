package main

import (
	"context"
	"errors"
	"io/fs"
	"log"
	"os"
	"os/exec"
	"os/signal"
	"path"
	"sync"
	"syscall"
	"time"

	"github.com/bazelbuild/rules_go/go/tools/bazel"
)

type buildbarnProcess struct {
	config string
	binary string
}

func bbStart(bbProcess *buildbarnProcess, workingDir string) *exec.Cmd {
	binaryPath, found := bazel.FindBinary(path.Join("cmd", bbProcess.binary), bbProcess.binary)
	if !found {
		log.Printf("Couldn't find %s", bbProcess.binary)
		return nil
	}
	configPath, err := bazel.Runfile(bbProcess.config)
	if err != nil {
		log.Print(err)
		return nil
	}
	// Both binaryPath and configPath are absolute, so the working directory can change.
	cmd := exec.Command(binaryPath, configPath)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Dir = workingDir
	if err := cmd.Start(); err != nil {
		log.Printf("Failed starting %s:\n%s", bbProcess.binary, err)
		return nil
	}
	return cmd
}

func bbWait(sigtermSignal, killSignal <-chan struct{}, bbProcess *buildbarnProcess, cmd *exec.Cmd) {
	finished := make(chan struct{})
	go func() {
		cmd.Wait()
		close(finished)
		log.Printf("Exit code %d from %s with PID %d", cmd.ProcessState.ExitCode(), bbProcess.binary, cmd.Process.Pid)
	}()
	select {
	case <-finished:
		return
	case <-sigtermSignal:
		cmd.Process.Signal(syscall.SIGTERM)
	}
	select {
	case <-finished:
		return
	case <-killSignal:
		cmd.Process.Kill()
	}
	<-finished
}

func mustMkdir(name string, perm os.FileMode) {
	if err := os.Mkdir(name, perm); err != nil && !errors.Is(err, fs.ErrExist) {
		log.Fatal(err)
	}
}

func main() {
	var workingDir string
	if len(os.Args) > 2 {
		log.Fatal("Usage: bare [absolute-working-directory]")
	} else if len(os.Args) == 2 {
		workingDir = os.Args[1]
		// Avoid accidental subfolders within Bazel's runfiles tree.
		if !path.IsAbs(workingDir) {
			log.Fatalf("%s must be absolute", workingDir)
		}
		if _, err := os.Stat(workingDir); errors.Is(err, fs.ErrNotExist) {
			log.Fatalf("%s does not exist", workingDir)
		}
	} else {
		workingDir = ""
	}

	mustMkdir(path.Join(workingDir, "storage-ac"), 0o755)
	mustMkdir(path.Join(workingDir, "storage-ac/persistent_state"), 0o755)
	mustMkdir(path.Join(workingDir, "storage-cas"), 0o755)
	mustMkdir(path.Join(workingDir, "storage-cas/persistent_state"), 0o755)
	mustMkdir(path.Join(workingDir, "worker"), 0o755)
	mustMkdir(path.Join(workingDir, "worker/build"), 0o755)
	mustMkdir(path.Join(workingDir, "worker/cache"), 0o755)

	log.Println("Don't worry if you see some \"Failed to synchronize with scheduler\" warnings on startup")
	log.Println("\t- they should stop once bb_scheduler is ready")

	bbs := []buildbarnProcess{
		{config: "bare/config/storage.jsonnet", binary: "bb_storage"},
		{config: "bare/config/frontend.jsonnet", binary: "bb_storage"},
		{config: "bare/config/scheduler.jsonnet", binary: "bb_scheduler"},
		{config: "bare/config/worker.jsonnet", binary: "bb_worker"},
		{config: "bare/config/runner.jsonnet", binary: "bb_runner"},
		{config: "bare/config/browser.jsonnet", binary: "bb_browser"},
	}

	sigtermContext, cancelWithSigterm := context.WithCancel(context.Background())
	killContext, cancelWithKill := context.WithCancel(context.Background())
	wg := sync.WaitGroup{}

	var commands []*exec.Cmd
	for _, bb := range bbs {
		command := bbStart(&bb, workingDir)
		if command == nil {
			cancelWithSigterm()
			break
		}
		log.Printf("Started %s with PID %d", bb.binary, command.Process.Pid)
		// Terminate started processes when any of them finish.
		wg.Add(1)
		go func(bb *buildbarnProcess) {
			bbWait(sigtermContext.Done(), killContext.Done(), bb, command)
			cancelWithSigterm()
			wg.Done()
		}(&bb)
		commands = append(commands, command)
	}

	// Terminate started processes if interrupted.
	go func() {
		interruptChan := make(chan os.Signal)
		signal.Notify(interruptChan, os.Interrupt, syscall.SIGTERM)
		<-interruptChan
		log.Print("Received first SIGTERM, gracefully terminating Buildbarn processes")
		cancelWithSigterm()
		// Kill on a second interrupt signal.
		<-interruptChan
		signal.Stop(interruptChan)
		log.Print("Received second SIGTERM, killing Buildbarn processes")
		cancelWithKill()
	}()

	// Kill processes if SIGTERM handling times out.
	go func() {
		<-sigtermContext.Done()
		time.Sleep(10 * time.Second)
		log.Print("SIGTERM handling was slow, killing Buildbarn processes")
		cancelWithKill()
	}()

	wg.Wait()
	if len(commands) == 0 {
		// Not even the first Buildbarn process did start.
		os.Exit(1)
	}
	for _, cmd := range commands {
		if !cmd.ProcessState.Success() {
			os.Exit(1)
		}
	}
}
