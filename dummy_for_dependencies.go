// Package dummyforgomod only exists to make 'bazel run @rules_go//go -- mod tidy' and Gazelle
// automatically generate all the dependencies needed for the BUILD.bazel
// files into go_dependencies.bzl.
//
// If this file contains code using the dependencies, `bazel run @rules_go//go -- mod tidy` will only
// add the exact transitive dependencies that are needed for building. By
// leaving this file without any code, `bazel run @rules_go//go -- mod tidy` adds all transitive
// dependencies for the needed modules.
package dummyforgomod

import (
	_ "golang.org/x/lint" // GitHub Workflow
)
