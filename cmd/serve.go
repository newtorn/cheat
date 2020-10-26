package cmd

import (
	"cheat/auth"
	"cheat/config"
	"cheat/logger"
	"cheat/router"
	"cheat/server"
	"cheat/turn"
	"cheat/ws"
	mrand "math/rand"
	"os"
	"time"

	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
	"github.com/urfave/cli"
)

func serveCmd(version string) cli.Command {
	return cli.Command{
		Name: "serve",
		Action: func(ctx *cli.Context) {

			mrand.Seed(time.Now().Unix())
			conf, errs := config.Get()
			logger.Init(conf.LogLevel.AsZeroLogLevel())

			exit := false
			for _, err := range errs {
				log.WithLevel(err.Level).Msg(err.Msg)
				exit = exit || err.Level == zerolog.FatalLevel || err.Level == zerolog.PanicLevel
			}
			if exit {
				os.Exit(1)
			}
			users, err := auth.ReadPasswordsFile(conf.UsersFile, conf.Secret)
			if err != nil {
				log.Fatal().Str("file", conf.UsersFile).Err(err).Msg("While loading users file")
			}

			auth, err := turn.Start(conf)
			if err != nil {
				log.Fatal().Err(err).Msg("could not start turn server")
			}

			rooms := ws.NewRooms(auth, users, conf)

			go rooms.Start()

			r := router.Router(conf, rooms, users, version)
			if err := server.Start(r, conf.ServerAddress, conf.TLSCertFile, conf.TLSKeyFile); err != nil {
				log.Fatal().Err(err).Msg("http server")
			}
		},
	}
}
