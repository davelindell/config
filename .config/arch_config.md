# Arch Linux Installation Instructions

## Prepare live usb
- download rufus and the arch linux ISO
- use the 'dd' mode to write the ISO image to a usb stick

## Boot from the live usb and initial setup
Disable secure boot if it is enabled and boot into the usb.

### Set the default keyboard layout.
 List available layouts with
```
# ls /usr/share/kbd/keymaps/**/*.map.gz
```
and then load the proper one with
```
# loadkeys us
```

### verify the boot mode
make sure the system is booted in uefi mode with
```
# ls /sys/firmware/efi/efivars
```
this directory should exist

### update the system clock
```
# timedatectl set-ntp true
```

### partition the disks
list disks with
```
# fdisk -l
```
create the following layout using cgdisk
| Mount point | Partition | Partition type| size|
|----------------|------------|-----------|------|
| `/mnt/boot` | `/dev/sda1` | EFI system partition| 512 MB|
`/mnt` | `/dev/sda2` | Linux x86-64 root | remainder|

### format partitions
format each of the partitions to ext4 with
```
# mkfs.fat -F32 /dev/sda1
# mkfs.ext4 /dev/sda2
```

### mount file systems
```
# pacman -S dosfstools
# mount /dev/sda1 /mnt/boot # this is for the EFI partition
# mount /dev/sda2 /mnt
```
### select mirrors
look at 
```
/etc/pacman.d/mirrorlist
```
### connect to internet
```
wifi-menu
```

### install base packages
```
# pacstrap /mnt base
```


## Configure the system
### generate the fstab file

 ```
 # genfstab -U /mnt >> /mnt/etc/fstab
```
 
 ### chroot
```
# arch-chroot /mnt
```

### set timezone
```
# ln -sf /usr/share/zoneinfo/US/Pacific /etc/localtime
```
run hwclock to generate `/etc/adjtime`
```
# hwclock --systohc
```
### localization
uncomment en_US.UTF-8 UTF-8 in `/etc/locale.gen` and run
```
# locale-gen
```
create `locale.conf` and set the LANG variable
```
/etc/locale.conf
LANG=en_US.UTF-8
```
make keyboard layout persistent
```
/etc/vconsole.conf
KEYMAP=us
```
### create the swap file
```
# fallocate -l 16G /swapfile
# chmod 600 /swapfile
# mkswap /swapfile
# swapon /swapfile
# echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
# free -h
```
### initramfs
```
# mkinitcpio -p linux
```

### set root password
```
# passwd
```

### boot loader
```
# pacman -S grub efibootmgr intel-ucode
# grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
# grub-mkconfig -o /boot/grub/grub.cfg
```


### install network manager
```
# pacman -S pkgfile
# pkgfile --update
# pacman -S net-tools
# pacman -S networkmanager
# pacman -S network-manager-applet
```
reboot, start network manager and connect to network
```
systemctl start NetworkManager
systemctl enable NetworkManger
nmcli device wifi connect [SSID] password [password]
```
### create user
```
# pacman -S zsh
# useradd -m -g users -G wheel,storage,power,sys -s /bin/zsh/ lindell
# passwd lindell
# pacman -S sudo
```
allow users in wheel group to run sudo. uncomment `%wheel ALL=(ALL)ALL`
```
# EDITOR=vim visudo 
```
### configure hostname
```
/etc/hostname
myhostname
```


### install other apps
```
# pacman -S tmux
# pacman -S htop
# pacman -S vim
# pacman -S rofi
# pacman -S unzip
# pacman -S gsimplecal
# pacman -S acpi
# pacman -S sysstat
# pacman -S dmenu
# pacman -S ttf-font-awesome
# pacman -S ttf-dejavu
# pacman -S neofetch
# pacman -S neomutt
# pacman -S dunst
# pacman -S gnome-icon-theme # for dunst
# pacman -S volumeicon
# pacman -S --needed base-devel
# pacman -S git
# pacman -S transset-df
# pacman -S arandr
# pacman -S eog
# pacman -S feh
# pacman -S alsa-utils
# git clone https://aur.archlinux.org/yay.git
# cd yay
# makepkg -si
$ yay -S gotop
# pacman -S compton
$ yay -S spotify
$ yay -S google-chrome
```

### configure spotify scaling
```
~/.config/spotify/Users/YOUR-SPOTIFY-USER-NAME/prefs
app.browser.zoom-level=250
```


### enable multilib repo
uncomment these lines
```
/etc/pacman.conf
[multilib]
Include = /etc/pacman.d/mirrorlist
```
now upgrade the system

### increase terminal font size
```
# pacman -S terminus-font
```
edit `/etc/vconsole.conf` and add
```
FONT=ter-132b
```

### install intel drivers
```
# pacman -S mesa
# pacman -S mesa-demos
# pacman -S lib32-mesa
# pacman -S xf86-video-intel
# pacman -S vulkan-intel
```

### install i3 window manager
```
# pacman -S i3-wm
# pacman -S i3lock
# pacman -S i3blocks
# pacman -S xterm
# pacman -S xorg
# pacman -S xorg-fonts-misc
# pacman -S xorg-xinit
# pacman -S xorg-server
# pacman -S xorg-xclock
# pacman -S xorg-xmodmap
# pacman -S xorg-twm
# pacman -S nvidia
# pacman -S nvidia-utils
# pacman -S nvidia-settings
# pacman -S lib32-nvidia-utils
# pacman -S xf86-video-intel
# pacman -S bbswitch
# pacman -S bumblebee
# pacman -S primus
$ yay -S nvidia-xrun
# systemctl enable bumblebeed
# systemctl start bumblebeed
```
add user to bumblebee service (note that I later decided to use optimus-manager instead. 
So instead of using bumblebee, follow the instructions below for optimus-manager.
```
gpasswd -a lindell bumblebee
```

configure the `xorg.conf` file with 

```
# Xorg :0 -configure
```
and copy it from `/root/` to `/etc/X11/`


### copy config files
```
$ yay -S wpgtk
$ sudo pacman -S rsync
$ sudo pacman -S wpgtk
$ git clone --separate-git-dir=$HOME/.myconf  https://github.com/davelindell/config.git myconf-tmp
$ rsync --recursive --verbose --exclude '.git' myconf-tmp/ $HOME/
$ rm --recursive myconf-tmp
```

### set up zprezto
```
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
```

### set up vim
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

now type :PluginInstall in vim

compile youcompleteme
```
$ sudo pacman -S cmake
$ cd ~/.vim/bundle/YouCompleteMe
$ python install.py
```
### copy some config and key files over
use usb thumbdrive to copy over the following files
```
~/.config/wpg
~/.mutt
~/.ssh
```
Export pgp keys with
```
gpg --export > public_keys.pgp
gpg --export-secret-keys > private_keys.pgp
```
then copy files over to new computer and import keys with
```
gpg --import < public_keys.pgp
gpg --import < private_keys.pgp
```

### swap capslock and control
```
~/.Xmodmap
clear lock
clear control
keycode 66 = Control_L
add control = Control_L Control_R
```
modify .xinitrc
```
~/.xinitrc
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
```

### disable pc speaker (beeping in terminal)
`https://wiki.archlinux.org/index.php/PC_speaker`
add `xset -b` to `~/.xinitrc`
uncomment `set bell-style none` in `/etc/inputrc`
and put `setterm -blength 0` in `/etc/profile`.

### configure hotkeys
follow instructions at `https://wiki.archlinux.org/index.php/Xbindkeys`
create a blank `~/.xbindkeysrc` and add the following use `xbindkeys --key` to
know which key to add
```
# Increase volume
"amixer set Master 5%+"
   XF86AudioRaiseVolume
# Decrease volume
"amixer set Master 5%-"
   XF86AudioLowerVolume
# Mute volume
"amixer set Master toggle"
   XF86AudioMute
# Increase backlight
"xbacklight -inc 10"
   XF86MonBrightnessUp
# Decrease backlight
"xbacklight -dec 10"
   XF86MonBrightnessDown
```
then add `xbindkeys` to `~/.xinitrc` right before the call to `i3`.
Alternatively, use the `volumeControl.sh` or `brightnessControl.sh` scripts
here instead; these will send the notification through dunst.

also configure volumeicon settings in 
```
~/.config/volumeicon/volumeicon
```

### set up xbacklight
```
sudo pacman -S acpilight
```
`https://gitlab.com/wavexx/acpilight`

Normally, users are prohibited to alter files in the sys filesystem. It's
advisable (and recommended) to setup an "udev" rule to allow users in the
"video" group to set the display brightness.
To do so, place a file in /etc/udev/rules.d/90-backlight.rules containing:
```
SUBSYSTEM=="backlight", ACTION=="add", \
  RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness", \
  RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"
```

### configure notifications (dunst)
`https://wiki.archlinux.org/index.php/Dunst#Installation`

Launch /usr/bin/dunst and make sure your window manager or desktop environment starts it on startup/login.
An example configuration file is included at /usr/share/dunst/dunstrc. Copy this file to ~/.config/dunst/dunstrc and edit it accordingly.
make sure that the icon path includes all the desired symbols in `/usr/share/icons...`

### change touchpad sensitivity
add this to `~/.xinitrc` (get this info from `xinput list` and `input list-props <id>`
```
xinput --set-prop 'SynPS/2 Synaptics TouchPad' 'libinput Accel Speed' 1.0
```

### firewall config
```
sudo pacman -S ufw
sudo systemctl start ufw.service
sudo systemctl enable ufw.service
```
configure settings
```
# ufw default deny
# ufw allow from 192.168.0.0/24
# ufw allow from 10.0.0.0/8
# ufw limit SSH
```
this is only needed once the first time it's installed
```
# ufw enable
```

Users needing to run a VPN such as OpenVPN or WireGuard will need to adjust the DEFAULT_FORWARD_POLICY variable in /etc/default/ufw from a value of "DROP" to "ACCEPT" for proper VPN operation.

### external HDMI
follow instructions at this page https://wiki.archlinux.org/index.php/Lenovo_ThinkPad_X1_Extreme

### sound
install and configure `pulseaudio` and `pulseeffects` and `pulseaudio-alsa`.


### configure power settings
install the `tlp` package
```
# pacman -S tlp
# systemctl start tlp.service
# systemctl start tlp-sleep.service
# systemctl enable tlp.service
# systemctl enable tlp-sleep.service
# pacman -S tp_smapi
# pacman -S acpi_call
# pacman -S tpacpi-bat
```

disable power managment for gpu so bumblebee can control it
```
/etc/default/tlp
RUNTIME_PM_DRIVER_BLACKLIST="nvidia"
```
install tlpui and do configuration (set battery charge thresholds)
```
yay -S tlpui-git
```

run `sudo tlp-stat -b`, note that before I had that `tp-smapi` was disabled, 
so the battery charge thresholds weren't working. Use `tpacpi-bat` instead by
disabling `tp-smapi` in `/etc/defaults/tlp` by setting `TSMAPI_ENABLE=0`, and
setting the battery charge thresholds in `/etc/conf.d/tpacpi`. You can also
set them manually with 
```
$ sudo tpacpi-bat -v -s startThreshold 0 90
$ sudo tpacpi-bat -v -s stopThreshold 0 99
```
and re-running `tlp` with `sudo tlp start`. But before to edit the file in
`/etc/conf.d/tpacpi` to make the changes permanent.

### cpu undervolting
install `intel-undervolt`
```
yay -S intel-undervolt
```
set to -150 mV undervolt
```
/etc/intel-undervolt.conf
apply 0 'CPU' -150
apply 1 'GPU' 0
apply 2 'CPU Cache' -150
apply 3 'System Agent' 0
apply 4 'Analog I/O' 0
```
test it with 
```
intel-undervolt apply
```
once the configuration is stable enable it with
```
systemctl enable intel-undervolt.service
```

### configure fan control
```
$ yay -S thinkfan
$ sudo pacman -S lm_sensors
```
check that the module exists
```
cat /usr/lib/modprobe.d/thinkpad_acpi.conf
```
load the module
```
$ su
# modprobe thinkpad_acpi
# cat /proc/acpi/ibm/fan
```
now enable the service
```
$ sudo systemctl enable thinkfan
```
To configure the temperature thresholds, you will need to copy one of the example config files (e.g. `/usr/share/doc/thinkfan/examples/thinkfan.conf.simple`) to `/etc/thinkfan.conf`, and modify to taste. This file specifies which sensors to read, and which interface to use to control the fan.

also add the following to the `/usr/lib/systemd/system/thinkfan.service` file
```
ExecStartPre=-/sbin/modprobe thinkpad_acpi
```

### configure nvidia-xrun
 - follow guide at https://wiki.archlinux.org/index.php/Nvidia-xrun

add your `~/.xinitrc` to `~/.config/X11/nvidia-xinitrc` with the command
to start the display manager at the end. Then try running 
`nvidia-xrun` in a new super terminal window. 

### matlab and insync
install matlab and insync

### copy windows fonts
mount the windows partition
```
$ sudo pacman -S ntfs-3g
$ sudo mount /dev/nvme1n1p3 /mnt
```
copy windows font files
```
# mkdir /usr/share/fonts/WindowsFonts
# cp -r /windows/Windows/Fonts/ /usr/share/fonts/WindowsFonts
# chmod 755 /usr/share/fonts/WindowsFonts/*
```
update font cache
```
$ sudo fc-cache -f
```

### install steam
```
$ sudo pacman -S steam
```

configure rescaling with
Steam > Settings > Interface, check "Enlarge text and icons based on monitor size" (restart required)

### install cemu
```
$ yay -S cemu
```
### qemu and windows VM
install `qemu libvirt ebtables dnsmasq`

create the disk image
```
qemu-img create -f raw [image_file] 256G
```
add kernel modules and parameters, add
```
i915.enable_gvt=1
```
to `/etc/default/grub` and run `sudo grub-mkconfig -o /boot/grub/grub.cfg` and add
```
kvmgt vfio-iommu-type1 vfio-mdev
```
to `/etc/mkinitcpio.conf` and run `sudo mkinitcpio -P`. Now reboot.

get id of intel card with `lspci | grep VGA` and then see what supported vGPU types are available
```
ls -l /sys/devices/pci0000:00/0000:00:02.0/mdev_supported_types/
```

pick a type and create it with (run as root and generate uuid with `uuidgen`) 
```
echo "$GVT_GUID" > "/sys/devices/pci${GVT_DOM}/$GVT_PCI/mdev_supported_types/$GVT_TYPE/create"
```
install `virt-manager` and start and enable the `libvirtd.service`

add user to `libvirt` group
```
sudo usermod -a -G libvirt lindell
```
use the virt-manager gui to create a new virtual machine and install windows

create a configuration file to create a shared memory file on boot
```
/etc/tmpfiles.d/10-looking-glass.conf
f /dev/shm/looking-glass 0660 lindell kvm -
```
ask systemd-tmpfile sto create the shared memory file without waiting to next boot
```
# systemd-tmpfiles --create /etc/tmpfiles.d/10-looking-glass.conf
```

Open the virtual machine in `virt-manager`, and select `show virtual hardware details` set the video device type to be 'none' and remove all graphics devices.

use the saved config file (`win10.xml.bak`), replacing the uuid under 'hostdev' with the generated `$GVT_GUID`.
Now, install the looking glass client on the windows machine and on the linux machine with 

```
yay -S looking-glass
```
The windows client can be found at https://looking-glass.hostfission.com/downloads. Also install Microsoft Visual C++ Redistributable (https://visualstudio.microsoft.com/downloads/), and go into device manager and update the driver for the 
device under the "System Devices"  node for "PCI standard RAM Controller". The driver can be downloaded from
here https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/upstream-virtio/.

Finally, configure windows to not require a password to login by running 'netplwiz' from the run menu.
Uncheck 'users must enter a username and password to use this computer'. Also set up a task scheduler to run
looking-glass at login by running 'taskschd.msc'. 

Now update the xml file (`win10.xml.lookglass.bak`) to run the windows VM in a headless mode where the display
 is viewed in the linux host with looking glass. Full details on the config file can be found at https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF#Using_Looking_Glass_to_stream_guest_screen_to_the_host

Also download the virtio drivers and load them into the VM by adding a disk drive with the virtio iso. Then load the VM and install the drivers under the 'guest' folder in the ISO. After, install missing drivers in device manager from the ISO as well.

Also check to see if the virtio drivers are enabled with 
```
lsmod | grep virtio
```
If not, enable them to be loaded at bootup with
```
/etc/modules-load.d/virtio-net.conf
virtio_net
```

### fix battery stats
 add the following to `/etc/mkinitcpio.conf`
 ```
MODULES=(battery)
 ```
 sudo mkinitcpio -P

### fix audio pop on shutdown/startup
```
/etc/modprobe.d/audio_powersave.conf
options snd_hda_intel power_save=1
```
Also enable audio power saving in `/etc/default/tlp`
```
SOUND_POWER_SAVE_ON_AC=1
SOUND_POWER_SAVE_ON_BAT=1
```

### fix throttling
```
$ sudo pacman -S throttled
# systemctl enable --now lenovo_fix.service
```

### install optimus-manager
```
$ yay -S optimus-manager
$ yay -S optimus-manager-qt
$ sudo systemctl start optimus-manager.service
$ sudo systemctl enable optimus-manager.service
```
lightdm will also need to be enabled for this to work

manually shut down the nvidia card with this script

```
/home/lindell/.local/bin/disableNVIDIA
#!/bin/sh
tee /sys/bus/pci/devices/0000\:01\:00.1/remove <<<1
tee /sys/bus/pci/devices/0000\:01\:00.0/remove <<<1
```

make it so this can run without a password by adding this to the sudoers file (visudo)
```
lindell ALL = (root) NOPASSWD: /home/lindell/.local/bin/disableNVIDIA
```


### install lightdm
```
sudo pacman -S lightdm lightdm-gtk-greeter
```
adjust hidpi settings and xconfiguration by uncommenting the line `xft-dpi=150` in `/etc/lightdm/lightd-gtk-greeter.conf`
and also uncommenting `display-setup-script=/etc/lightdm/Xsetup` in `/etc/lightdm/lightdm.conf` and 
copying the `~/.xinitrc` file to `/etc/lightdm/lightdm.conf` while removing the call to the window manager
and making sure the relative paths are changed to absolute paths.

Make it easier to configure using the gui by installing `lightdm-gtk-greeter-settings`, and you can get the wallpaper
to work by adding it to `/usr/share/pixmaps`

### dual boot windows

Assuming windows already exists and you've installed linux with a different boot partition (e.g. on a different drive)
First, mount the windows partition
```
mount /dev/nvme1n1p1 /mnt
```
install `os-prober` and run 
```
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### powersaving
check if PCIE ASPM is supported with 
```
dmesg | grep -i aspm
```
you can force it to be supported by adding to `/etc/default/grub`
```
pcie_aspm=force
```

- fix i3 icons (gtk3-mushrooms)
