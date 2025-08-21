// Package dummyforgomod only exists to make 'go mod tidy' and Gazelle
// automatically generate all the dependencies needed for the BUILD.bazel
// files into go_dependencies.bzl.
//
// If this file contains code using the dependencies, `go mod tidy` will only
// add the exact transitive dependencies that are needed for building. By
// leaving this file without any code, `go mod tidy` adds all transitive
// dependencies for the needed modules.
package dummyforgomod

import (
	_ "github.com/bazelbuild/buildtools/buildifier"               // GitHub Workflow
	_ "github.com/buildbarn/bb-browser/cmd/bb_browser"            // bb-browser
	_ "github.com/buildbarn/bb-remote-execution/cmd/bb_runner"    // bb-runner
	_ "github.com/buildbarn/bb-remote-execution/cmd/bb_scheduler" // bb-scheduler
	_ "github.com/buildbarn/bb-remote-execution/cmd/bb_worker"    // bb-worker
	_ "github.com/buildbarn/bb-storage/cmd/bb_storage"            // bb-storage
	_ "golang.org/x/lint"                                         // GitHub Workflow
	_ "mvdan.cc/gofumpt"                                          // GitHub Workflow
)
