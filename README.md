<h1 align="center">rocky-rpi-headless</h1>

*<p align="center">Enable headless access to a fresh new Rocky Linux installation on a Raspberry Pi.</p>*

## About

### Why do I need that?

To be able to access the device remotely (via `ssh`) since its first boot.

Plug the network cable and the power cable and it's ready.

No need to plug the screen or keyboard into the device to do the first access.

### How it is done? 

The `rc.local` script runs after the first boot assigning the manual static IP configuration and making sure `sshd` is running.

## How to use:

1. [Download and install Rocky Linux for Raspberry Pi](https://rockylinux.org/alternative-images) (_Raspberry Pi (aarch64)_) on an SD card, following its original instructions.

***(Perform tasks "2.", "4.", "5." and "8."  using `sudo` privileges)***

2. With Rocky Linux installed on the SD card, access the `rootfs` and edit the file `/etc/rc.d/rc.local` (example: `sudo vim etc/rc.d/rc.local`) adding the following line:

```
[[ -f "/home/rocky/rocky-rpi-headless.sh" ]] && /home/rocky/rocky-rpi-headless.sh
```

3. Clone/Download this repo and copy the `rocky-rpi-headless.sh` script to `/home/rocky/` directory in the SD card's `rootfs`.

4. Edit the `/home/rocky/rocky-rpi-headless.sh` script assigning the desired values for IP, GATEWAY, and DNS addresses. 

5. Make `rc.local` and `rocky-rpi-headless.sh` (in the SD card) executable:
```
sudo chmod +x home/rocky/rocky-rpi-headless.sh
sudo chmod +x etc/rc.d/rc.local
```
_(Make sure you execute the commands above in the root directory of SD card `rootfs` partition.)_

6. Eject and remove the SD card from your computer, place it in the Raspberry Pi and turn on the device. After a few seconds, the lights might stop flashing, time to `ssh` into the device.

7. From your machine, try to `ssh` into the device using the IP address you assigned to the device and using the default Rocky Linux user `rocky` (pwd `rockylinux`) as seen in the Rocky Linux for Raspberry Pi's original instructions:

`ssh rocky@<IP-ADDRESS>`

8. If you managed to access the device, remove the `/home/rocky/rocky-rpi-headless.sh` script:

```
sudo rm ~/rocky-rpi-headless.sh
```
... and remove the line that executes this script in the `/etc/rc.d/rc.local` file.

## Debug

The script generates the file `/tmp/rc-local-log.txt` in the SD card's `rootfs` partition.

This file has output generated after the script's configuration is applied, showing:

- Connection status
- IP addresses of all network interfaces and connections
- `sshd` status
- `firewalld` allowed services

If you started the device but could not access it via `ssh`, you can power it off, remove the SD card, put it back on your computer, and inspect this file for quick insights.

You may also check `/var/log/messages` in the `rootfs` partition for general logs.

## Credits:

Inspired and/or helped by:

- https://github.com/mesca/alpine_headless
- [Skip Grube](https://git.rockylinux.org/skip)
- Ian Walker
- Neil Hannon
