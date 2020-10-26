package main

import (
	"cheat/cmd"
	pmode "cheat/config/mode"
)

var (
	appName	   = "cheat"
	version    = "unknown"
	commitHash = "unknown"
	mode       = pmode.Dev
)

func main() {
	pmode.Set(mode)
	cmd.Run(appName, version, commitHash)
}
