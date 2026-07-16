# NUT Backup Script for Proxmox

NUT Backup Script for Proxmox This script creates a single backup archive containing the complete Network UPS Tools configuration and useful diagnostic information from a Proxmox server.

What the backup contains The archive includes:

The complete /etc/nut directory Installed NUT, SNMP, and USB package versions NUT service status NUT service enablement state Network interface information Detected USB devices Current UPS data from upsc Requirements Network UPS Tools must already be installed and configured on the Proxmox server.

## Download the script

wget -O /root/nut-backup.sh https://raw.githubusercontent.com/EdyWerder/proxmox-scripts/main/nut-backup/nut-backup.sh

## Make the script executable:

chmod 700 /root/nut-backup.sh

## Run it:

/root/nut-backup.sh

## Inspect the contents without extracting the archive:
tar -tzf "$(ls -t /root/nut-backup-*.tar.gz | head -1)"

##Extract the archive for inspection

Create a temporary folder and extract the newest backup:

mkdir -p /root/nut-backup-inspect && tar -xzf "$(ls -t /root/nut-backup-*.tar.gz | head -1)" -C /root/nut-backup-inspect
