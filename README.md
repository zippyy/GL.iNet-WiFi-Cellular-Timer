# GL.iNet Radio Timer

Interactive OpenWrt/GL.iNet shell scripts to schedule Wi-Fi and cellular shutoff at a user-selected time, with an optional automatic turn-back-on time.

## Files

- `files/etc/init.d/radio-timer` - procd service that watches the timer.
- `files/usr/bin/radio-timer` - command interface for setting/checking/changing the timer.
- `files/etc/config/radio-timer` - UCI config used by the service.

## Install on a GL.iNet router

Copy the files to the router:

```sh
scp files/usr/bin/radio-timer root@ROUTER:/usr/bin/radio-timer
scp files/etc/init.d/radio-timer root@ROUTER:/etc/init.d/radio-timer
scp files/etc/config/radio-timer root@ROUTER:/etc/config/radio-timer
ssh root@ROUTER "chmod +x /usr/bin/radio-timer /etc/init.d/radio-timer && /etc/init.d/radio-timer enable && /etc/init.d/radio-timer start"
```

## Usage

Interactive mode:

```sh
radio-timer interactive
```

Set only the shutoff time directly:

```sh
radio-timer set 23:15
```

Set shutoff and automatic turn-back-on:

```sh
radio-timer set 23:15 06:30
```

Check current status:

```sh
radio-timer status
```

Clear the timer:

```sh
radio-timer clear
```

Force the shutoff action immediately:

```sh
radio-timer run-now
```

Force the turn-back-on action immediately:

```sh
radio-timer run-enable-now
```

Service control:

```sh
/etc/init.d/radio-timer status
/etc/init.d/radio-timer restart
```

## Notes

- Times are interpreted using the router's local timezone.
- If the entered off time has already passed today, the timer rolls forward to tomorrow.
- If an on time is earlier than or equal to the off time, it rolls forward to the next day after the shutoff time.
- Wi-Fi is disabled with `wifi down`.
- Wi-Fi is enabled with `wifi up`.
- Cellular interfaces are detected from `uci show network` and brought down with `ifdown`.
- The same detected cellular interfaces are brought back up with `ifup`.
