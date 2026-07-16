NUT Backup Script for Proxmox
This script creates a single backup archive containing the complete Network UPS Tools configuration and useful diagnostic information from a Proxmox server.

What the backup contains
The archive includes:

The complete /etc/nut directory
Installed NUT, SNMP, and USB package versions
NUT service status
NUT service enablement state
Network interface information
Detected USB devices
Current UPS data from upsc
Requirements
Network UPS Tools must already be installed and configured on the Proxmox server.

Run the script as root.

Download the script
Download the script directly from GitHub:

wget -O /root/nut-backup.sh \
https://raw.githubusercontent.com/EdyWerder/proxmox-scripts/main/nut-backup.sh
