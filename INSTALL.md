# Installation

Everything below assumes a base Arch install with `sudo` and network. Groups
are commented so you can skip anything you don't want.

## 1 · Core: xmonad + xmobar + desktop stack

```bash
sudo pacman -S --needed \
    xmonad xmonad-contrib xmobar                    \
    dunst picom feh unclutter xss-lock xsettingsd   \
    polkit-gnome yad                                \
    kitty alacritty pamixer pacman-contrib          \
    xorg-xset xorg-xinput xorg-xrandr xorg-xdpyinfo \
    ttf-jetbrains-mono-nerd ttf-cascadia-code       \
    woff2-font-awesome
```

Non-pacman:
- `paru` — build from AUR once, then use to pull `trayer-srg` and `xkb-switch`
  (both AUR-only). The xmobar `keyboard` script tolerates missing `xkb-switch`.

## 2 · Neovim ecosystem

```bash
sudo pacman -S --needed \
    neovim vim-plug                                  \
    nodejs npm python-black                          \
    rust rust-analyzer clang lua-language-server     \
    ripgrep fd fzf ctags xclip                       \
    tree-sitter-cli base-devel cmake ninja unzip wget
```

pynvim comes from pip on this box (`python -m pip install --user pynvim`); the
pacman `python-pynvim` also works if pip's copy isn't already present.

Node provider (for `:checkhealth provider`):
```bash
sudo npm install -g neovim
```

vim-plug bootstrap + plugin install:
```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim --headless +PlugInstall +qall
nvim --headless "+TSInstallSync bash c cmake cpp css dockerfile vimdoc html \
                                http javascript json make markdown python \
                                regex rust toml vim yaml" +qall
```

Notes:
- `nvim-treesitter` must be pinned to the `master` branch (the plugin's `main`
  branch removed the `configs` module the config uses).
- `init.vim` line ~78 (`set go+=a`) needs `silent!` on headless builds of nvim
  to avoid `E519`.
- The `require("lspconfig").X.setup {}` pattern has been migrated to
  `vim.lsp.config("X", {...})` + `vim.lsp.enable("X")` — nvim 0.11+ API.

## 3 · Bash prompt: `gbt` (Go Bullet Train)

Not in Arch repos. Fetch upstream release binary:

```bash
cd /tmp && curl -LO https://github.com/jtyr/gbt/releases/download/v2.0.0/gbt-2.0.0-linux-amd64.tar.gz
tar xzf gbt-2.0.0-linux-amd64.tar.gz
sudo install -m 755 gbt-2.0.0/gbt /usr/local/bin/gbt
sudo mkdir -p /etc/xdg/gbt
sudo cp -a gbt-2.0.0/{themes,sources} /etc/xdg/gbt/
```

`.bashrc` sets `PS1='$(gbt $?)'` and appends `[ -f ~/.fzf.bash ] && source
~/.fzf.bash` (created by the `Plug 'junegunn/fzf'` post-install).

## 4 · Lockscreen: i3lock-color (built from source)

Shadow the base `i3lock` with the color fork:

```bash
sudo pacman -S --needed autoconf automake pkgconf imagemagick \
    libxcb xcb-util xcb-util-image xcb-util-keysyms xcb-util-xrm \
    xcb-util-cursor libjpeg-turbo libxkbcommon libxkbcommon-x11 \
    pam cairo libev libxinerama xorg-xdpyinfo

git clone --depth 1 https://github.com/Raymo111/i3lock-color /tmp/i3lc
cd /tmp/i3lc
autoreconf --force --install
./configure --prefix=/usr/local --disable-sanitizers
make -j$(nproc)
sudo make install
```

`/usr/local/bin/i3lock` now takes precedence over `/usr/bin/i3lock`. The
`bin/lockscreen` script is a tokyo-night themed wrapper — solid `#131314`
background, blue→magenta→red ring, live clock, dante@lightrunner greeter.

## 5 · Rofi

```bash
sudo pacman -S --needed rofi
```

Deploy the theme to `~/.rofi/solarized-darker.rasi` (matches the launcher
binding in xmonad.hs line 247). Rofi 2.0.0's parser quirks worked around in
the shipped theme:
- No `cursor:` property (rejected)
- `highlight:` uses inline hex, not `@var` reference

## 6 · Deploy config

```bash
git clone https://github.com/echel0nn/mlp-ultimate-config ~/mlp-ultimate-config

# xmonad legacy (single-file, 1362 lines, needs system xmonad + xmonad-contrib)
mkdir -p ~/.xmonad
cp -a ~/mlp-ultimate-config/xmonad/. ~/.xmonad/

# xmobar (tokyo-night is the active theme referenced by ~/.xmonad/xmobar.conf)
mkdir -p ~/.config/xmobar
cp -a ~/mlp-ultimate-config/xmobar-tokyo-night/. ~/.config/xmobar/

# neovim
mkdir -p ~/.config/nvim/{lua,colors}
cp ~/mlp-ultimate-config/nvim/init.vim         ~/.config/nvim/
cp ~/mlp-ultimate-config/nvim/lua/terminal.lua ~/.config/nvim/lua/
cp ~/mlp-ultimate-config/nvim/semshi.vim       ~/.config/nvim/
cp ~/mlp-ultimate-config/nvim/colors/midnight8.vim    ~/.config/nvim/colors/
cp ~/mlp-ultimate-config/nvim/colors/*.vim           ~/.config/nvim/colors/

# kitty
mkdir -p ~/.config/kitty
cp ~/mlp-ultimate-config/kitty/kitty.conf ~/.config/kitty/

# bash
cp ~/mlp-ultimate-config/.bashrc ~/.bashrc

# xmonad recompile + restart
xmonad --recompile && xmonad --restart
```

## 7 · Vulkan on Intel (for PCSX2 / other Vulkan apps)

```bash
sudo pacman -S --needed vulkan-intel vulkan-tools mesa
sudo gpasswd -a "$USER" video
sudo gpasswd -a "$USER" render
# re-login for group membership to take effect
```
