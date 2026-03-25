# ⏱ GL.iNet Radio Timer

> Simple Wi-Fi and optional cellular timer automation for GL.iNet / OpenWrt

---

## 🚀 Features

- 🕒 Interactive timer setup
- 📶 Scheduled Wi-Fi shutoff
- 📡 Optional cellular shutoff on modem-equipped models
- 🔁 Optional automatic turn-back-on time
- 📋 Service status and timer status commands
- 🧠 Works on Wi-Fi-only and Wi-Fi + cellular GL.iNet models
- ⚙️ OpenWrt `procd` service with persistent config
- 🚀 One-line install from GitHub

---

## ⚙️ What It Does

The script can:

- Turn off Wi-Fi at a user-selected time
- Turn off detected cellular interfaces at the same time when present
- Optionally turn Wi-Fi and cellular back on at a second time
- Keep the timer running as a service across restarts
- Show current timer state, remaining time, and last action

---

## 📦 Installation

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zippyy/GL.iNet-WiFi-Cellular-Timer/main/install.sh)"
```

---

## 🧰 Commands

Interactive setup:

```bash
radio-timer interactive
```

Set only the shutoff time:

```bash
radio-timer set 23:15
```

Set shutoff and automatic turn-back-on:

```bash
radio-timer set 23:15 06:30
```

Check status:

```bash
radio-timer status
```

Clear the timer:

```bash
radio-timer clear
```

Force shutoff immediately:

```bash
radio-timer run-now
```

Force turn-back-on immediately:

```bash
radio-timer run-enable-now
```

Service control:

```bash
/etc/init.d/radio-timer status
/etc/init.d/radio-timer restart
```

---

## 🧩 Behavior

- If the off time has already passed today, it rolls to tomorrow
- If the on time is earlier than or equal to the off time, it rolls to the next day after shutoff
- On Wi-Fi-only models, the script skips cellular actions automatically
- Wi-Fi is controlled with `wifi down` and `wifi up`
- Cellular interfaces are detected from `uci show network`

---

## 📁 Installed Files

- `/usr/bin/radio-timer`
- `/etc/init.d/radio-timer`
- `/etc/config/radio-timer`

---

## 📝 Notes

- Times use the router's local timezone
- Existing `/etc/config/radio-timer` is preserved by the installer
- The service is enabled automatically during install
