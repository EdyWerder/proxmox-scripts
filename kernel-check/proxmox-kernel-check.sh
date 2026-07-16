#!/bin/bash
# ============================================================
# Proxmox Kernel Check Script
# Author : Edy Werder — edywerder.ch
# Purpose: Check if a reboot is needed after a Proxmox update
#          by comparing the latest installed kernel against
#          the currently running kernel.
# Usage  : bash proxmox-kernel-check.sh
# ============================================================
# DISCLAIMER
# This script is provided as-is without any warranty.
# Always ensure your VMs and containers can handle a reboot
# before running this script in a production environment.
# Use at your own risk.
# Full guide: https://edywerder.ch/how-to-update-proxmox/
# ============================================================

echo ""
echo "============================================================"
echo " Proxmox Kernel Check — edywerder.ch"
echo "============================================================"
echo ""

# Get Proxmox version
PVE_VERSION="$(pveversion 2>/dev/null || echo 'Not available')"

# Get uptime
UPTIME="$(uptime -p 2>/dev/null || echo 'Not available')"

# Get current date and time
CHECK_TIME="$(date '+%Y-%m-%d %H:%M:%S')"

# Get the latest installed kernel
LATEST_KERNEL="$( ls -t /boot/vmlinuz-* | head -1 | sed 's#/boot/vmlinuz#linux-image#' )"

# Get the currently running kernel
RUNNING_KERNEL="$(uname -r)"

echo " Proxmox Version     : $PVE_VERSION"
echo " Last reboot         : $UPTIME"
echo " Check run at        : $CHECK_TIME"
echo ""
echo " Latest installed kernel : $LATEST_KERNEL"
echo " Currently running kernel: linux-image-$RUNNING_KERNEL"
echo ""

# Compare the two
if echo "$LATEST_KERNEL" | grep -qv "$RUNNING_KERNEL"; then
    echo " ⚠  Kernel mismatch detected. A reboot is recommended."
    echo ""
    echo " Run 'init 6' when you are ready to reboot."
else
    echo " ✓  Kernels match. No reboot needed."
fi

echo ""
echo "============================================================"
echo ""
