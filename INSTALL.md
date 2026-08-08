# Installation

Everything below assumes a base Arch install with `sudo` and network. Groups
are commented so you can skip anything you don't want.

## 1 · Core: xmonad + xmobar + desktop stack

```bash
sudo pacman -S --needed \
    xmonad xmonad-contrib xmobar                    \
    dunst picom feh unclutter xss-lock xsettingsd   \
    polkit-gnome yad libnotify                      \
    kitty alacritty pamixer pacman-contrib          \
    xorg-xset xorg-xinput xorg-xrandr xorg-xdpyinfo \
    ttf-jetbrains-mono-nerd ttf-cascadia-code       \
    woff2-font-awesome                              \
    eza fastfetch                                   \
    papirus-icon-theme capitaine-cursors            \
    rofi rofi-emoji clipmenu
```

Non-pacman:
- `paru` — build from AUR once, then use to pull `trayer-srg` and `xkb-switch`
  (both AUR-only). The xmobar `keyboard` script tolerates missing `xkb-switch`.
- `bibata-cursor-theme` (AUR) — nicer than capitaine if you have paru; otherwise
  the `capitaine-cursors` pacman package is a solid stand-in.

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
sudo pacman -S --needed rofi rofi-emoji
```

Deploy the theme to `~/.rofi/solarized-darker.rasi` (matches the launcher
binding in xmonad.hs line 247). Rofi 2.0.0's parser quirks worked around in
the shipped theme:
- No `cursor:` property (rejected)
- `highlight:` uses inline hex, not `@var` reference

## 6 · Deploy config

```bash
git clone https://github.com/echel0nn/mlp-ultimate-config ~/mlp-ultimate-config
cd ~/mlp-ultimate-config

# --- xmonad legacy (single-file, ~1362 lines, needs system xmonad + xmonad-contrib)
mkdir -p ~/.xmonad
cp -a xmonad/. ~/.xmonad/

# --- xmobar (tokyo-night is active, referenced by ~/.xmonad/xmobar.conf)
mkdir -p ~/.config/xmobar
cp -a xmobar-tokyo-night/. ~/.config/xmobar/
# legacy xmonad expects the active theme at ~/.xmonad/xmobar.conf
cp xmobar-tokyo-night/xmobar-tokyo-night.hs ~/.xmonad/xmobar.conf

# --- neovim
mkdir -p ~/.config/nvim/{lua,colors}
cp    nvim/init.vim         ~/.config/nvim/
cp    nvim/lua/terminal.lua ~/.config/nvim/lua/
cp    nvim/semshi.vim       ~/.config/nvim/
cp    nvim/colors/*.vim     ~/.config/nvim/colors/

# --- kitty
mkdir -p ~/.config/kitty
cp kitty/kitty.conf ~/.config/kitty/

# --- picom / dunst / GTK / cursor (see Section 7 for what these do)
mkdir -p ~/.config/picom ~/.config/dunst ~/.config/gtk-3.0 ~/.config/gtk-4.0 ~/.icons/default
cp picom/picom.conf          ~/.config/picom/picom.conf
cp dunst/dunstrc             ~/.config/dunst/dunstrc
cp gtk-3.0/settings.ini      ~/.config/gtk-3.0/settings.ini
cp gtk-3.0/settings.ini      ~/.config/gtk-4.0/settings.ini
cp icons/default/index.theme ~/.icons/default/index.theme

# --- rofi theme (bin/rofi-* launchers live under bin/ and are picked up via PATH)
mkdir -p ~/.rofi
cp rofi_themes/solarized-darker.rasi ~/.rofi/solarized-darker.rasi 2>/dev/null || true

# --- shell + xsession
cp .bashrc   ~/.bashrc
cp .xprofile ~/.xprofile

# --- xmonad recompile + restart (only if X is up)
command -v xmonad >/dev/null && xmonad --recompile
[ -n "$DISPLAY" ] && xmonad --restart
```

## 7 · Pimp — what the extra packages do

- **picom** — compositor: blur behind windows, 8 px rounded corners, shadows on
  floats, fade in/out, 92% opacity on inactive kitty. Config at `picom/picom.conf`,
  autostarted from `.xprofile`.
- **dunst** — notifications, tokyo-night themed, urgency-tinted frames, Papirus
  icons, 10 px rounded corners. Config at `dunst/dunstrc`, autostarted from
  `.xprofile`. Requires `libnotify` for `notify-send`.
- **papirus-icon-theme + capitaine-cursors** — GTK / Qt / dunst icon set +
  X cursor theme. Selected in `gtk-3.0/settings.ini` (also mirrored to
  `~/.config/gtk-4.0/`) and `icons/default/index.theme`.
- **eza** — modern `ls` with icons and git status. Aliases (`ls`, `ll`, `la`,
  `tree`) live in `.bashrc`. **No `bat` alias for cat** — bat's header +
  line-number gutter break copy-paste; keep `bat` invocable only when explicitly
  typed.
- **fastfetch** — one-shot system info panel; fires from `.bashrc` on
  interactive login shells (guarded by `[ -n "$PS1" ]`).
- **clipmenu** (+`clipnotify`, +`clipmenud` daemon) — clipboard history,
  200 entries. Daemon autostarted from `.xprofile`. Invoke picker via
  `rofi-clip`.
- **rofi launchers** — three wrappers in `bin/`, all tokyo-night themed via
  `~/.rofi/solarized-darker.rasi`:
  - `rofi-power` — Lock / Suspend / Reboot / Shutdown / Logout
  - `rofi-emoji` — fuzzy emoji picker → clipboard
  - `rofi-clip`  — clipmenu picker
- **kitty ligatures + opacity** — `disable_ligatures never`, `background_opacity 0.92`,
  `dynamic_background_opacity yes` at the bottom of `kitty/kitty.conf`.
  Looks best with picom's blur.

Suggested xmonad keybinds (not shipped — you own your keys):
```haskell
, ("M-x", spawn "rofi-power")
, ("M-.", spawn "rofi-emoji")
, ("M-v", spawn "rofi-clip")
```

## 8 · Vulkan on Intel (for PCSX2 / other Vulkan apps)

```bash
sudo pacman -S --needed vulkan-intel vulkan-tools mesa
sudo gpasswd -a "$USER" video
sudo gpasswd -a "$USER" render
# re-login for group membership to take effect
```
