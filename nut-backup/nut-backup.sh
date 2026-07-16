#!/usr/bin/env bash

# NUT configuration backup script for Proxmox VE
# Author: Edy Werder
# Website: https://edywerder.ch
# Repository: https://github.com/EdyWerder/proxmox-scripts
#
# Creates a compressed archive containing /etc/nut and useful
# diagnostic information. The resulting archive may contain secrets.
#
# License: MIT

cat >/root/create-nut-backup.sh <<'EOF'
#!/bin/bash

set -Eeuo pipefail

BACKUP_NAME="nut-backup-$(hostname)-$(date +%F-%H%M%S)"
WORK_DIR="/root/${BACKUP_NAME}"
ARCHIVE="/root/${BACKUP_NAME}.tar.gz"

cleanup_on_error() {
    echo "Backup failed."
    rm -rf "$WORK_DIR"
}
trap cleanup_on_error ERR

mkdir -p "$WORK_DIR"

cp -a /etc/nut "$WORK_DIR/"

dpkg-query -W -f='${binary:Package}\t${Version}\n' |
    grep -E '^(nut|snmp|usbutils)' \
    > "$WORK_DIR/packages.txt" || true

systemctl is-enabled \
    nut-driver@apc.service \
    nut-server.service \
    nut-monitor.service \
    > "$WORK_DIR/service-enable-state.txt" 2>&1 || true

systemctl --no-pager --full status \
    nut-driver@apc.service \
    nut-server.service \
    nut-monitor.service \
    > "$WORK_DIR/service-status.txt" 2>&1 || true

ip -br addr > "$WORK_DIR/ip-addresses.txt"
lsusb > "$WORK_DIR/lsusb.txt" 2>&1 || true
upsc apc@127.0.0.1 > "$WORK_DIR/ups-data.txt" 2>&1 || true

tar -czf "$ARCHIVE" -C /root "$BACKUP_NAME"

test -s "$ARCHIVE"
tar -tzf "$ARCHIVE" >/dev/null

rm -rf "$WORK_DIR"
trap - ERR

echo
echo "Backup created successfully:"
ls -lh "$ARCHIVE"
EOF

chmod 700 /root/create-nut-backup.sh
/root/create-nut-backup.sh
