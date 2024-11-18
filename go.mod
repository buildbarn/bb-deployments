module github.com/buildbarn/bb-deployments

go 1.23.0

// https://github.com/grpc-ecosystem/grpc-gateway/commit/5f9757f31b517d98095209636b2b88cd6326572f
// replace github.com/grpc-ecosystem/grpc-gateway/v2 => github.com/grpc-ecosystem/grpc-gateway/v2 v2.16.1

// Gazelle does not like newer versions.
replace golang.org/x/tools => golang.org/x/tools v0.8.0

// Using the most recent version causes a cyclic dependency in protoc.
replace google.golang.org/protobuf => google.golang.org/protobuf v1.32.0

// We want the API from 1.24.
replace go.opentelemetry.io/otel/trace v1.25.0 => go.opentelemetry.io/otel/trace v1.24.0

// Use the same version as bb-remote-execution.
replace github.com/hanwen/go-fuse/v2 v2.6.4 => github.com/hanwen/go-fuse/v2 v2.5.1

// Use the same version as bb-storage.
// Or we add a dep to cncf/xds, with build file errors: https://github.com/cncf/xds/issues/104
replace cloud.google.com/go/storage v1.45.0 => cloud.google.com/go/storage v1.43.0

require (
	github.com/bazelbuild/rules_go v0.49.0
	github.com/buildbarn/bb-browser v0.0.0-20240930111151-af89e4bc66f0
	github.com/buildbarn/bb-remote-execution v0.0.0-20241030155505-8a43a7749390
	github.com/buildbarn/bb-storage v0.0.0-20241117113434-9cc3bc2af044
	golang.org/x/lint v0.0.0-20241112194109-818c5a804067
	mvdan.cc/gofumpt v0.7.0
)

require (
	cel.dev/expr v0.18.0 // indirect
	cloud.google.com/go v0.116.0 // indirect
	cloud.google.com/go/auth v0.10.2 // indirect
	cloud.google.com/go/auth/oauth2adapt v0.2.5 // indirect
	cloud.google.com/go/compute/metadata v0.5.2 // indirect
	cloud.google.com/go/iam v1.2.2 // indirect
	cloud.google.com/go/longrunning v0.6.2 // indirect
	cloud.google.com/go/monitoring v1.21.2 // indirect
	cloud.google.com/go/storage v1.47.0 // indirect
	git.sr.ht/~sbinet/gg v0.6.0 // indirect
	github.com/GoogleCloudPlatform/opentelemetry-operations-go/detectors/gcp v1.25.0 // indirect
	github.com/GoogleCloudPlatform/opentelemetry-operations-go/exporter/metric v0.49.0 // indirect
	github.com/GoogleCloudPlatform/opentelemetry-operations-go/internal/resourcemapping v0.49.0 // indirect
	github.com/ajstarks/svgo v0.0.0-20211024235047-1546f124cd8b // indirect
	github.com/aohorodnyk/mimeheader v0.0.6 // indirect
	github.com/aws/aws-sdk-go-v2 v1.32.4 // indirect
	github.com/aws/aws-sdk-go-v2/aws/protocol/eventstream v1.6.6 // indirect
	github.com/aws/aws-sdk-go-v2/config v1.28.4 // indirect
	github.com/aws/aws-sdk-go-v2/credentials v1.17.45 // indirect
	github.com/aws/aws-sdk-go-v2/feature/ec2/imds v1.16.19 // indirect
	github.com/aws/aws-sdk-go-v2/internal/configsources v1.3.23 // indirect
	github.com/aws/aws-sdk-go-v2/internal/endpoints/v2 v2.6.23 // indirect
	github.com/aws/aws-sdk-go-v2/internal/ini v1.8.1 // indirect
	github.com/aws/aws-sdk-go-v2/internal/v4a v1.3.23 // indirect
	github.com/aws/aws-sdk-go-v2/service/internal/accept-encoding v1.12.0 // indirect
	github.com/aws/aws-sdk-go-v2/service/internal/checksum v1.4.4 // indirect
	github.com/aws/aws-sdk-go-v2/service/internal/presigned-url v1.12.4 // indirect
	github.com/aws/aws-sdk-go-v2/service/internal/s3shared v1.18.4 // indirect
	github.com/aws/aws-sdk-go-v2/service/s3 v1.67.0 // indirect
	github.com/aws/aws-sdk-go-v2/service/sso v1.24.5 // indirect
	github.com/aws/aws-sdk-go-v2/service/ssooidc v1.28.4 // indirect
	github.com/aws/aws-sdk-go-v2/service/sts v1.33.0 // indirect
	github.com/aws/smithy-go v1.22.1 // indirect
	github.com/bazelbuild/remote-apis v0.0.0-20241031050812-253013303c9e // indirect
	github.com/beorn7/perks v1.0.1 // indirect
	github.com/buildbarn/go-xdr v0.0.0-20240702182809-236788cf9e89 // indirect
	github.com/buildkite/terminal-to-html v3.2.0+incompatible // indirect
	github.com/campoy/embedmd v1.0.0 // indirect
	github.com/census-instrumentation/opencensus-proto v0.4.1 // indirect
	github.com/cespare/xxhash/v2 v2.3.0 // indirect
	github.com/cncf/xds/go v0.0.0-20240905190251-b4127c9b8d78 // indirect
	github.com/dustin/go-humanize v1.0.1 // indirect
	github.com/envoyproxy/go-control-plane v0.13.1 // indirect
	github.com/envoyproxy/protoc-gen-validate v1.1.0 // indirect
	github.com/felixge/httpsnoop v1.0.4 // indirect
	github.com/fsnotify/fsnotify v1.8.0 // indirect
	github.com/fxtlabs/primes v0.0.0-20150821004651-dad82d10a449 // indirect
	github.com/go-fonts/liberation v0.3.3 // indirect
	github.com/go-jose/go-jose/v3 v3.0.3 // indirect
	github.com/go-latex/latex v0.0.0-20240709081214-31cef3c7570e // indirect
	github.com/go-logr/logr v1.4.2 // indirect
	github.com/go-logr/stdr v1.2.2 // indirect
	github.com/go-pdf/fpdf v0.9.0 // indirect
	github.com/golang/freetype v0.0.0-20170609003504-e2365dfdc4a0 // indirect
	github.com/golang/groupcache v0.0.0-20210331224755-41bb18bfe9da // indirect
	github.com/golang/protobuf v1.5.4 // indirect
	github.com/google/go-cmp v0.6.0 // indirect
	github.com/google/go-jsonnet v0.20.0 // indirect
	github.com/google/s2a-go v0.1.8 // indirect
	github.com/google/uuid v1.6.0 // indirect
	github.com/googleapis/enterprise-certificate-proxy v0.3.4 // indirect
	github.com/googleapis/gax-go/v2 v2.14.0 // indirect
	github.com/gorilla/mux v1.8.1 // indirect
	github.com/grpc-ecosystem/go-grpc-middleware v1.4.0 // indirect
	github.com/grpc-ecosystem/go-grpc-prometheus v1.2.0 // indirect
	github.com/grpc-ecosystem/grpc-gateway/v2 v2.23.0 // indirect
	github.com/hanwen/go-fuse/v2 v2.6.4 // indirect
	github.com/jmespath/go-jmespath v0.4.0 // indirect
	github.com/kballard/go-shellquote v0.0.0-20180428030007-95032a82bc51 // indirect
	github.com/klauspost/compress v1.17.11 // indirect
	github.com/lazybeaver/xorshift v0.0.0-20170702203709-ce511d4823dd // indirect
	github.com/munnerz/goautoneg v0.0.0-20191010083416-a7dc8b61c822 // indirect
	github.com/planetscale/vtprotobuf v0.6.1-0.20240319094008-0393e58bdf10 // indirect
	github.com/pmezard/go-difflib v1.0.0 // indirect
	github.com/prometheus/client_golang v1.20.5 // indirect
	github.com/prometheus/client_model v0.6.1 // indirect
	github.com/prometheus/common v0.60.1 // indirect
	github.com/prometheus/procfs v0.15.1 // indirect
	github.com/sercand/kuberesolver/v5 v5.1.1 // indirect
	go.opencensus.io v0.24.0 // indirect
	go.opentelemetry.io/contrib/detectors/gcp v1.32.0 // indirect
	go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc v0.57.0 // indirect
	go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp v0.57.0 // indirect
	go.opentelemetry.io/contrib/propagators/b3 v1.32.0 // indirect
	go.opentelemetry.io/otel v1.32.0 // indirect
	go.opentelemetry.io/otel/exporters/jaeger v1.17.0 // indirect
	go.opentelemetry.io/otel/exporters/otlp/otlptrace v1.32.0 // indirect
	go.opentelemetry.io/otel/metric v1.32.0 // indirect
	go.opentelemetry.io/otel/sdk v1.32.0 // indirect
	go.opentelemetry.io/otel/sdk/metric v1.32.0 // indirect
	go.opentelemetry.io/otel/trace v1.32.0 // indirect
	go.opentelemetry.io/proto/otlp v1.3.1 // indirect
	golang.org/x/crypto v0.29.0 // indirect
	golang.org/x/image v0.22.0 // indirect
	golang.org/x/mod v0.22.0 // indirect
	golang.org/x/net v0.31.0 // indirect
	golang.org/x/oauth2 v0.24.0 // indirect
	golang.org/x/sync v0.9.0 // indirect
	golang.org/x/sys v0.27.0 // indirect
	golang.org/x/text v0.20.0 // indirect
	golang.org/x/time v0.8.0 // indirect
	golang.org/x/tools v0.27.0 // indirect
	gonum.org/v1/plot v0.15.0 // indirect
	google.golang.org/api v0.206.0 // indirect
	google.golang.org/genproto v0.0.0-20241113202542-65e8d215514f // indirect
	google.golang.org/genproto/googleapis/api v0.0.0-20241113202542-65e8d215514f // indirect
	google.golang.org/genproto/googleapis/bytestream v0.0.0-20241113202542-65e8d215514f // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20241113202542-65e8d215514f // indirect
	google.golang.org/grpc v1.68.0 // indirect
	google.golang.org/grpc/security/advancedtls v1.0.0 // indirect
	google.golang.org/grpc/stats/opentelemetry v0.0.0-20241028142157-ada6787961b3 // indirect
	google.golang.org/protobuf v1.35.2 // indirect
	sigs.k8s.io/yaml v1.4.0 // indirect
)
