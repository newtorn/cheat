package cmd

import (
	"fmt"
	"os"

	"github.com/rs/zerolog/log"
	"github.com/urfave/cli"
)

func Run(appName, version, commitHash string) {
	app := cli.App{
		Name:    appName,
		Version: fmt.Sprintf("%s; %s/server@%s", version, appName, commitHash),
		Commands: []cli.Command{
			serveCmd(version),
			hashCmd,
		},
	}
	err := app.Run(os.Args)
	if err != nil {
		log.Fatal().Err(err).Msg("app error")
	}
}
