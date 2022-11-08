# ultimate-premium-diamond-elite arch linux
vim, xmonad, xmobar, bashrc, bash profile and startups


#### here is how it looks (old)

![sc-main](https://raw.githubusercontent.com/echel0nn/mlp-ultimate-config/master/screenshots/blackarch-main.png)

#### edited blackarch-old.vim little bit but not much


#### Python
![sc-main](https://raw.githubusercontent.com/echel0nn/mlp-ultimate-config/master/screenshots/blackarch_old_edited_python.png)

#### Go
![sc-main](https://raw.githubusercontent.com/echel0nn/mlp-ultimate-config/master/screenshots/blackarch_old_edited_go.png)

#### New xmobar colours and borders (19 July 2019)
![sc-main](https://raw.githubusercontent.com/echel0nn/mlp-ultimate-config/master/screenshots/screenshot_new.png)
#### New Gruvbox Colours Palette (5 Oct 2019)
![sc-main](https://raw.githubusercontent.com/echel0nn/mlp-ultimate-config/master/screenshots/gruvbox_screenshot.png)


## Further arch linux installations warnings to myself

### VMWARE ARCH LINUX INSTALLATION 

```
sudo paru -S open-vm-tools
sudo systemctl enable vmtoolsd
sudo systemctl start vmtoolsd
sudo systemctl start vmware-vmblock-fuse
sudo systemctl enable vmware-vmblock-fuse

$ cat /etc/mkinitcpio.conf
MODULES=(vsock vmw_vsock_vmci_transport vmw_balloon vmw_vmci vmwgfx)
BINARIES=()
FILES=()
HOOKS=(base udev autodetect keyboard keymap modconf block filesystems fsck)
```

### Fonts and Icons Installations 

```
nerd-fonts-complete 2.2.2-1
ttf-cascadia-code 2111.01-1
ttf-devicons 1.8.0-1
ttf-font-awesome 6.2.0-1
ttf-joypixels 7.0.0-1
```
### paru

`$ git clone https://aur.archlinux.org/paru.git`

### for neovim theme 
`$ sudo cp mlp-ultimate-config/nvim_color_schemes/midnight_better_contrast.vim /usr/share/nvim/runtime/colors/gruvbox_edited.vim`
### ctags in neovim
`$ sudo pacman -S ctags`
