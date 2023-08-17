# Goma and Buildbarn

This is an incomplete overview of the steps needed to run `goma` with `Buidlbarn`.
It is based on the [discussion in the issue] as well as private chats.
Big thanks to [Jidong Qin](https://github.com/qinjidong) for figuring it all out! 🎉

[discussion in the issue]: https://github.com/buildbarn/bb-deployments/issues/96

## Setup

1) Install google's [depot tools] to manage dependencies
   and working with `goma`.
   These are needed on PATH, but contains a lot of scripts.
   So it is best to keep them isolated and only add them to PATH
   in the terminal where you work with `goma`.

2) Install [goma client].
   We use `cipd` which comes from `depot tools`:

       $ cipd install infra/goma/client/linux-amd64 -root ~/goma

3) Checkout the [goma server].

3) We need something to build, them most common is the `chromium` project.
   With documentation available here: [build chromium] and [additional building info].

[goma client]: https://chromium.googlesource.com/infra/goma/client/
[goma server]: https://chromium.googlesource.com/infra/goma/server/

## Overview

There are a few parts in this,
`ninja` is the main buildsystem, which calls `goma`,
and a compiler wrapper, `gomacc`.

The `goma` client will itself spin up two background tasks:
a `http_proxy` that connects the client to the server,
you'll notice that the ports used for the client point to this proxy,
which in-turn talks to the `goma` server, `rbe proxy`.

The `compiler proxy` too is central in this,
it includes a detailed web-page for all compile actions,
and their errors as well as server logs (info, warn, error).

    ninja

        ->  goma client
            -> http_proxy
                -> compiler_proxy

                    -> goma server (rbe proxy)
                        -> Buildbarn

## Patches

`goma` is designed to work with Google infrastructure
and authentication.
We do not use either, but there are no feature flags for this behavior,
so we must patch three components.

### Patch the client

We cut off the authentication code in `goma_auth.py`
I did it in the client repository, but it is easier to just install with `cipd`.


    goma $ git diff
    diff --git a/client/goma_auth.py b/client/goma_auth.py
    index 5cc674d..e5425e9 100755
    --- a/client/goma_auth.py
    +++ b/client/goma_auth.py
    @@ -1,574 +1,5 @@
     #!/usr/bin/env python3

     -# Copyright 2015 The Goma Authors. All rights reserved.
     -if __name__ == '__main__':
     ...
     -  sys.exit(main())
     +    print("Bypassing authentication 'goma_auth.py'.")
     +    return 0



    $ cat ~/goma/bin/goma_auth.py
    #!/usr/bin/env python3

    def main():
        print("Bypassing authentication 'goma_auth.py'.")
        return 0

### Patch the remote execution proxy

First, to work with `Buildbarn` we need a simple patch,
patch the `OSFamily` platform property to lowercase.
In the `goma` server repository:

    commit 8d1ba1eb6aed0b504448f464ae365e9af705788c (HEAD)
    Author: Nils Wireklint <nils@meroton.com>
    Date:   Tue Aug 15 11:50:19 2023 +0200

        Fix OSFamily value capitalization

        In accordance with the REv2 API the standard value of the OSFamily
        platform property should be lowercase.

        See
        https://github.com/bazelbuild/remote-apis/blob/068363a3625e166056c155f6441cfb35ca8dfbf2/build/bazel/remote/execution/v2/platform.md

    diff --git a/cmd/remoteexec_proxy/main.go b/cmd/remoteexec_proxy/main.go
    index 4ab92a2..d321344 100644
    --- a/cmd/remoteexec_proxy/main.go
    +++ b/cmd/remoteexec_proxy/main.go
    @@ -412,7 +412,7 @@ func main() {
                                                            Value: *platformContainerImage,
                                                    }, {
                                                            Name:  "OSFamily",
    -                                                       Value: "Linux",
    +                                                       Value: "linux",
                                                    },
                                            },
                                    },
    {

Run the `goma` server (to proxy to RBE):

    goma/server $ go run \
        cmd/remoteexec_proxy/main.go \
        -port 5050 \
        -remoteexec-addr localhost:8980 \
        -remote-instance-name "hardlinking" \
        -platform-container-image 'docker://ghcr.io/catthehacker/ubuntu:act-22.04@sha256:5f9c35c25db1d51a8ddaae5c0ba8d3c163c5e9a4a6cc97acd409ac7eae239448' \
        -insecure-remoteexec

The container image platform property is set on the command line.
This should say that it is running, accepts you and can talk RBE:

    2023-08-17T11:33:40.842+0200    INFO    exec/inventory.go:190   configure platform config: target:{addr:"grpc://127.0.0.1:8980"}  build_info:{}  remoteexec_platform:{properties:{name:"container-image"  value:"docker://ghcr.io/catthehacker/ubuntu:act-22.04@sha256:5f9c35c25db1d51a8ddaae5c0ba8d3c163c5e9a4a6cc97acd409ac7eae239448"}  properties:{name:"OSFamily"  value:"linux"}  rbe_instance_basename:"hardlinking"}  dimensions:"os:linux"

### Patch the goma server

The majority of authentication and access token handling is done in the server,
so we can patch away all of that.
Following the instructions from the [bromite guide]

First create a dummy token file:

    echo "nomatter" > ~/.debug_goma_auth_file

Then patch the `goma server`:

    commit f9365d8432ad8e4cb8832b19dcec1a0301f634f8 (HEAD)
    Author: Nils Wireklint <nils@meroton.com>
    Date:   Fri Aug 18 12:25:50 2023 +0200

        apply patch from bromite/discussions/1032

    diff --git a/auth/acl/checker.go b/auth/acl/checker.go
    index f225309..f70edd3 100644
    --- a/auth/acl/checker.go
    +++ b/auth/acl/checker.go
    @@ -114,6 +114,8 @@ func (c *Checker) CheckToken(ctx context.Context, token *oauth2.Token, tokenInfo

            logger := log.FromContext(ctx)

    +       return "id1", nil, nil
    +
            g, err := c.FindGroup(ctx, tokenInfo)
            if err != nil {
                    if ctx.Err() != nil {
    @@ -163,6 +165,7 @@ func (c *Checker) CheckToken(ctx context.Context, token *oauth2.Token, tokenInfo
     func checkGroup(ctx context.Context, tokenInfo *auth.TokenInfo, g *pb.Group, authDB AuthDB) (bool, error) {
            logger := log.FromContext(ctx)
            logger.Debugf("checking group:%s", g.Id)
    +       return true, nil
            if g.Audience != "" {
                    if tokenInfo.Audience != g.Audience {
                            logger.Debugf("audience mismatch: %s != %s", tokenInfo.Audience, g.Audience)
    diff --git a/auth/client.go b/auth/client.go
    index 1e49076..8e5ca09 100644
    --- a/auth/client.go
    +++ b/auth/client.go
    @@ -153,6 +153,12 @@ func (a *Auth) Check(ctx context.Context, req *http.Request) (*enduser.EndUser,
            defer span.End()
            logger := log.FromContext(ctx)

    +       fake_token := &oauth2.Token{
    +               AccessToken: "",
    +               TokenType:   "",
    +       }
    +       return enduser.New("fake_email", "fake_groupid", fake_token), nil
    +
            authorization := req.Header.Get("Authorization")
            if authorization == "" {
                    logger.Warnf("no authorization header")
    diff --git a/remoteexec/exec.go b/remoteexec/exec.go
    index 251b5e9..a5515d8 100644
    --- a/remoteexec/exec.go
    +++ b/remoteexec/exec.go
    @@ -604,6 +604,7 @@ func (r *request) newInputTree(ctx context.Context) *gomapb.ExecResp {
            }

            symAbsOk := r.f.capabilities.GetCacheCapabilities().GetSymlinkAbsolutePathStrategy() == rpb.SymlinkAbsolutePathStrategy_ALLOWED
    +       symAbsOk = true

            cmdCleanCWD := cleanCWD
            cmdCleanRootDir := cleanRootDir
    :
    commit f9365d8432ad8e4cb8832b19dcec1a0301f634f8 (HEAD)
    Author: Nils Wireklint <nils@meroton.com>
    Date:   Fri Aug 18 12:25:50 2023 +0200

        apply patch from bromite/discussions/1032

    diff --git a/auth/acl/checker.go b/auth/acl/checker.go
    index f225309..f70edd3 100644
    --- a/auth/acl/checker.go
    +++ b/auth/acl/checker.go
    @@ -114,6 +114,8 @@ func (c *Checker) CheckToken(ctx context.Context, token *oauth2.Token, tokenInfo

            logger := log.FromContext(ctx)

    +       return "id1", nil, nil
    +
            g, err := c.FindGroup(ctx, tokenInfo)
            if err != nil {
                    if ctx.Err() != nil {
    @@ -163,6 +165,7 @@ func (c *Checker) CheckToken(ctx context.Context, token *oauth2.Token, tokenInfo
     func checkGroup(ctx context.Context, tokenInfo *auth.TokenInfo, g *pb.Group, authDB AuthDB) (bool, error) {
            logger := log.FromContext(ctx)
            logger.Debugf("checking group:%s", g.Id)
    +       return true, nil
            if g.Audience != "" {
                    if tokenInfo.Audience != g.Audience {
                            logger.Debugf("audience mismatch: %s != %s", tokenInfo.Audience, g.Audience)
    diff --git a/auth/client.go b/auth/client.go
    index 1e49076..8e5ca09 100644
    --- a/auth/client.go
    +++ b/auth/client.go
    @@ -153,6 +153,12 @@ func (a *Auth) Check(ctx context.Context, req *http.Request) (*enduser.EndUser,
            defer span.End()
            logger := log.FromContext(ctx)

    +       fake_token := &oauth2.Token{
    +               AccessToken: "",
    +               TokenType:   "",
    +       }
    +       return enduser.New("fake_email", "fake_groupid", fake_token), nil
    +
            authorization := req.Header.Get("Authorization")
            if authorization == "" {
                    logger.Warnf("no authorization header")
    diff --git a/remoteexec/exec.go b/remoteexec/exec.go
    index 251b5e9..a5515d8 100644
    --- a/remoteexec/exec.go
    +++ b/remoteexec/exec.go
    @@ -604,6 +604,7 @@ func (r *request) newInputTree(ctx context.Context) *gomapb.ExecResp {
            }

            symAbsOk := r.f.capabilities.GetCacheCapabilities().GetSymlinkAbsolutePathStrategy() == rpb.SymlinkAbsolutePathStrategy_ALLOWED
    +       symAbsOk = true

            cmdCleanCWD := cleanCWD


And start the `goma server`:

    ~/goma/goma_ctl.py start

[bromite guide]: https://github.com/bromite/bromite/discussions/1032

## Setup Chromium

Download and skip the history:

    $ fetch --nohooks --no-history chromium
    $ cd src
    $ ./build/install-build-deps.sh
    $ gclient sync

    $ gn args out/Default

## Building Chromium

    chromium/src $ export GOMA_SERVER_HOST=localhost
         export GOMA_SERVER_PORT=5050
         export GOMA_USE_SSL=false
         export GOMA_HERMETIC=error
         export GOMA_ARBITRARY_TOOLCHAIN_SUPPORT=true
         export GOMA_HTTP_AUTHORIZATION_FILE=~/.debug_goma_auth_file
         export GOMA_USE_LOCAL=false
         export GOMA_FALLBACK=true

    # generate ninja files to use goma
    $ gn gen --args="use_goma=true goma_dir=\"~/goma\" " out/Default

    $ ~/goma/goma_ctl.py start

    # build something
    $ ninja -j16 -C out/Default obj/base/base/base64.o

# Appendix

## Other guides

There are a few other guides that can give more information.
The [bromite guide] has been instrumental in handling the authentication.

Another is [goma and buildgrid], which sets up a service account to work with the authentication,
rather than patching it away.

[depot tools]: https://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_tools/docs/html/depot_tools_tutorial.html#_setting_up

[goma and buildgrid]: https://kubala.github.io/docs/setting-up-goma
[build chromium]: https://chromium.googlesource.com/infra/goma/client#how-to-use
[additional building info]: https://chromium.googlesource.com/chromium/src/+/master/docs/linux/build_instructions.md

## Technical notes for the rbe proxy

### Instance Name

The instance name is handled as a path segment,
so the empty instance name typically used will be converted to a dot ".".
So you cannot setup `Buildbarn` to have an empty instance name.
