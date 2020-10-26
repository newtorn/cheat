# Frequently Asked Questions

## Stream doesn't load

Check that
* you are using https to access Cheat.
* `CHEAT_EXTERNAL_IP` is set to your external IP. See [Configuration](config.md)
* you are using TURN for NAT-Traversal. See [NAT-Traversal](nat-traversal.md). *This isn't allowed for duxiaoman.ga, you've to self-host Cheat*
* your browser doesn't block WebRTC (extensions or other settings)
* you have opened ports in your firewall. By default 5178, 3478 and any UDP port when using TURN.
