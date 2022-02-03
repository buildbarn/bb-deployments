package main

import (
	"log"
	"os"
	"os/exec"
	"path"
	"os/signal"
	"syscall"
	"github.com/bazelbuild/rules_go/go/tools/bazel"
)

type buildbarnProcess struct {
	config string
	binary string
}

func bbStart(bbProcess buildbarnProcess) *exec.Cmd {
	path, found := bazel.FindBinary(path.Join("cmd", bbProcess.binary), bbProcess.binary)
	configPath, err := bazel.Runfile(bbProcess.config)
	if !found {
		log.Fatalf("Couldn't find %s", bbProcess.binary)
	}
	if err != nil {
		log.Fatal(err)
	}
	cmd := exec.Command(path, configPath)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Start()
	return cmd
}

func main() {

	os.Mkdir("build", 0755)
	os.Mkdir("cache", 0755)
	os.Mkdir("storage-ac", 0755)
	os.Mkdir("storage-cas", 0755)

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
	var commands []*exec.Cmd
	for _, bb := range bbs {
		log.Println("Starting", bb.binary)
		commands = append(commands, bbStart(bb))
	}

	// Kill all started processes if interrupted:
	c := make(chan os.Signal)
	signal.Notify(c, os.Interrupt, syscall.SIGTERM)
	go func() {
		<-c
		for _, command := range commands {
			log.Printf("Killing proc: %d", command.Process.Pid)
			command.Process.Kill()
		}
		os.Exit(1)
	}()
	// Wait forever or until stopped
	<-(chan int)(nil)
}
