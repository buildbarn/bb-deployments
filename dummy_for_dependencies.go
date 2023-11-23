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
	"github.com/buildbarn/bb-browser/cmd/bb_browser"
	"github.com/buildbarn/bb-remote-execution/cmd/bb_runner"
	"github.com/buildbarn/bb-remote-execution/cmd/bb_scheduler"
	"github.com/buildbarn/bb-remote-execution/cmd/bb_worker"
	"github.com/buildbarn/bb-storage/cmd/bb_storage"
	"mvdan.cc/gofumpt" // GitHub Workflow
)
