module github.com/buildbarn/bb-deployments

go 1.26.4

// rules_go doesn't support gomock's package mode.
// Use the same version as bb-storage and bb-remote-execution.
replace go.uber.org/mock => go.uber.org/mock v0.4.0

// https://github.com/grpc-ecosystem/grpc-gateway/commit/5f9757f31b517d98095209636b2b88cd6326572f
// replace github.com/grpc-ecosystem/grpc-gateway/v2 => github.com/grpc-ecosystem/grpc-gateway/v2 v2.16.1

// We want the API from 1.24.
replace go.opentelemetry.io/otel/trace v1.25.0 => go.opentelemetry.io/otel/trace v1.24.0

// Use the same version as bb-remote-execution.
replace github.com/hanwen/go-fuse/v2 => github.com/hanwen/go-fuse/v2 v2.5.1

require (
	github.com/bazelbuild/rules_go v0.61.1
	golang.org/x/lint v0.0.0-20241112194109-818c5a804067
)

require github.com/google/go-cmp v0.7.0 // indirect

require golang.org/x/tools v0.34.0 // indirect
