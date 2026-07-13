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
	github.com/jsonnet-bundler/jsonnet-bundler v0.6.0
	golang.org/x/lint v0.0.0-20241112194109-818c5a804067
)

require github.com/google/go-cmp v0.7.0 // indirect

require (
	github.com/alecthomas/template v0.0.0-20190718012654-fb15b899a751 // indirect
	github.com/alecthomas/units v0.0.0-20211218093645-b94a6e3cc137 // indirect
	github.com/elliotchance/orderedmap/v2 v2.2.0 // indirect
	github.com/fatih/color v1.13.0 // indirect
	github.com/mattn/go-colorable v0.1.12 // indirect
	github.com/mattn/go-isatty v0.0.14 // indirect
	github.com/pkg/errors v0.9.1 // indirect
	golang.org/x/sys v0.33.0 // indirect
	golang.org/x/tools v0.34.0 // indirect
	gopkg.in/alecthomas/kingpin.v2 v2.2.6 // indirect
)
