# Config

!> TLS is required for Cheat to work. Either enable TLS inside Cheat or 
   use a reverse proxy to serve Cheat via TLS.

Cheat tries to obtain config values from different locations in sequence. 
Properties will never be overridden. Thus, the first occurrence of a setting will be used.

#### Order

* Environment Variables
* `cheat.config.local` (in same path as the binary)
* `cheat.config` (in same path as the binary)
* `$HOME/.config/cheat/server.config`
* `/etc/cheat/server.config`

#### Config Example

[cheat.config.example](https://raw.githubusercontent.com/newtorn/cheat/master/cheat.config.example ':include :type=code ini')
