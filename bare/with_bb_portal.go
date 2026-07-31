//go:build !freebsd && !linux_386 && !linux_arm && !windows
// +build !freebsd,!linux_386,!linux_arm,!windows

package main

func addBbPortal(bbs []buildbarnProcess) []buildbarnProcess {
	return append(bbs, buildbarnProcess{config: "_main/bare/config/portal.jsonnet", binary: "com_github_buildbarn_bb_portal+/cmd/bb_portal/bb_portal_/bb_portal"})
}
