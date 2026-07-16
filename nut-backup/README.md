nut-backup.sh

Creates a single backup archive containing the complete NUT configuration and useful diagnostic information from a Proxmox server.

The archive includes:

/etc/nut
Installed NUT and SNMP package versions
NUT service status
Network interface information
USB device information
Current UPS data from upsc
Run the script as root:

wget -O /root/nut-backup.sh \ https://raw.githubusercontent.com/EdyWerder/proxmox-scripts/main/nut-backup/nut-backup.sh
