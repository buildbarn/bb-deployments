<#
.Description
This script runs the specified command via connhost to ensure that it has a
proper Windows Console available. The reason for this script's existence is
that Github Actions executes Windows scripts in an environment without an
interactive console, and this breaks the sending of CTRL_C_EVENT which we
use to gracefully terminate buildbarn. Without this, the kill -SIGINT has
no effect.

One downside of this approach is that, in practice, the subprocesses's
output is buffered until the subprocess terminates. Unfortunately there does
not appear to be a workaround for this.
#>
param(
    [Parameter(Mandatory=$true)]
    [string]$Command,

    [Parameter(Mandatory=$false)]
    [int]$TimeoutMinutes = 10
)

$TempBatFile = Join-Path ([System.IO.Path]::GetTempPath()) "run_bash_$(Get-Random).bat"
# conhost.exe adds VT100 escape codes which GitHub Actions doesn't handle well,
# so pipe output through a file.
$ConsoleOutputFile = Join-Path ([System.IO.Path]::GetTempPath()) "exit_code_$(Get-Random).txt"
# conhost.exe does not propagate the exit code, so write it to a file.
$ExitCodeFile = Join-Path ([System.IO.Path]::GetTempPath()) "exit_code_$(Get-Random).txt"
$CurrentWorkingDirectory = Get-Location
$BatchContent = @"
@echo off
cd "$CurrentWorkingDirectory"
$Command >"$ConsoleOutputFile" 2>&1
echo %ERRORLEVEL% > "$ExitCodeFile"
exit /b %ERRORLEVEL%
"@

$asyncConhost = @"
using System;
using System.Diagnostics;
using System.IO;

namespace AsyncConhost {
    public static class exec {
        public static int runCommand(string batFile, string consoleOutputFile, int timeoutInSeconds) {
            using (var stdoutStream = Console.OpenStandardOutput())
            using (var conhostOutputStream = File.Open(consoleOutputFile, FileMode.OpenOrCreate, FileAccess.Read, FileShare.ReadWrite)) {
                Process process = new Process();
                process.StartInfo.FileName = "conhost.exe";
                process.StartInfo.Arguments = '"' + batFile + '"';
                process.StartInfo.UseShellExecute = false;
                process.StartInfo.CreateNoWindow = true;
                process.StartInfo.RedirectStandardOutput = true;
                process.StartInfo.RedirectStandardError = true;

                var outErrReceivedHandler = new DataReceivedEventHandler(
                    (sender, e) => Console.WriteLine(e.Data)
                );
                process.OutputDataReceived += outErrReceivedHandler;
                process.ErrorDataReceived += outErrReceivedHandler;

                process.Start();
                process.BeginOutputReadLine();
                process.BeginErrorReadLine();
                Console.WriteLine("Started conhost.exe " + batFile + " with PID " + process.Id);

                Stopwatch stopWatch = new Stopwatch();
                stopWatch.Start();
                while (!process.WaitForExit(100)) {
                    ForwardConsoleOutput(stdoutStream, conhostOutputStream);
                    if (stopWatch.ElapsedMilliseconds > 1000 * timeoutInSeconds) {
                        Console.WriteLine("Process exceeded timeout, force killing...");
                        // process.Kill(/*entireProcessTree =*/ true); should work.
                        process.Kill();
                        Console.WriteLine("Force killed process and its children");
                        return 42;
                    }
                }
                stopWatch.Stop();
                ForwardConsoleOutput(stdoutStream, conhostOutputStream);
                return process.ExitCode;
            }
        }

        private static void OutputHandler(object sendingProcess, DataReceivedEventArgs outLine) {
            Console.WriteLine(outLine.Data);
        }

        private static void ForwardConsoleOutput(Stream stdoutStream, FileStream consoleOutputStream) {
            int bufSize = 65536;
            byte[] bytes = new byte[bufSize];
            while (true) {
                int numBytesRead = consoleOutputStream.Read(bytes, 0, bufSize);
                if (numBytesRead == 0) {
                    // End of file for now.
                    break;
                }
                stdoutStream.Write(bytes, 0, numBytesRead);
            }
        }
    }
}
"@

try {
    $BatchContent | Out-File -FilePath $TempBatFile -Encoding ASCII

    Add-Type -TypeDefinition $asyncConhost -Language CSharp
    [AsyncConhost.exec]::runCommand($TempBatFile, $ConsoleOutputFile, $TimeoutMinutes * 60)
    if (!(Test-Path $ExitCodeFile)) {
        Write-Error "Exit code file not found"
        exit 1
    }
    $ActualExitCode = [int](Get-Content $ExitCodeFile -Raw).Trim()
    Write-Host "Process completed normally with exit code: $ActualExitCode"
    exit $ActualExitCode
}
catch {
    Write-Error "Error running process: $_"
    exit 1
}
finally {
    Remove-Item $TempBatFile -Force -ErrorAction SilentlyContinue
    Remove-Item $ConsoleOutputFile -Force -ErrorAction SilentlyContinue
    Remove-Item $ExitCodeFile -Force -ErrorAction SilentlyContinue
}
