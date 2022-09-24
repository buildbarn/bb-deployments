load("@bazel_gazelle//:deps.bzl", "go_repository")

def go_dependencies():
    go_repository(
        name = "cc_mvdan_gofumpt",
        importpath = "mvdan.cc/gofumpt",
        replace = "mvdan.cc/gofumpt",
        sum = "h1:kTojdZo9AcEYbQYhGuLf/zszYthRdhDNDUi2JKTxas4=",
        version = "v0.3.0",
    )
    go_repository(
        name = "co_honnef_go_tools",
        importpath = "honnef.co/go/tools",
        sum = "h1:qTakTkI6ni6LFD5sBwwsdSO+AQqbSIxOauHTTQKZ/7o=",
        version = "v0.1.3",
    )
    go_repository(
        name = "com_github_ajstarks_deck",
        importpath = "github.com/ajstarks/deck",
        sum = "h1:7kQgkwGRoLzC9K0oyXdJo7nve/bynv/KwUsxbiTlzAM=",
        version = "v0.0.0-20200831202436-30c9fc6549a9",
    )
    go_repository(
        name = "com_github_ajstarks_deck_generate",
        importpath = "github.com/ajstarks/deck/generate",
        sum = "h1:iXUgAaqDcIUGbRoy2TdeofRG/j1zpGRSEmNK05T+bi8=",
        version = "v0.0.0-20210309230005-c3f852c02e19",
    )
    go_repository(
        name = "com_github_ajstarks_svgo",
        importpath = "github.com/ajstarks/svgo",
        sum = "h1:slYM766cy2nI3BwyRiyQj/Ud48djTMtMebDqepE95rw=",
        version = "v0.0.0-20211024235047-1546f124cd8b",
    )
    go_repository(
        name = "com_github_alecthomas_template",
        importpath = "github.com/alecthomas/template",
        sum = "h1:JYp7IbQjafoB+tBA3gMyHYHrpOtNuDiK/uB5uXxq5wM=",
        version = "v0.0.0-20190718012654-fb15b899a751",
    )
    go_repository(
        name = "com_github_alecthomas_units",
        importpath = "github.com/alecthomas/units",
        sum = "h1:UQZhZ2O0vMHr2cI+DC1Mbh0TJxzA3RcLoMsFw+aXw7E=",
        version = "v0.0.0-20190924025748-f65c72e2690d",
    )
    go_repository(
        name = "com_github_antihax_optional",
        importpath = "github.com/antihax/optional",
        sum = "h1:xK2lYat7ZLaVVcIuj82J8kIro4V6kDe0AUDFboUCwcg=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_antlr_antlr4_runtime_go_antlr",
        importpath = "github.com/antlr/antlr4/runtime/Go/antlr",
        sum = "h1:rfAZfq1LjIhVCFsBp2MoXxVvgtCyZUOtzsV8azhR1Jk=",
        version = "v0.0.0-20220722194653-14703f21b580",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2",
        importpath = "github.com/aws/aws-sdk-go-v2",
        sum = "h1:M1fj4FE2lB4NzRb9Y0xdWsn2P0+2UHVxwKyOa4YJNjk=",
        version = "v1.16.16",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_aws_protocol_eventstream",
        importpath = "github.com/aws/aws-sdk-go-v2/aws/protocol/eventstream",
        sum = "h1:tcFliCWne+zOuUfKNRn8JdFBuWPDuISDH08wD2ULkhk=",
        version = "v1.4.8",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_config",
        importpath = "github.com/aws/aws-sdk-go-v2/config",
        sum = "h1:odVM52tFHhpqZBKNjVW5h+Zt1tKHbhdTQRb+0WHrNtw=",
        version = "v1.17.7",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_credentials",
        importpath = "github.com/aws/aws-sdk-go-v2/credentials",
        sum = "h1:9+ZhlDY7N9dPnUmf7CDfW9In4sW5Ff3bh7oy4DzS1IE=",
        version = "v1.12.20",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_feature_ec2_imds",
        importpath = "github.com/aws/aws-sdk-go-v2/feature/ec2/imds",
        sum = "h1:r08j4sbZu/RVi+BNxkBJwPMUYY3P8mgSDuKkZ/ZN1lE=",
        version = "v1.12.17",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_internal_configsources",
        importpath = "github.com/aws/aws-sdk-go-v2/internal/configsources",
        sum = "h1:s4g/wnzMf+qepSNgTvaQQHNxyMLKSawNhKCPNy++2xY=",
        version = "v1.1.23",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_internal_endpoints_v2",
        importpath = "github.com/aws/aws-sdk-go-v2/internal/endpoints/v2",
        sum = "h1:/K482T5A3623WJgWT8w1yRAFK4RzGzEl7y39yhtn9eA=",
        version = "v2.4.17",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_internal_ini",
        importpath = "github.com/aws/aws-sdk-go-v2/internal/ini",
        sum = "h1:wj5Rwc05hvUSvKuOF29IYb9QrCLjU+rHAy/x/o0DK2c=",
        version = "v1.3.24",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_internal_v4a",
        importpath = "github.com/aws/aws-sdk-go-v2/internal/v4a",
        sum = "h1:ZSIPAkAsCCjYrhqfw2+lNzWDzxzHXEckFkTePL5RSWQ=",
        version = "v1.0.14",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_service_autoscaling",
        importpath = "github.com/aws/aws-sdk-go-v2/service/autoscaling",
        sum = "h1:cp30gVVAbZfeDod6UJGppMH2+p+/cRCG2AZ1TbT+LqA=",
        version = "v1.23.16",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_service_internal_accept_encoding",
        importpath = "github.com/aws/aws-sdk-go-v2/service/internal/accept-encoding",
        sum = "h1:Lh1AShsuIJTwMkoxVCAYPJgNG5H+eN6SmoUn8nOZ5wE=",
        version = "v1.9.9",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_service_internal_checksum",
        importpath = "github.com/aws/aws-sdk-go-v2/service/internal/checksum",
        sum = "h1:BBYoNQt2kUZUUK4bIPsKrCcjVPUMNsgQpNAwhznK/zo=",
        version = "v1.1.18",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_service_internal_presigned_url",
        importpath = "github.com/aws/aws-sdk-go-v2/service/internal/presigned-url",
        sum = "h1:Jrd/oMh0PKQc6+BowB+pLEwLIgaQF29eYbe7E1Av9Ug=",
        version = "v1.9.17",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_service_internal_s3shared",
        importpath = "github.com/aws/aws-sdk-go-v2/service/internal/s3shared",
        sum = "h1:HfVVR1vItaG6le+Bpw6P4midjBDMKnjMyZnw9MXYUcE=",
        version = "v1.13.17",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_service_s3",
        importpath = "github.com/aws/aws-sdk-go-v2/service/s3",
        sum = "h1:3/gm/JTX9bX8CpzTgIlrtYpB3EVBDxyg/GY/QdcIEZw=",
        version = "v1.27.11",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_service_sqs",
        importpath = "github.com/aws/aws-sdk-go-v2/service/sqs",
        sum = "h1:Y4civ9pg5cbQkSf/YGMfFZaIPAAAK61JV+NIzO8Ri4k=",
        version = "v1.19.10",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_service_sso",
        importpath = "github.com/aws/aws-sdk-go-v2/service/sso",
        sum = "h1:pwvCchFUEnlceKIgPUouBJwK81aCkQ8UDMORfeFtW10=",
        version = "v1.11.23",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_service_ssooidc",
        importpath = "github.com/aws/aws-sdk-go-v2/service/ssooidc",
        sum = "h1:GUnZ62TevLqIoDyHeiWj2P7EqaosgakBKVvWriIdLQY=",
        version = "v1.13.5",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_service_sts",
        importpath = "github.com/aws/aws-sdk-go-v2/service/sts",
        sum = "h1:9pPi0PsFNAGILFfPCk8Y0iyEBGc6lu6OQ97U7hmdesg=",
        version = "v1.16.19",
    )
    go_repository(
        name = "com_github_aws_smithy_go",
        importpath = "github.com/aws/smithy-go",
        sum = "h1:l7LYxGuzK6/K+NzJ2mC+VvLUbae0sL3bXU//04MkmnA=",
        version = "v1.13.3",
    )
    go_repository(
        name = "com_github_bazelbuild_remote_apis",
        importpath = "github.com/bazelbuild/remote-apis",
        patches = ["@com_github_buildbarn_bb_storage//:patches/com_github_bazelbuild_remote_apis/golang.diff"],
        sum = "h1:qYl6hZNiRz3taZICrn72Tk0zFB7FbT5c3Z+h4H1QwVc=",
        version = "v0.0.0-20220727181745-aa29b91f336b",
    )
    go_repository(
        name = "com_github_bazelbuild_rules_go",
        importpath = "github.com/bazelbuild/rules_go",
        sum = "h1:ViPR65vOrg74JKntAUFY6qZkheBKGB6to7wFd8gCRU4=",
        version = "v0.35.0",
    )
    go_repository(
        name = "com_github_beorn7_perks",
        importpath = "github.com/beorn7/perks",
        sum = "h1:VlbKKnNfV8bJzeqoa4cOKqO6bYr3WgKZxO8Z16+hsOM=",
        version = "v1.0.1",
    )
    go_repository(
        name = "com_github_boombuler_barcode",
        importpath = "github.com/boombuler/barcode",
        sum = "h1:NDBbPmhS+EqABEs5Kg3n/5ZNjy73Pz7SIV+KCeqyXcs=",
        version = "v1.0.1",
    )
    go_repository(
        name = "com_github_buildbarn_bb_browser",
        importpath = "github.com/buildbarn/bb-browser",
        sum = "h1:YOMHeN7PkILqqdl/T104NBE9cOezZwhhdmxRjoUz3Lc=",
        version = "v0.0.0-20220908160318-f32489ad70f9",
    )
    go_repository(
        name = "com_github_buildbarn_bb_remote_execution",
        importpath = "github.com/buildbarn/bb-remote-execution",
        sum = "h1:5x3ciUCs5hYwYLYp1SnYAFV3JnNIRDBKQVfLTJ3s+dw=",
        version = "v0.0.0-20220912200427-e664853dff06",
    )
    go_repository(
        name = "com_github_buildbarn_bb_storage",
        importpath = "github.com/buildbarn/bb-storage",
        sum = "h1:YG795/mmHoD2yr7YV7dNjgk6P15hzOPDZWWG7KTQoKA=",
        version = "v0.0.0-20220912104841-b7137ecb5613",
    )
    go_repository(
        name = "com_github_buildbarn_go_xdr",
        importpath = "github.com/buildbarn/go-xdr",
        sum = "h1:aVYAcBUakcn8QvCdKroXmjGjQBBqv3FLftTyiHjgKAQ=",
        version = "v0.0.0-20220804060714-a6fffae29b77",
    )
    go_repository(
        name = "com_github_buildkite_terminal_to_html",
        build_extra_args = ["--exclude=cmd/terminal-to-html"],
        importpath = "github.com/buildkite/terminal-to-html",
        patches = ["@com_github_buildbarn_bb_browser//:patches/com_github_buildkite_terminal_to_html/assets.diff"],
        sum = "h1:WdXzl7ZmYzCAz4pElZosPaUlRTW+qwVx/SkQSCa1jXs=",
        version = "v3.2.0+incompatible",
    )
    go_repository(
        name = "com_github_burntsushi_toml",
        importpath = "github.com/BurntSushi/toml",
        sum = "h1:WXkYYl6Yr3qBf1K79EBnL4mak0OimBfB0XUf9Vl28OQ=",
        version = "v0.3.1",
    )
    go_repository(
        name = "com_github_burntsushi_xgb",
        importpath = "github.com/BurntSushi/xgb",
        sum = "h1:1BDTz0u9nC3//pOCMdNH+CiXJVYJh5UQNCOBG7jbELc=",
        version = "v0.0.0-20160522181843-27f122750802",
    )
    go_repository(
        name = "com_github_cenkalti_backoff_v4",
        importpath = "github.com/cenkalti/backoff/v4",
        sum = "h1:cFAlzYUlVYDysBEH2T5hyJZMh3+5+WCBvSnK6Q8UtC4=",
        version = "v4.1.3",
    )
    go_repository(
        name = "com_github_census_instrumentation_opencensus_proto",
        build_extra_args = ["-exclude=src"],
        importpath = "github.com/census-instrumentation/opencensus-proto",
        sum = "h1:glEXhBS5PSLLv4IXzLA5yPRVX4bilULVyxxbrfOtDAk=",
        version = "v0.2.1",
    )
    go_repository(
        name = "com_github_cespare_xxhash",
        importpath = "github.com/cespare/xxhash",
        sum = "h1:a6HrQnmkObjyL+Gs60czilIUGqrzKutQD6XZog3p+ko=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_cespare_xxhash_v2",
        importpath = "github.com/cespare/xxhash/v2",
        sum = "h1:YRXhKfTDauu4ajMg1TPgFO5jnlC2HCbmLXMcTG5cbYE=",
        version = "v2.1.2",
    )
    go_repository(
        name = "com_github_chzyer_logex",
        importpath = "github.com/chzyer/logex",
        sum = "h1:Swpa1K6QvQznwJRcfTfQJmTE72DqScAa40E+fbHEXEE=",
        version = "v1.1.10",
    )
    go_repository(
        name = "com_github_chzyer_readline",
        importpath = "github.com/chzyer/readline",
        sum = "h1:fY5BOSpyZCqRo5OhCuC+XN+r/bBCmeuuJtjz+bCNIf8=",
        version = "v0.0.0-20180603132655-2972be24d48e",
    )
    go_repository(
        name = "com_github_chzyer_test",
        importpath = "github.com/chzyer/test",
        sum = "h1:q763qf9huN11kDQavWsoZXJNW3xEE4JJyHa5Q25/sd8=",
        version = "v0.0.0-20180213035817-a1ea475d72b1",
    )
    go_repository(
        name = "com_github_client9_misspell",
        importpath = "github.com/client9/misspell",
        sum = "h1:ta993UF76GwbvJcIo3Y68y/M3WxlpEHPWIGDkJYwzJI=",
        version = "v0.3.4",
    )
    go_repository(
        name = "com_github_cncf_udpa_go",
        importpath = "github.com/cncf/udpa/go",
        sum = "h1:hzAQntlaYRkVSFEfj9OTWlVV1H155FMD8BTKktLv0QI=",
        version = "v0.0.0-20210930031921-04548b0d99d4",
    )
    go_repository(
        name = "com_github_cncf_xds_go",
        importpath = "github.com/cncf/xds/go",
        sum = "h1:zH8ljVhhq7yC0MIeUL/IviMtY8hx2mK8cN9wEYb8ggw=",
        version = "v0.0.0-20211011173535-cb28da3451f1",
    )
    go_repository(
        name = "com_github_creack_pty",
        importpath = "github.com/creack/pty",
        sum = "h1:uDmaGzcdjhF4i/plgjmEsriH11Y0o7RKapEf/LDaM3w=",
        version = "v1.1.9",
    )
    go_repository(
        name = "com_github_davecgh_go_spew",
        importpath = "github.com/davecgh/go-spew",
        sum = "h1:vj9j/u1bqnvCEfJOwUhtlOARqs3+rkHYY13jYWTU97c=",
        version = "v1.1.1",
    )
    go_repository(
        name = "com_github_dgryski_go_rendezvous",
        importpath = "github.com/dgryski/go-rendezvous",
        sum = "h1:lO4WD4F/rVNCu3HqELle0jiPLLBs70cWOduZpkS1E78=",
        version = "v0.0.0-20200823014737-9f7001d12a5f",
    )
    go_repository(
        name = "com_github_dustin_go_humanize",
        importpath = "github.com/dustin/go-humanize",
        sum = "h1:VSnTsYCnlFHaM2/igO1h6X3HA71jcobQuxemgkq4zYo=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_envoyproxy_go_control_plane",
        importpath = "github.com/envoyproxy/go-control-plane",
        sum = "h1:xvqufLtNVwAhN8NMyWklVgxnWohi+wtMGQMhtxexlm0=",
        version = "v0.10.2-0.20220325020618-49ff273808a1",
    )
    go_repository(
        name = "com_github_envoyproxy_protoc_gen_validate",
        importpath = "github.com/envoyproxy/protoc-gen-validate",
        sum = "h1:EQciDnbrYxy13PgWoY8AqoxGiPrpgBZ1R8UNe3ddc+A=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_fatih_color",
        importpath = "github.com/fatih/color",
        sum = "h1:s36xzo75JdqLaaWoiEHk767eHiwo0598uUxyfiPkDsg=",
        version = "v1.10.0",
    )
    go_repository(
        name = "com_github_fogleman_gg",
        importpath = "github.com/fogleman/gg",
        sum = "h1:/7zJX8F6AaYQc57WQCyN9cAIz+4bCJGO9B+dyW29am8=",
        version = "v1.3.0",
    )
    go_repository(
        name = "com_github_frankban_quicktest",
        importpath = "github.com/frankban/quicktest",
        sum = "h1:SPb1KFFmM+ybpEjPUhCCkZOM5xlovT5UbrMvWnXyBns=",
        version = "v1.14.2",
    )
    go_repository(
        name = "com_github_fsnotify_fsnotify",
        importpath = "github.com/fsnotify/fsnotify",
        sum = "h1:jRbGcIw6P2Meqdwuo0H1p6JVLbL5DHKAKlYndzMwVZI=",
        version = "v1.5.4",
    )
    go_repository(
        name = "com_github_ghodss_yaml",
        importpath = "github.com/ghodss/yaml",
        sum = "h1:wQHKEahhL6wmXdzwWG11gIVCkOv05bNOh+Rxn0yngAk=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_go_fonts_dejavu",
        importpath = "github.com/go-fonts/dejavu",
        sum = "h1:JSajPXURYqpr+Cu8U9bt8K+XcACIHWqWrvWCKyeFmVQ=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_go_fonts_latin_modern",
        importpath = "github.com/go-fonts/latin-modern",
        sum = "h1:5/Tv1Ek/QCr20C6ZOz15vw3g7GELYL98KWr8Hgo+3vk=",
        version = "v0.2.0",
    )
    go_repository(
        name = "com_github_go_fonts_liberation",
        importpath = "github.com/go-fonts/liberation",
        sum = "h1:jAkAWJP4S+OsrPLZM4/eC9iW7CtHy+HBXrEwZXWo5VM=",
        version = "v0.2.0",
    )
    go_repository(
        name = "com_github_go_fonts_stix",
        importpath = "github.com/go-fonts/stix",
        sum = "h1:UlZlgrvvmT/58o573ot7NFw0vZasZ5I6bcIft/oMdgg=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_go_gl_glfw",
        importpath = "github.com/go-gl/glfw",
        sum = "h1:QbL/5oDUmRBzO9/Z7Seo6zf912W/a6Sr4Eu0G/3Jho0=",
        version = "v0.0.0-20190409004039-e6da0acd62b1",
    )
    go_repository(
        name = "com_github_go_gl_glfw_v3_3_glfw",
        importpath = "github.com/go-gl/glfw/v3.3/glfw",
        sum = "h1:WtGNWLvXpe6ZudgnXrq0barxBImvnnJoMEhXAzcbM0I=",
        version = "v0.0.0-20200222043503-6f7a984d4dc4",
    )
    go_repository(
        name = "com_github_go_kit_kit",
        importpath = "github.com/go-kit/kit",
        sum = "h1:wDJmvq38kDhkVxi50ni9ykkdUr1PKgqKOoi01fa0Mdk=",
        version = "v0.9.0",
    )
    go_repository(
        name = "com_github_go_kit_log",
        importpath = "github.com/go-kit/log",
        sum = "h1:7i2K3eKTos3Vc0enKCfnVcgHh2olr/MyfboYq7cAcFw=",
        version = "v0.2.0",
    )
    go_repository(
        name = "com_github_go_latex_latex",
        importpath = "github.com/go-latex/latex",
        sum = "h1:6zl3BbBhdnMkpSj2YY30qV3gDcVBGtFgVsV3+/i+mKQ=",
        version = "v0.0.0-20210823091927-c0d11ff05a81",
    )
    go_repository(
        name = "com_github_go_logfmt_logfmt",
        importpath = "github.com/go-logfmt/logfmt",
        sum = "h1:otpy5pqBCBZ1ng9RQ0dPu4PN7ba75Y/aA+UpowDyNVA=",
        version = "v0.5.1",
    )
    go_repository(
        name = "com_github_go_logr_logr",
        importpath = "github.com/go-logr/logr",
        sum = "h1:2DntVwHkVopvECVRSlL5PSo9eG+cAkDCuckLubN+rq0=",
        version = "v1.2.3",
    )
    go_repository(
        name = "com_github_go_logr_stdr",
        importpath = "github.com/go-logr/stdr",
        sum = "h1:hSWxHoqTgW2S2qGc0LTAI563KZ5YKYRhT3MFKZMbjag=",
        version = "v1.2.2",
    )
    go_repository(
        name = "com_github_go_pdf_fpdf",
        importpath = "github.com/go-pdf/fpdf",
        sum = "h1:MlgtGIfsdMEEQJr2le6b/HNr1ZlQwxyWr77r2aj2U/8=",
        version = "v0.6.0",
    )
    go_repository(
        name = "com_github_go_redis_redis_extra_rediscmd",
        importpath = "github.com/go-redis/redis/extra/rediscmd",
        sum = "h1:A3bhCsCKsedClEH9/jYlcKqOuBoeeV+H0yDie5t+a6w=",
        version = "v0.2.0",
    )
    go_repository(
        name = "com_github_go_redis_redis_extra_redisotel",
        importpath = "github.com/go-redis/redis/extra/redisotel",
        sum = "h1:8rrizwFAUUeMgmelyiQi9KeFwmpQhay9E+/rE6qHsBM=",
        version = "v0.3.0",
    )
    go_repository(
        name = "com_github_go_redis_redis_v8",
        importpath = "github.com/go-redis/redis/v8",
        sum = "h1:AcZZR7igkdvfVmQTPnu9WE37LRrO/YrBH5zWyjDC0oI=",
        version = "v8.11.5",
    )
    go_repository(
        name = "com_github_go_stack_stack",
        importpath = "github.com/go-stack/stack",
        sum = "h1:5SgMzNM5HxrEjV0ww2lTmX6E2Izsfxas4+YHWRs3Lsk=",
        version = "v1.8.0",
    )
    go_repository(
        name = "com_github_gogo_protobuf",
        importpath = "github.com/gogo/protobuf",
        sum = "h1:Ov1cvc58UF3b5XjBnZv7+opcTcQFZebYjWzi34vdm4Q=",
        version = "v1.3.2",
    )
    go_repository(
        name = "com_github_golang_freetype",
        importpath = "github.com/golang/freetype",
        sum = "h1:DACJavvAHhabrF08vX0COfcOBJRhZ8lUbR+ZWIs0Y5g=",
        version = "v0.0.0-20170609003504-e2365dfdc4a0",
    )
    go_repository(
        name = "com_github_golang_glog",
        importpath = "github.com/golang/glog",
        sum = "h1:nfP3RFugxnNRyKgeWd4oI1nYvXpxrx8ck8ZrcizshdQ=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_golang_groupcache",
        importpath = "github.com/golang/groupcache",
        sum = "h1:1r7pUrabqp18hOBcwBwiTsbnFeTZHV9eER/QT5JVZxY=",
        version = "v0.0.0-20200121045136-8c9f03a8e57e",
    )
    go_repository(
        name = "com_github_golang_mock",
        importpath = "github.com/golang/mock",
        patches = ["@com_github_buildbarn_bb_storage//:patches/com_github_golang_mock/mocks-for-funcs.diff"],
        sum = "h1:ErTB+efbowRARo13NNdxyJji2egdxLGQhRaY+DUumQc=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_github_golang_protobuf",
        importpath = "github.com/golang/protobuf",
        patches = ["@com_github_buildbarn_bb_storage//:patches/com_github_golang_protobuf/service-registrar.diff"],
        sum = "h1:ROPKBNFfQgOUMifHyP+KYbvpjbdoFNs+aK7DXlji0Tw=",
        version = "v1.5.2",
    )
    go_repository(
        name = "com_github_golang_snappy",
        importpath = "github.com/golang/snappy",
        sum = "h1:fHPg5GQYlCeLIPB9BZqMVR5nR9A+IM5zcgeTdjMYmLA=",
        version = "v0.0.3",
    )
    go_repository(
        name = "com_github_google_btree",
        importpath = "github.com/google/btree",
        sum = "h1:0udJVsspx3VBr5FwtLhQQtuAsVc79tTq0ocGIPAU6qo=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_google_go_cmp",
        importpath = "github.com/google/go-cmp",
        sum = "h1:O2Tfq5qg4qc4AmwVlvv0oLiVAGB7enBSJ2x2DqQFi38=",
        version = "v0.5.9",
    )
    go_repository(
        name = "com_github_google_go_jsonnet",
        build_file_generation = "on",
        importpath = "github.com/google/go-jsonnet",
        patches = ["@com_github_buildbarn_bb_storage//:patches/com_github_google_go_jsonnet/astgen.diff"],
        sum = "h1:/6pTy6g+Jh1a1I2UMoAODkqELFiVIdOxbNwv0DDzoOg=",
        version = "v0.18.0",
    )
    go_repository(
        name = "com_github_google_gofuzz",
        importpath = "github.com/google/gofuzz",
        sum = "h1:A8PeW59pxE9IoFRqBp37U+mSNaQoZ46F1f0f863XSXw=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_google_martian",
        importpath = "github.com/google/martian",
        sum = "h1:/CP5g8u/VJHijgedC/Legn3BAbAaWPgecwXBIDzw5no=",
        version = "v2.1.0+incompatible",
    )
    go_repository(
        name = "com_github_google_martian_v3",
        importpath = "github.com/google/martian/v3",
        sum = "h1:d8MncMlErDFTwQGBK1xhv026j9kqhvw1Qv9IbWT1VLQ=",
        version = "v3.2.1",
    )
    go_repository(
        name = "com_github_google_pprof",
        importpath = "github.com/google/pprof",
        sum = "h1:K6RDEckDVWvDI9JAJYCmNdQXq6neHJOYx3V6jnqNEec=",
        version = "v0.0.0-20210720184732-4bb14d4b1be1",
    )
    go_repository(
        name = "com_github_google_renameio",
        importpath = "github.com/google/renameio",
        sum = "h1:GOZbcHa3HfsPKPlmyPyN2KEohoMXOhdMbHrvbpl2QaA=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_google_uuid",
        importpath = "github.com/google/uuid",
        sum = "h1:t6JiXgmwXMjEs8VusXIJk2BXHsn+wx8BZdTaoZ5fu7I=",
        version = "v1.3.0",
    )
    go_repository(
        name = "com_github_googleapis_enterprise_certificate_proxy",
        importpath = "github.com/googleapis/enterprise-certificate-proxy",
        sum = "h1:7MYGT2XEMam7Mtzv1yDUYXANedWvwk3HKkR3MyGowy8=",
        version = "v0.0.0-20220520183353-fd19c99a87aa",
    )
    go_repository(
        name = "com_github_googleapis_gax_go_v2",
        importpath = "github.com/googleapis/gax-go/v2",
        sum = "h1:dS9eYAjhrE2RjmzYw2XAPvcXfmcQLtFEQWn0CR82awk=",
        version = "v2.4.0",
    )
    go_repository(
        name = "com_github_googleapis_go_type_adapters",
        importpath = "github.com/googleapis/go-type-adapters",
        sum = "h1:9XdMn+d/G57qq1s8dNc5IesGCXHf6V2HZ2JwRxfA2tA=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_gordonklaus_ineffassign",
        importpath = "github.com/gordonklaus/ineffassign",
        replace = "github.com/gordonklaus/ineffassign",
        sum = "h1:ISiYmLMC4o0lTlN31qYlz2NTpU8Pgrv54nVAJMOf+Fw=",
        version = "v0.0.0-20201223204552-cba2d2a1d5d9",
    )
    go_repository(
        name = "com_github_gorilla_mux",
        importpath = "github.com/gorilla/mux",
        sum = "h1:i40aqfkR1h2SlN9hojwV5ZA91wcXFOvkdNIeFDP5koI=",
        version = "v1.8.0",
    )
    go_repository(
        name = "com_github_grpc_ecosystem_go_grpc_middleware",
        importpath = "github.com/grpc-ecosystem/go-grpc-middleware",
        sum = "h1:+9834+KizmvFV7pXQGSXQTsaWhq2GjuNUt0aUU0YBYw=",
        version = "v1.3.0",
    )
    go_repository(
        name = "com_github_grpc_ecosystem_go_grpc_prometheus",
        importpath = "github.com/grpc-ecosystem/go-grpc-prometheus",
        patches = ["@com_github_buildbarn_bb_storage//:patches/com_github_grpc_ecosystem_go_grpc_prometheus/client-metrics-prevent-handled-twice.diff"],
        sum = "h1:Ovs26xHkKqVztRpIrF/92BcuyuQ/YW4NSIpoGtfXNho=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_grpc_ecosystem_grpc_gateway",
        build_file_generation = "on",
        importpath = "github.com/grpc-ecosystem/grpc-gateway",
        sum = "h1:gmcG1KaJ57LophUzW0Hy8NmPhnMZb4M0+kPpLofRdBo=",
        version = "v1.16.0",
    )
    go_repository(
        name = "com_github_grpc_ecosystem_grpc_gateway_v2",
        importpath = "github.com/grpc-ecosystem/grpc-gateway/v2",
        sum = "h1:lLT7ZLSzGLI08vc9cpd+tYmNWjdKDqyr/2L+f6U12Fk=",
        version = "v2.11.3",
    )
    go_repository(
        name = "com_github_hanwen_go_fuse",
        importpath = "github.com/hanwen/go-fuse",
        sum = "h1:GxS9Zrn6c35/BnfiVsZVWmsG803xwE7eVRDvcf/BEVc=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_hanwen_go_fuse_v2",
        importpath = "github.com/hanwen/go-fuse/v2",
        patches = [
            "@com_github_buildbarn_bb_remote_execution//:patches/com_github_hanwen_go_fuse_v2/daemon_timeout.diff",
            "@com_github_buildbarn_bb_remote_execution//:patches/com_github_hanwen_go_fuse_v2/direntrylist-offsets-and-testability.diff",
            "@com_github_buildbarn_bb_remote_execution//:patches/com_github_hanwen_go_fuse_v2/fuse-712-for-invalidation.diff",
            "@com_github_buildbarn_bb_remote_execution//:patches/com_github_hanwen_go_fuse_v2/notify-testability.diff",
        ],
        sum = "h1:+32ffteETaLYClUj0a3aHjZ1hOPxxaNEHiZiujuDaek=",
        version = "v2.1.0",
    )
    go_repository(
        name = "com_github_hashicorp_golang_lru",
        importpath = "github.com/hashicorp/golang-lru",
        sum = "h1:0hERBMJE1eitiLkihrMvRVBYAkpHzc/J3QdDN+dAcgU=",
        version = "v0.5.1",
    )
    go_repository(
        name = "com_github_hpcloud_tail",
        importpath = "github.com/hpcloud/tail",
        sum = "h1:nfCOvKYfkgYP8hkirhJocXT2+zOD8yUNjXaWfTlyFKI=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_ianlancetaylor_demangle",
        importpath = "github.com/ianlancetaylor/demangle",
        sum = "h1:mV02weKRL81bEnm8A0HT1/CAelMQDBuQIfLw8n+d6xI=",
        version = "v0.0.0-20200824232613-28f6c0f3b639",
    )
    go_repository(
        name = "com_github_jmespath_go_jmespath",
        importpath = "github.com/jmespath/go-jmespath",
        sum = "h1:BEgLn5cpjn8UN1mAw4NjwDrS35OdebyEtFe+9YPoQUg=",
        version = "v0.4.0",
    )
    go_repository(
        name = "com_github_jmespath_go_jmespath_internal_testify",
        importpath = "github.com/jmespath/go-jmespath/internal/testify",
        sum = "h1:shLQSRRSCCPj3f2gpwzGwWFoC7ycTf1rcQZHOlsJ6N8=",
        version = "v1.5.1",
    )
    go_repository(
        name = "com_github_jpillora_backoff",
        importpath = "github.com/jpillora/backoff",
        sum = "h1:uvFg412JmmHBHw7iwprIxkPMI+sGQ4kzOWsMeHnm2EA=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_json_iterator_go",
        importpath = "github.com/json-iterator/go",
        sum = "h1:PV8peI4a0ysnczrg+LtxykD8LfKY9ML6u2jnxaEnrnM=",
        version = "v1.1.12",
    )
    go_repository(
        name = "com_github_jstemmer_go_junit_report",
        importpath = "github.com/jstemmer/go-junit-report",
        sum = "h1:6QPYqodiu3GuPL+7mfx+NwDdp2eTkp9IfEUpgAwUN0o=",
        version = "v0.9.1",
    )
    go_repository(
        name = "com_github_julienschmidt_httprouter",
        importpath = "github.com/julienschmidt/httprouter",
        sum = "h1:U0609e9tgbseu3rBINet9P48AI/D3oJs4dN7jwJOQ1U=",
        version = "v1.3.0",
    )
    go_repository(
        name = "com_github_jung_kurt_gofpdf",
        importpath = "github.com/jung-kurt/gofpdf",
        sum = "h1:EroSdlP9BOoL5ssLYf3uLJXhCQMMM2fFxCJDKA3RhnA=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_kballard_go_shellquote",
        importpath = "github.com/kballard/go-shellquote",
        sum = "h1:Z9n2FFNUXsshfwJMBgNA0RU6/i7WVaAegv3PtuIHPMs=",
        version = "v0.0.0-20180428030007-95032a82bc51",
    )
    go_repository(
        name = "com_github_kisielk_errcheck",
        importpath = "github.com/kisielk/errcheck",
        sum = "h1:e8esj/e4R+SAOwFwN+n3zr0nYeCyeweozKfO23MvHzY=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_github_kisielk_gotool",
        importpath = "github.com/kisielk/gotool",
        sum = "h1:AV2c/EiW3KqPNT9ZKl07ehoAGi4C5/01Cfbblndcapg=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_klauspost_compress",
        importpath = "github.com/klauspost/compress",
        sum = "h1:Ai8UzuomSCDw90e1qNMtb15msBXsNpH6gzkkENQNcJo=",
        version = "v1.15.10",
    )
    go_repository(
        name = "com_github_konsorten_go_windows_terminal_sequences",
        importpath = "github.com/konsorten/go-windows-terminal-sequences",
        sum = "h1:CE8S1cTafDpPvMhIxNJKvHsGVBgn1xWYf1NbHQhywc8=",
        version = "v1.0.3",
    )
    go_repository(
        name = "com_github_kr_logfmt",
        importpath = "github.com/kr/logfmt",
        sum = "h1:T+h1c/A9Gawja4Y9mFVWj2vyii2bbUNDw3kt9VxK2EY=",
        version = "v0.0.0-20140226030751-b84e30acd515",
    )
    go_repository(
        name = "com_github_kr_pretty",
        importpath = "github.com/kr/pretty",
        sum = "h1:WgNl7dwNpEZ6jJ9k1snq4pZsg7DOEN8hP9Xw0Tsjwk0=",
        version = "v0.3.0",
    )
    go_repository(
        name = "com_github_kr_pty",
        importpath = "github.com/kr/pty",
        sum = "h1:VkoXIwSboBpnk99O/KFauAEILuNHv5DVFKZMBN/gUgw=",
        version = "v1.1.1",
    )
    go_repository(
        name = "com_github_kr_text",
        importpath = "github.com/kr/text",
        sum = "h1:5Nx0Ya0ZqY2ygV366QzturHI13Jq95ApcVaJBhpS+AY=",
        version = "v0.2.0",
    )
    go_repository(
        name = "com_github_kylelemons_godebug",
        importpath = "github.com/kylelemons/godebug",
        sum = "h1:MtvEpTB6LX3vkb4ax0b5D2DHbNAUsen0Gx5wZoq3lV4=",
        version = "v0.0.0-20170820004349-d65d576e9348",
    )
    go_repository(
        name = "com_github_lazybeaver_xorshift",
        importpath = "github.com/lazybeaver/xorshift",
        sum = "h1:TfmftEfB1zJiDTFi3Qw1xlbEbfJPKUhEDC19clfBMb8=",
        version = "v0.0.0-20170702203709-ce511d4823dd",
    )
    go_repository(
        name = "com_github_mattn_go_colorable",
        importpath = "github.com/mattn/go-colorable",
        sum = "h1:c1ghPdyEDarC70ftn0y+A/Ee++9zz8ljHG1b13eJ0s8=",
        version = "v0.1.8",
    )
    go_repository(
        name = "com_github_mattn_go_isatty",
        importpath = "github.com/mattn/go-isatty",
        sum = "h1:wuysRhFDzyxgEmMf5xjvJ2M9dZoWAXNNr5LSBS7uHXY=",
        version = "v0.0.12",
    )
    go_repository(
        name = "com_github_matttproud_golang_protobuf_extensions",
        importpath = "github.com/matttproud/golang_protobuf_extensions",
        sum = "h1:4hp9jkHxhMHkqkrB3Ix0jegS5sx/RkqARlsWZ6pIwiU=",
        version = "v1.0.1",
    )
    go_repository(
        name = "com_github_modern_go_concurrent",
        importpath = "github.com/modern-go/concurrent",
        sum = "h1:TRLaZ9cD/w8PVh93nsPXa1VrQ6jlwL5oN8l14QlcNfg=",
        version = "v0.0.0-20180306012644-bacd9c7ef1dd",
    )
    go_repository(
        name = "com_github_modern_go_reflect2",
        importpath = "github.com/modern-go/reflect2",
        sum = "h1:xBagoLtFs94CBntxluKeaWgTMpvLxC4ur3nMaC9Gz0M=",
        version = "v1.0.2",
    )
    go_repository(
        name = "com_github_mwitkow_go_conntrack",
        importpath = "github.com/mwitkow/go-conntrack",
        sum = "h1:KUppIJq7/+SVif2QVs3tOP0zanoHgBEVAwHxUSIzRqU=",
        version = "v0.0.0-20190716064945-2f068394615f",
    )
    go_repository(
        name = "com_github_nxadm_tail",
        importpath = "github.com/nxadm/tail",
        sum = "h1:nPr65rt6Y5JFSKQO7qToXr7pePgD6Gwiw05lkbyAQTE=",
        version = "v1.4.8",
    )
    go_repository(
        name = "com_github_oneofone_xxhash",
        importpath = "github.com/OneOfOne/xxhash",
        sum = "h1:KMrpdQIwFcEqXDklaen+P1axHaj9BSKzvpUUfnHldSE=",
        version = "v1.2.2",
    )
    go_repository(
        name = "com_github_onsi_ginkgo",
        importpath = "github.com/onsi/ginkgo",
        sum = "h1:8xi0RTUf59SOSfEtZMvwTvXYMzG4gV23XVHOZiXNtnE=",
        version = "v1.16.5",
    )
    go_repository(
        name = "com_github_onsi_gomega",
        importpath = "github.com/onsi/gomega",
        sum = "h1:M1GfJqGRrBrrGGsbxzV5dqM2U2ApXefZCQpkukxYRLE=",
        version = "v1.18.1",
    )
    go_repository(
        name = "com_github_opentracing_opentracing_go",
        importpath = "github.com/opentracing/opentracing-go",
        sum = "h1:pWlfV3Bxv7k65HYwkikxat0+s3pV4bsqf19k25Ur8rU=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_phpdave11_gofpdf",
        importpath = "github.com/phpdave11/gofpdf",
        sum = "h1:KPKiIbfwbvC/wOncwhrpRdXVj2CZTCFlw4wnoyjtHfQ=",
        version = "v1.4.2",
    )
    go_repository(
        name = "com_github_phpdave11_gofpdi",
        importpath = "github.com/phpdave11/gofpdi",
        sum = "h1:o61duiW8M9sMlkVXWlvP92sZJtGKENvW3VExs6dZukQ=",
        version = "v1.0.13",
    )
    go_repository(
        name = "com_github_pkg_diff",
        importpath = "github.com/pkg/diff",
        sum = "h1:aoZm08cpOy4WuID//EZDgcC4zIxODThtZNPirFr42+A=",
        version = "v0.0.0-20210226163009-20ebb0f2a09e",
    )
    go_repository(
        name = "com_github_pkg_errors",
        importpath = "github.com/pkg/errors",
        sum = "h1:FEBLx1zS214owpjy7qsBeixbURkuhQAwrK5UwLGTwt4=",
        version = "v0.9.1",
    )
    go_repository(
        name = "com_github_pmezard_go_difflib",
        importpath = "github.com/pmezard/go-difflib",
        sum = "h1:4DBwDE0NGyQoBHbLQYPwSUPoCMWR5BEzIk/f1lZbAQM=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_prometheus_client_golang",
        importpath = "github.com/prometheus/client_golang",
        sum = "h1:b71QUfeo5M8gq2+evJdTPfZhYMAU0uKPkyPJ7TPsloU=",
        version = "v1.13.0",
    )
    go_repository(
        name = "com_github_prometheus_client_model",
        importpath = "github.com/prometheus/client_model",
        sum = "h1:uq5h0d+GuxiXLJLNABMgp2qUWDPiLvgCzz2dUR+/W/M=",
        version = "v0.2.0",
    )
    go_repository(
        name = "com_github_prometheus_common",
        importpath = "github.com/prometheus/common",
        sum = "h1:ccBbHCgIiT9uSoFY0vX8H3zsNR5eLt17/RQLUvn8pXE=",
        version = "v0.37.0",
    )
    go_repository(
        name = "com_github_prometheus_procfs",
        importpath = "github.com/prometheus/procfs",
        sum = "h1:ODq8ZFEaYeCaZOJlZZdJA2AbQR98dSHSM1KW/You5mo=",
        version = "v0.8.0",
    )
    go_repository(
        name = "com_github_rogpeppe_fastuuid",
        importpath = "github.com/rogpeppe/fastuuid",
        sum = "h1:Ppwyp6VYCF1nvBTXL3trRso7mXMlRrw9ooo375wvi2s=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_rogpeppe_go_internal",
        importpath = "github.com/rogpeppe/go-internal",
        sum = "h1:geMPLpDpQOgVyCg5z5GoRwLHepNdb71NXb67XFkP+Eg=",
        version = "v1.8.1",
    )
    go_repository(
        name = "com_github_ruudk_golang_pdf417",
        importpath = "github.com/ruudk/golang-pdf417",
        sum = "h1:K1Xf3bKttbF+koVGaX5xngRIZ5bVjbmPnaxE/dR08uY=",
        version = "v0.0.0-20201230142125-a7e3863a1245",
    )
    go_repository(
        name = "com_github_sergi_go_diff",
        importpath = "github.com/sergi/go-diff",
        sum = "h1:we8PVUC3FE2uYfodKH/nBHMSetSfHDR6scGdBi+erh0=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_sirupsen_logrus",
        importpath = "github.com/sirupsen/logrus",
        sum = "h1:UBcNElsrwanuuMsnGSlYmtmgbb23qDR5dG+6X6Oo89I=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_github_spaolacci_murmur3",
        importpath = "github.com/spaolacci/murmur3",
        sum = "h1:qLC7fQah7D6K1B0ujays3HV9gkFtllcxhzImRR7ArPQ=",
        version = "v0.0.0-20180118202830-f09979ecbc72",
    )
    go_repository(
        name = "com_github_spf13_pflag",
        importpath = "github.com/spf13/pflag",
        sum = "h1:iy+VFUOCP1a+8yFto/drg2CJ5u0yRoB7fZw3DKv/JXA=",
        version = "v1.0.5",
    )
    go_repository(
        name = "com_github_stretchr_objx",
        importpath = "github.com/stretchr/objx",
        sum = "h1:2vfRuCMp5sSVIDSqO8oNnWJq7mPa6KVP3iPIwFBuy8A=",
        version = "v0.1.1",
    )
    go_repository(
        name = "com_github_stretchr_testify",
        importpath = "github.com/stretchr/testify",
        sum = "h1:pSgiaMZlXftHpm5L7V1+rVB+AZJydKsMxsQBIJw4PKk=",
        version = "v1.8.0",
    )
    go_repository(
        name = "com_github_yuin_goldmark",
        importpath = "github.com/yuin/goldmark",
        sum = "h1:fVcFKWvrslecOb/tg+Cc05dkeYx540o0FuFt3nUVDoE=",
        version = "v1.4.13",
    )
    go_repository(
        name = "com_google_cloud_go",
        importpath = "cloud.google.com/go",
        sum = "h1:DAq3r8y4mDgyB/ZPJ9v/5VJNqjgJAxTn6ZYLlUywOu8=",
        version = "v0.102.0",
    )
    go_repository(
        name = "com_google_cloud_go_aiplatform",
        importpath = "cloud.google.com/go/aiplatform",
        sum = "h1:D5nT9LhFKyXr8b/Ah+H3u5zSorUIQGuyymEJ85CaSjY=",
        version = "v1.22.0",
    )
    go_repository(
        name = "com_google_cloud_go_analytics",
        importpath = "cloud.google.com/go/analytics",
        sum = "h1:+d7hZrqp2IebYPliDiv4AwnUAIqVhMiXHm3G/G9l6ms=",
        version = "v0.11.0",
    )
    go_repository(
        name = "com_google_cloud_go_area120",
        importpath = "cloud.google.com/go/area120",
        sum = "h1:WTNlum1kMjhnBToR1zbvyhR9IjRnqHJ9UshTbW2P71w=",
        version = "v0.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_artifactregistry",
        importpath = "cloud.google.com/go/artifactregistry",
        sum = "h1:xAZG9+PMmr2sYXrirtNfSPUeDXTwphAyMB8Ak+zMbhA=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_asset",
        importpath = "cloud.google.com/go/asset",
        sum = "h1:Px0CZuM7u6mcDysLR2QHlEWza0tN+iSjwCtFZtBY6DA=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_assuredworkloads",
        importpath = "cloud.google.com/go/assuredworkloads",
        sum = "h1:4YrCLlal8VEyEl0NsTyUU1TZ+5yikF0UOcqMHtaoCgw=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_automl",
        importpath = "cloud.google.com/go/automl",
        sum = "h1:Av8bE5rMQxUl4SVfYsEczEJf1ftIKQOUGGzpzEYwodY=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_bigquery",
        importpath = "cloud.google.com/go/bigquery",
        sum = "h1:JuTk8po4bCKRwObdT0zLb1K0BGkGHJdtgs2GK3j2Gws=",
        version = "v1.42.0",
    )
    go_repository(
        name = "com_google_cloud_go_billing",
        importpath = "cloud.google.com/go/billing",
        sum = "h1:SHH+VeM82hsUhSvZ41QIFLO/7hL2SM6auHhCOGt9mwA=",
        version = "v1.4.0",
    )
    go_repository(
        name = "com_google_cloud_go_binaryauthorization",
        importpath = "cloud.google.com/go/binaryauthorization",
        sum = "h1:CQHsCbtttPweeGwjl0iVnGVR4a+vITzB2aqNoo7vs94=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_google_cloud_go_cloudtasks",
        importpath = "cloud.google.com/go/cloudtasks",
        sum = "h1:iamBJut/kfiaoSBiz5ehzbrLBl0okqHMDJPNHFTle6c=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_compute",
        importpath = "cloud.google.com/go/compute",
        sum = "h1:v/k9Eueb8aAJ0vZuxKMrgm6kPhCLZU9HxFU+AFDs9Uk=",
        version = "v1.7.0",
    )
    go_repository(
        name = "com_google_cloud_go_datacatalog",
        importpath = "cloud.google.com/go/datacatalog",
        sum = "h1:Q9DXHJhkRsPm+EfOj60EGlCK0VMSnd4T/BsVmY2Tmg4=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_dataflow",
        importpath = "cloud.google.com/go/dataflow",
        sum = "h1:N9KtiJFlW/J1jqlSoQorP4Dgj18z0zHbX9xLKrJzSSU=",
        version = "v0.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_dataform",
        importpath = "cloud.google.com/go/dataform",
        sum = "h1:Kj89ovEwxiRZBkx8uoRt0AaS5deR6+pfpnS3XGv9z0o=",
        version = "v0.3.0",
    )
    go_repository(
        name = "com_google_cloud_go_datalabeling",
        importpath = "cloud.google.com/go/datalabeling",
        sum = "h1:b7/y5HgaqRFUmbizVQ0yOXlAtEOkiZXUVrhKGOsBdGg=",
        version = "v0.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_dataqna",
        importpath = "cloud.google.com/go/dataqna",
        sum = "h1:bFRwi0RnhZqwKHQOQ1HQj/HTbKgAkr1D6nZF8HKOepE=",
        version = "v0.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_datastore",
        importpath = "cloud.google.com/go/datastore",
        sum = "h1:/May9ojXjRkPBNVrq+oWLqmWCkr4OU5uRY29bu0mRyQ=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_google_cloud_go_datastream",
        importpath = "cloud.google.com/go/datastream",
        sum = "h1:K29CyNY6MiTlsrJzuDrn02cpuRN+RCYefpxIbHB0K1Y=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_google_cloud_go_dialogflow",
        importpath = "cloud.google.com/go/dialogflow",
        sum = "h1:HCW+JtJ/NbLF+kAXKWbF1M1wXtcK8goOpaiVr0uEFk4=",
        version = "v1.15.0",
    )
    go_repository(
        name = "com_google_cloud_go_documentai",
        importpath = "cloud.google.com/go/documentai",
        sum = "h1:YTflsj8RJd/NougcRLc0yBpdaN/jMJ2JWAmcW29T3Xw=",
        version = "v1.7.0",
    )
    go_repository(
        name = "com_google_cloud_go_domains",
        importpath = "cloud.google.com/go/domains",
        sum = "h1:m8/VJIzCUE6pbfPM3/mfMesgxXV7wEpR/sRTRB6tC4E=",
        version = "v0.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_edgecontainer",
        importpath = "cloud.google.com/go/edgecontainer",
        sum = "h1:PS3AxjRqMu2XS01YLG/teWFQlZrP7+a+LJBj37zBMAQ=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_google_cloud_go_functions",
        importpath = "cloud.google.com/go/functions",
        sum = "h1:Oveqoadoi2f+yMpJtf1/OrwhTIzaR38l+6Q8/RPyM18=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_gaming",
        importpath = "cloud.google.com/go/gaming",
        sum = "h1:U50kYdRPcd/E7rII8IJmVYX7R/Am94/ZxNRc/vPW7ZU=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_gkeconnect",
        importpath = "cloud.google.com/go/gkeconnect",
        sum = "h1:jzwdOvCl4+xpOx2ym+mQS0XQ8kVqLQiu2hy4mmDIv5I=",
        version = "v0.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_gkehub",
        importpath = "cloud.google.com/go/gkehub",
        sum = "h1:jVq592ihBTKspBF/gTcvWQWigIEAk3zehljQDuUwAGk=",
        version = "v0.9.0",
    )
    go_repository(
        name = "com_google_cloud_go_iam",
        importpath = "cloud.google.com/go/iam",
        sum = "h1:exkAomrVUuzx9kWFI1wm3KI0uoDeUFPB4kKGzx6x+Gc=",
        version = "v0.3.0",
    )
    go_repository(
        name = "com_google_cloud_go_language",
        importpath = "cloud.google.com/go/language",
        sum = "h1:setC9wek2TmgP8VuUdaigpe2N8VUDdFz9LpWuq7FyD4=",
        version = "v1.4.0",
    )
    go_repository(
        name = "com_google_cloud_go_lifesciences",
        importpath = "cloud.google.com/go/lifesciences",
        sum = "h1:8Mf/dMyFIFicbhrh9lcTR0By2EyV4wpWxxrUmRfmUjs=",
        version = "v0.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_mediatranslation",
        importpath = "cloud.google.com/go/mediatranslation",
        sum = "h1:0SVGWly3pQ/95kvszCTbG3oYKfa1TOZTqqfxup4ktds=",
        version = "v0.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_memcache",
        importpath = "cloud.google.com/go/memcache",
        sum = "h1:sp0I8gNo9a3m/+CuGF66ssi0l01JF1qJhKbI4cOgb/E=",
        version = "v1.4.0",
    )
    go_repository(
        name = "com_google_cloud_go_metastore",
        importpath = "cloud.google.com/go/metastore",
        sum = "h1:bK+rgvvBIB1tJawmBFcWUhSnG9nNPHUe/fY8x7oFf3Q=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_networkconnectivity",
        importpath = "cloud.google.com/go/networkconnectivity",
        sum = "h1:yT8uxVTd67PvUjw9m2d589pa3yv1sJQPcQvqBga5j5o=",
        version = "v1.4.0",
    )
    go_repository(
        name = "com_google_cloud_go_networksecurity",
        importpath = "cloud.google.com/go/networksecurity",
        sum = "h1:+pHY1wntW9pu/rmlROG3oI+xfxuCUypmoKEVwsKMO/0=",
        version = "v0.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_notebooks",
        importpath = "cloud.google.com/go/notebooks",
        sum = "h1:wY4We4dMXELuQF7WPFxwODZ6bUtfS9b3+/HMWz/gwVw=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_google_cloud_go_osconfig",
        importpath = "cloud.google.com/go/osconfig",
        sum = "h1:4NmUr3p76C9vUle6qivljkZRRsEZNakXbTb3RcNkhRc=",
        version = "v1.7.0",
    )
    go_repository(
        name = "com_google_cloud_go_oslogin",
        importpath = "cloud.google.com/go/oslogin",
        sum = "h1:Q85UcQz5WLArjJX8nFLZuQ72+HtLw+xnlDuCMJESOEI=",
        version = "v1.4.0",
    )
    go_repository(
        name = "com_google_cloud_go_phishingprotection",
        importpath = "cloud.google.com/go/phishingprotection",
        sum = "h1:2JlDLzHfDbOhMLBrQeNDWXbhM8266izFwVhtRiKh77Q=",
        version = "v0.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_privatecatalog",
        importpath = "cloud.google.com/go/privatecatalog",
        sum = "h1:F+sJo8MKSDOEWwrMsUerjdawn6a9NQVG7ir+IX5XYjc=",
        version = "v0.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_pubsub",
        importpath = "cloud.google.com/go/pubsub",
        sum = "h1:ukjixP1wl0LpnZ6LWtZJ0mX5tBmjp1f8Sqer8Z2OMUU=",
        version = "v1.3.1",
    )
    go_repository(
        name = "com_google_cloud_go_recaptchaenterprise_v2",
        importpath = "cloud.google.com/go/recaptchaenterprise/v2",
        sum = "h1:8nXbhOp7SCx4oYlocSQ31jny1K0TMlcnhfh1BGGIw10=",
        version = "v2.1.0",
    )
    go_repository(
        name = "com_google_cloud_go_recommendationengine",
        importpath = "cloud.google.com/go/recommendationengine",
        sum = "h1:CR3PLwZOfNSWApMXKpMT0+zdpsJEU9ns4qNlqSBRySc=",
        version = "v0.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_recommender",
        importpath = "cloud.google.com/go/recommender",
        sum = "h1:mqy/VKIKCascBT1q+ZbgWAYOY+KKDwkRNHcBg1uk+uo=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_redis",
        importpath = "cloud.google.com/go/redis",
        sum = "h1:pP6SOq8nDUQ9bUZoHdOVRp1nX2ANfiXyadRdWquYZIQ=",
        version = "v1.7.0",
    )
    go_repository(
        name = "com_google_cloud_go_retail",
        importpath = "cloud.google.com/go/retail",
        sum = "h1:cdbsv+P0nwIv7YfcY1QfQ7bA7iWDwQ2yi3fr4vfOg9s=",
        version = "v1.8.0",
    )
    go_repository(
        name = "com_google_cloud_go_scheduler",
        importpath = "cloud.google.com/go/scheduler",
        sum = "h1:GzmMMK2+nSbuFvik9/tmju6DKmnVNOFXMW/SHZz+gt4=",
        version = "v1.4.0",
    )
    go_repository(
        name = "com_google_cloud_go_secretmanager",
        importpath = "cloud.google.com/go/secretmanager",
        sum = "h1:5v0zegRMlytVnN7J+bg5Ipqah3I2RZ67ysy00mvA+lA=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_security",
        importpath = "cloud.google.com/go/security",
        sum = "h1:176N+6wf67OA6HgqhmNN/AfmUtwq50na2VKR6/6l34k=",
        version = "v1.7.0",
    )
    go_repository(
        name = "com_google_cloud_go_securitycenter",
        importpath = "cloud.google.com/go/securitycenter",
        sum = "h1:GEWCdMuJZ8Jjm01MvjAMuLAZKvgnt0BSlREUI1zjgjQ=",
        version = "v1.13.0",
    )
    go_repository(
        name = "com_google_cloud_go_servicedirectory",
        importpath = "cloud.google.com/go/servicedirectory",
        sum = "h1:vUywoQ3ITL7Px1zSG9s/EYum+PSlHnY0zHsk7hoMt/M=",
        version = "v1.4.0",
    )
    go_repository(
        name = "com_google_cloud_go_speech",
        importpath = "cloud.google.com/go/speech",
        sum = "h1:T/FRwj5ZsImOno7dSckh05LPIvRgW8Gx2ARTeNqIqlY=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_storage",
        importpath = "cloud.google.com/go/storage",
        sum = "h1:F6IlQJZrZM++apn9V5/VfS3gbTUYg98PS3EMQAzqtfg=",
        version = "v1.22.1",
    )
    go_repository(
        name = "com_google_cloud_go_talent",
        importpath = "cloud.google.com/go/talent",
        sum = "h1:21beHmO0XsFawwzxAtWNoZln8930k737/6P5DPXAQPI=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_google_cloud_go_videointelligence",
        importpath = "cloud.google.com/go/videointelligence",
        sum = "h1:bGbQVZDdKxMhywFruluDEgQW9g5TqAgVeT+gE6WAFOs=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_vision_v2",
        importpath = "cloud.google.com/go/vision/v2",
        sum = "h1:W7DxaZ74iYxO40tYFRsfZqdOWCbUYs9fTQ8/wQNUVak=",
        version = "v2.2.0",
    )
    go_repository(
        name = "com_google_cloud_go_webrisk",
        importpath = "cloud.google.com/go/webrisk",
        sum = "h1:ng1tnznwioN3iYbHJf7rQ7mce+YmBzk8v0qX7E8YXeI=",
        version = "v1.4.0",
    )
    go_repository(
        name = "com_google_cloud_go_workflows",
        importpath = "cloud.google.com/go/workflows",
        sum = "h1:0rYwTypSlEAqaoKO5l2mIecafBvFplpjegMghkyDHdU=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_shuralyov_dmitri_go_generated",
        importpath = "dmitri.shuralyov.com/go/generated",
        sum = "h1:aVJ7xNKqudwDKOM6ynz6Y/Ii1iIgiB8YgsPU5mKWYa0=",
        version = "v0.0.0-20211227232225-c5b6cf572ec5",
    )
    go_repository(
        name = "com_shuralyov_dmitri_gpu_mtl",
        importpath = "dmitri.shuralyov.com/gpu/mtl",
        sum = "h1:VpgP7xuJadIUuKccphEpTJnWhS2jkQyMt6Y7pJCD7fY=",
        version = "v0.0.0-20190408044501-666a987793e9",
    )
    go_repository(
        name = "ht_sr_git_sbinet_gg",
        importpath = "git.sr.ht/~sbinet/gg",
        sum = "h1:LNhjNn8DerC8f9DHLz6lS0YYul/b602DUxDgGkd/Aik=",
        version = "v0.3.1",
    )
    go_repository(
        name = "in_gopkg_alecthomas_kingpin_v2",
        importpath = "gopkg.in/alecthomas/kingpin.v2",
        sum = "h1:jMFz6MfLP0/4fUyZle81rXUoxOBFi19VUFKVDOQfozc=",
        version = "v2.2.6",
    )
    go_repository(
        name = "in_gopkg_check_v1",
        importpath = "gopkg.in/check.v1",
        sum = "h1:Hei/4ADfdWqJk1ZMxUNpqntNwaWcugrBjAiHlqqRiVk=",
        version = "v1.0.0-20201130134442-10cb98267c6c",
    )
    go_repository(
        name = "in_gopkg_errgo_v2",
        importpath = "gopkg.in/errgo.v2",
        sum = "h1:0vLT13EuvQ0hNvakwLuFZ/jYrLp5F3kcWHXdRggjCE8=",
        version = "v2.1.0",
    )
    go_repository(
        name = "in_gopkg_fsnotify_v1",
        importpath = "gopkg.in/fsnotify.v1",
        sum = "h1:xOHLXZwVvI9hhs+cLKq5+I5onOuwQLhQwiu63xxlHs4=",
        version = "v1.4.7",
    )
    go_repository(
        name = "in_gopkg_tomb_v1",
        importpath = "gopkg.in/tomb.v1",
        sum = "h1:uRGJdciOHaEIrze2W8Q3AKkepLTh2hOroT7a+7czfdQ=",
        version = "v1.0.0-20141024135613-dd632973f1e7",
    )
    go_repository(
        name = "in_gopkg_yaml_v2",
        importpath = "gopkg.in/yaml.v2",
        sum = "h1:D8xgwECY7CYvx+Y2n4sBz93Jn9JRvxdiyyo8CTfuKaY=",
        version = "v2.4.0",
    )
    go_repository(
        name = "in_gopkg_yaml_v3",
        importpath = "gopkg.in/yaml.v3",
        sum = "h1:fxVm/GzAzEWqLHuvctI91KS9hhNmmWOoWu0XTYJS7CA=",
        version = "v3.0.1",
    )
    go_repository(
        name = "io_k8s_sigs_yaml",
        importpath = "sigs.k8s.io/yaml",
        sum = "h1:a2VclLzOGrwOHDiV8EfBGhvjHvP46CtW5j6POvhYGGo=",
        version = "v1.3.0",
    )
    go_repository(
        name = "io_opencensus_go",
        importpath = "go.opencensus.io",
        sum = "h1:gqCw0LfLxScz8irSi8exQc7fyQ0fKQU/qnC/X8+V/1M=",
        version = "v0.23.0",
    )
    go_repository(
        name = "io_opentelemetry_go_contrib_instrumentation_google_golang_org_grpc_otelgrpc",
        importpath = "go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc",
        sum = "h1:+jrwcA4gF8tIZmdKWgTUysKtYW2VIzywjkfgd/5OPEM=",
        version = "v0.36.0",
    )
    go_repository(
        name = "io_opentelemetry_go_contrib_propagators_b3",
        importpath = "go.opentelemetry.io/contrib/propagators/b3",
        sum = "h1:6AD2VV8edRdEYNaD8cNckpzgdMLU2kbV9OYyxt2kvCg=",
        version = "v1.10.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel",
        build_file_proto_mode = "disable",
        importpath = "go.opentelemetry.io/otel",
        sum = "h1:Y7DTJMR6zs1xkS/upamJYk0SxxN4C9AqRd77jmZnyY4=",
        version = "v1.10.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel_exporters_jaeger",
        importpath = "go.opentelemetry.io/otel/exporters/jaeger",
        sum = "h1:7W3aVVjEYayu/GOqOVF4mbTvnCuxF1wWu3eRxFGQXvw=",
        version = "v1.10.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel_exporters_otlp_internal_retry",
        importpath = "go.opentelemetry.io/otel/exporters/otlp/internal/retry",
        sum = "h1:TaB+1rQhddO1sF71MpZOZAuSPW1klK2M8XxfrBMfK7Y=",
        version = "v1.10.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel_exporters_otlp_otlptrace",
        importpath = "go.opentelemetry.io/otel/exporters/otlp/otlptrace",
        sum = "h1:pDDYmo0QadUPal5fwXoY1pmMpFcdyhXOmL5drCrI3vU=",
        version = "v1.10.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel_metric",
        importpath = "go.opentelemetry.io/otel/metric",
        sum = "h1:t+5EioN8YFXQ2EH+1j6FHCKMUj+57zIDSnSGr/mWuug=",
        version = "v0.17.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel_oteltest",
        importpath = "go.opentelemetry.io/otel/oteltest",
        sum = "h1:TyAihUowTDLqb4+m5ePAsR71xPJaTBJl4KDArIdi9k4=",
        version = "v0.17.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel_sdk",
        importpath = "go.opentelemetry.io/otel/sdk",
        sum = "h1:jZ6K7sVn04kk/3DNUdJ4mqRlGDiXAVuIG+MMENpTNdY=",
        version = "v1.10.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel_trace",
        importpath = "go.opentelemetry.io/otel/trace",
        sum = "h1:npQMbR8o7mum8uF95yFbOEJffhs1sbCOfDh8zAJiH5E=",
        version = "v1.10.0",
    )
    go_repository(
        name = "io_opentelemetry_go_proto_otlp",
        importpath = "go.opentelemetry.io/proto/otlp",
        sum = "h1:IVN6GR+mhC4s5yfcTbmzHYODqvWAp3ZedA2SJPI1Nnw=",
        version = "v0.19.0",
    )
    go_repository(
        name = "io_rsc_binaryregexp",
        importpath = "rsc.io/binaryregexp",
        sum = "h1:HfqmD5MEmC0zvwBuF187nq9mdnXjXsSivRiXN7SmRkE=",
        version = "v0.2.0",
    )
    go_repository(
        name = "io_rsc_pdf",
        importpath = "rsc.io/pdf",
        sum = "h1:k1MczvYDUvJBe93bYd7wrZLLUEcLZAuF824/I4e5Xr4=",
        version = "v0.1.1",
    )
    go_repository(
        name = "io_rsc_quote_v3",
        importpath = "rsc.io/quote/v3",
        sum = "h1:9JKUTTIUgS6kzR9mK1YuGKv6Nl+DijDNIc0ghT58FaY=",
        version = "v3.1.0",
    )
    go_repository(
        name = "io_rsc_sampler",
        importpath = "rsc.io/sampler",
        sum = "h1:7uVkIFmeBqHfdjD+gZwtXXI+RODJ2Wc4O7MPEh/QiW4=",
        version = "v1.3.0",
    )
    go_repository(
        name = "org_gioui",
        importpath = "gioui.org",
        sum = "h1:K72hopUosKG3ntOPNG4OzzbuhxGuVf06fa2la1/H/Ho=",
        version = "v0.0.0-20210308172011-57750fc8a0a6",
    )
    go_repository(
        name = "org_golang_google_api",
        importpath = "google.golang.org/api",
        sum = "h1:NMB9J4cCxs9xEm+1Z9QiO3eFvn7EnQj3Eo3hN6ugVlg=",
        version = "v0.84.0",
    )
    go_repository(
        name = "org_golang_google_appengine",
        importpath = "google.golang.org/appengine",
        sum = "h1:FZR1q0exgwxzPzp/aF+VccGrSfxfPpkBqjIIEq3ru6c=",
        version = "v1.6.7",
    )
    go_repository(
        name = "org_golang_google_genproto",
        importpath = "google.golang.org/genproto",
        sum = "h1:saaNe2+SBQxandnzcD/qB1JEBQ2Pqew+KlFLLdA/XcM=",
        version = "v0.0.0-20220923205249-dd2d53f1fffc",
    )
    go_repository(
        name = "org_golang_google_grpc",
        build_file_proto_mode = "disable",
        importpath = "google.golang.org/grpc",
        sum = "h1:WTLtQzmQori5FUH25Pq4WT22oCsv8USpQ+F6rqtsmxw=",
        version = "v1.49.0",
    )
    go_repository(
        name = "org_golang_google_grpc_cmd_protoc_gen_go_grpc",
        importpath = "google.golang.org/grpc/cmd/protoc-gen-go-grpc",
        sum = "h1:M1YKkFIboKNieVO5DLUEVzQfGwJD30Nv2jfUgzb5UcE=",
        version = "v1.1.0",
    )
    go_repository(
        name = "org_golang_google_protobuf",
        build_extra_args = [
            "-exclude=**/testdata",
        ],
        importpath = "google.golang.org/protobuf",
        sum = "h1:d0NfwRgPtno5B1Wa6L2DAG+KivqkdutMf1UhdNx175w=",
        version = "v1.28.1",
    )
    go_repository(
        name = "org_golang_x_crypto",
        importpath = "golang.org/x/crypto",
        sum = "h1:7I4JAnoQBe7ZtJcBaYHi5UtiO8tQHbUSXxL+pnGRANg=",
        version = "v0.0.0-20210921155107-089bfa567519",
    )
    go_repository(
        name = "org_golang_x_exp",
        importpath = "golang.org/x/exp",
        sum = "h1:tnebWN09GYg9OLPss1KXj8txwZc6X6uMr6VFdcGNbHw=",
        version = "v0.0.0-20220827204233-334a2380cb91",
    )
    go_repository(
        name = "org_golang_x_exp_shiny",
        importpath = "golang.org/x/exp/shiny",
        sum = "h1:pkl1Ko5DrhA4ezwKwdnmO7H1sKmMy9qLuYKRjS7SlmE=",
        version = "v0.0.0-20220722155223-a9213eeb770e",
    )
    go_repository(
        name = "org_golang_x_image",
        importpath = "golang.org/x/image",
        sum = "h1:Lj6HJGCSn5AjxRAH2+r35Mir4icalbqku+CLUtjnvXY=",
        version = "v0.0.0-20220902085622-e7cb96979f69",
    )
    go_repository(
        name = "org_golang_x_lint",
        importpath = "golang.org/x/lint",
        sum = "h1:VLliZ0d+/avPrXXH+OakdXhpJuEoBZuwh1m2j7U6Iug=",
        version = "v0.0.0-20210508222113-6edffad5e616",
    )
    go_repository(
        name = "org_golang_x_mobile",
        importpath = "golang.org/x/mobile",
        sum = "h1:4+4C/Iv2U4fMZBiMCc98MG1In4gJY5YRhtpDNeDeHWs=",
        version = "v0.0.0-20190719004257-d2bd2a29d028",
    )
    go_repository(
        name = "org_golang_x_mod",
        importpath = "golang.org/x/mod",
        sum = "h1:6zppjxzCulZykYSLyVDYbneBfbaBIQPYMevg0bEwv2s=",
        version = "v0.6.0-dev.0.20220419223038-86c51ed26bb4",
    )
    go_repository(
        name = "org_golang_x_net",
        importpath = "golang.org/x/net",
        sum = "h1:vKyz8L3zkd+xrMeIaBsQ/MNVPVFSffdaU3ZyYlBGFnI=",
        version = "v0.0.0-20220923203811-8be639271d50",
    )
    go_repository(
        name = "org_golang_x_oauth2",
        importpath = "golang.org/x/oauth2",
        sum = "h1:lxqLZaMad/dJHMFZH0NiNpiEZI/nhgWhe4wgzpE+MuA=",
        version = "v0.0.0-20220909003341-f21342109be1",
    )
    go_repository(
        name = "org_golang_x_sync",
        importpath = "golang.org/x/sync",
        sum = "h1:ZrnxWX62AgTKOSagEqxvb3ffipvEDX2pl7E1TdqLqIc=",
        version = "v0.0.0-20220923202941-7f9b1623fab7",
    )
    go_repository(
        name = "org_golang_x_sys",
        importpath = "golang.org/x/sys",
        sum = "h1:h+EGohizhe9XlX18rfpa8k8RAc5XyaeamM+0VHRd4lc=",
        version = "v0.0.0-20220919091848-fb04ddd9f9c8",
    )
    go_repository(
        name = "org_golang_x_term",
        importpath = "golang.org/x/term",
        sum = "h1:JGgROgKl9N8DuW20oFS5gxc+lE67/N3FcwmBPMe7ArY=",
        version = "v0.0.0-20210927222741-03fcf44c2211",
    )
    go_repository(
        name = "org_golang_x_text",
        importpath = "golang.org/x/text",
        sum = "h1:olpwvP2KacW1ZWvsR7uQhoyTYvKAupfQrRGBFM352Gk=",
        version = "v0.3.7",
    )
    go_repository(
        name = "org_golang_x_time",
        importpath = "golang.org/x/time",
        sum = "h1:/5xXl8Y5W96D+TtHSlonuFqGHIWVuyCkGJLwGh9JJFs=",
        version = "v0.0.0-20191024005414-555d28b269f0",
    )
    go_repository(
        name = "org_golang_x_tools",
        build_extra_args = [
            "-exclude=**/testdata",
            "-exclude=go/packages/packagestest",
        ],
        importpath = "golang.org/x/tools",
        sum = "h1:VveCTK38A2rkS8ZqFY25HIDFscX5X9OoEhJd3quQmXU=",
        version = "v0.1.12",
    )
    go_repository(
        name = "org_golang_x_xerrors",
        importpath = "golang.org/x/xerrors",
        sum = "h1:uF6paiQQebLeSXkrTqHqz0MXhXXS1KgF41eUdBNvxK0=",
        version = "v0.0.0-20220609144429-65e65417b02f",
    )
    go_repository(
        name = "org_gonum_v1_gonum",
        importpath = "gonum.org/v1/gonum",
        sum = "h1:xKuo6hzt+gMav00meVPUlXwSdoEJP46BR+wdxQEFK2o=",
        version = "v0.12.0",
    )
    go_repository(
        name = "org_gonum_v1_plot",
        importpath = "gonum.org/v1/plot",
        sum = "h1:y1ZNmfz/xHuHvtgFe8USZVyykQo5ERXPnspQNVK15Og=",
        version = "v0.12.0",
    )
    go_repository(
        name = "org_uber_go_atomic",
        importpath = "go.uber.org/atomic",
        sum = "h1:cxzIVoETapQEqDhQu3QfnvXAV4AlzcvUCxkVUFw3+EU=",
        version = "v1.4.0",
    )
    go_repository(
        name = "org_uber_go_multierr",
        importpath = "go.uber.org/multierr",
        sum = "h1:HoEmRHQPVSqub6w2z2d2EOVs2fjyFRGyofhKuyDq0QI=",
        version = "v1.1.0",
    )
    go_repository(
        name = "org_uber_go_zap",
        importpath = "go.uber.org/zap",
        sum = "h1:ORx85nbTijNz8ljznvCMR1ZBIPKFn3jQrag10X2AsuM=",
        version = "v1.10.0",
    )
