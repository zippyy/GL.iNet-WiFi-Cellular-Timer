#!/bin/sh

set -eu

REPO_BASE="https://raw.githubusercontent.com/zippyy/GL.iNet-WiFi-Cellular-Timer/main"
TMP_DIR="/tmp/glinet-radio-timer-install.$$"

cleanup() {
	rm -rf "$TMP_DIR"
}

trap cleanup EXIT INT TERM

require_cmd() {
	command -v "$1" >/dev/null 2>&1 || {
		echo "Missing required command: $1" >&2
		exit 1
	}
}

fetch_file() {
	local path="$1"
	local dest="$2"

	if command -v curl >/dev/null 2>&1; then
		curl -fsSL "${REPO_BASE}/${path}" -o "$dest"
	elif command -v wget >/dev/null 2>&1; then
		wget -qO "$dest" "${REPO_BASE}/${path}"
	else
		echo "Neither curl nor wget is available." >&2
		exit 1
	fi
}

echo "Installing GL.iNet Radio Timer..."

require_cmd mkdir
require_cmd cp
require_cmd chmod

mkdir -p "$TMP_DIR"
mkdir -p /usr/bin /etc/init.d /etc/config

fetch_file "files/usr/bin/radio-timer" "$TMP_DIR/radio-timer"
fetch_file "files/etc/init.d/radio-timer" "$TMP_DIR/radio-timer.init"
fetch_file "files/etc/config/radio-timer" "$TMP_DIR/radio-timer.config"

cp "$TMP_DIR/radio-timer" /usr/bin/radio-timer
cp "$TMP_DIR/radio-timer.init" /etc/init.d/radio-timer
chmod 0755 /usr/bin/radio-timer /etc/init.d/radio-timer

if [ ! -f /etc/config/radio-timer ]; then
	cp "$TMP_DIR/radio-timer.config" /etc/config/radio-timer
	chmod 0644 /etc/config/radio-timer
	echo "Installed new config at /etc/config/radio-timer"
else
	echo "Keeping existing config at /etc/config/radio-timer"
fi

/etc/init.d/radio-timer enable
/etc/init.d/radio-timer restart

echo "Install complete."
echo "Run 'radio-timer interactive' to set the timer."
echo "Run '/etc/init.d/radio-timer status' to check service status."
