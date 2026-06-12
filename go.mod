module github.com/buildbarn/bb-deployments

go 1.26.1

// rules_go doesn't support gomock's package mode.
// Use the same version as bb-storage and bb-remote-execution.
replace go.uber.org/mock => go.uber.org/mock v0.4.0

// https://github.com/grpc-ecosystem/grpc-gateway/commit/5f9757f31b517d98095209636b2b88cd6326572f
// replace github.com/grpc-ecosystem/grpc-gateway/v2 => github.com/grpc-ecosystem/grpc-gateway/v2 v2.16.1

// We want the API from 1.24.
replace go.opentelemetry.io/otel/trace v1.25.0 => go.opentelemetry.io/otel/trace v1.24.0

// Use the same version as bb-remote-execution.
replace github.com/hanwen/go-fuse/v2 => github.com/hanwen/go-fuse/v2 v2.5.1

// Use the same version as bb-storage.
// Or we add a dep to cncf/xds, with build file errors: https://github.com/cncf/xds/issues/104
replace cloud.google.com/go/storage v1.45.0 => cloud.google.com/go/storage v1.43.0

require (
	github.com/bazelbuild/rules_go v0.60.0
	golang.org/x/lint v0.0.0-20241112194109-818c5a804067
)

require golang.org/x/tools v0.34.0 // indirect
