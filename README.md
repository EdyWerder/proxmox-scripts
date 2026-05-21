# Proxmox Scripts

A collection of useful Proxmox maintenance scripts from [edywerder.ch](https://edywerder.ch).

---

## Scripts

### proxmox-kernel-check.sh

Checks if a reboot is needed after a Proxmox update by comparing the latest installed kernel against the currently running kernel.

**What it shows:**
- Current Proxmox version
- System uptime since last reboot
- Latest installed kernel
- Currently running kernel
- Whether a reboot is needed or not

**Usage:**

```bash
bash proxmox-kernel-check.sh
```

**Example output — no reboot needed:**

```
============================================================
 Proxmox Kernel Check — edywerder.ch
============================================================

 Proxmox Version     : pve-manager/9.0.1/...
 Last reboot         : up 2 days, 3 hours
 Check run at        : 2026-05-21 09:15:00

 Latest installed kernel : linux-image-7.0.2-6-pve
 Currently running kernel: linux-image-7.0.2-6-pve

 ✓  Kernels match. No reboot needed.

============================================================
```

**Example output — reboot needed:**

```
============================================================
 Proxmox Kernel Check — edywerder.ch
============================================================

 Proxmox Version     : pve-manager/9.0.1/...
 Last reboot         : up 2 days, 3 hours
 Check run at        : 2026-05-21 09:15:00

 Latest installed kernel : linux-image-7.0.3-1-pve
 Currently running kernel: linux-image-7.0.2-6-pve

 ⚠  Kernel mismatch detected. A reboot is recommended.

 Run 'init 6' when you are ready to reboot.

============================================================
```

**Installation:**

Copy the script to your Proxmox node via SCP:

```bash
scp proxmox-kernel-check.sh root@YOUR_PROXMOX_IP:/usr/local/bin/proxmox-kernel-check.sh
```

Make it executable:

```bash
chmod +x /usr/local/bin/proxmox-kernel-check.sh
```

Run it from anywhere:

```bash
proxmox-kernel-check.sh
```

**Disclaimer:**

This script is provided as-is without any warranty. Always ensure your VMs and containers can handle a reboot before acting on the results. Use at your own risk.

Full guide: [How to Update Proxmox Manually](https://edywerder.ch/how-to-update-proxmox/)

---

## About

These scripts are written and tested by [Edy Werder](https://edywerder.ch), a Swiss IT consultant and tech blogger covering Proxmox, Synology, mini PCs, and homelab setups.

## License

MIT License — free to use and modify.
