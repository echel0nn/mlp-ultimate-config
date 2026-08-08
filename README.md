# mlp-ultimate-config

This is a repository of configuration files. That's it. That's what it is.

It was started at some point in the past by a person named echel0n, which
is me, and then it sat around collecting dust and hardcoded paths pointing
at previous owners' home directories that no longer exist on any machine,
and now some of that has been cleaned up. Not all of it. Some of it.

The letters "mlp" appear in the name of this repository. I'm not going to
explain why. If you don't like it, there's a fork button at the top of
the page.

## What's actually in here

Config files for the following:

- **xmonad**, which is a tiling window manager written in Haskell that
  compiles a 1362-line `.hs` file every time you look at it funny. The
  version in this repo is the "legacy" one. There used to be a modern
  stack-based rewrite too, but I threw it out because I got tired of
  looking at two of them.
- **xmobar**, which is the status bar that goes with xmonad. It's themed
  Tokyo Night. There are eleven other color schemes in `xmobar-tokyo-night/`
  that I do not use. They're there because deleting things feels bad.
- **kitty**, terminal. Powerline tabs on the top edge. 92% opacity so you
  can see the picom blur behind it. Cascadia Code. It has ligatures. Yes,
  I know how you feel about ligatures. I don't care.
- **nvim**, ~40 plugins loaded through vim-plug. Includes LSP via Mason,
  treesitter, cmp, nvim-dap, and various other things that I have not
  personally verified are still maintained. The color scheme is called
  `midnight8` and it's 188 KB of manually-written highlight rules.
- **picom**, compositor with blur and rounded corners. Because if my
  windows don't have 8-pixel rounded corners I cannot function.
- **dunst**, notifications. Tokyo Night. The urgency levels are color-coded.
  Critical notifications don't time out. Try not to make anything critical.
- **rofi**, launcher. Tokyo Night rasi theme. There are three wrapper
  scripts in `bin/` (`rofi-power`, `rofi-emoji`, `rofi-clip`) that I have
  not bound to any keys. That's on you.
- **bash**, prompt is [`gbt`](https://github.com/jtyr/gbt) which is written
  in Go for reasons I no longer remember. The `.bashrc` has approximately
  eighty aliases in it, most of them offensive.
- **.xprofile**, sources everything above at login time. If you don't use
  SDDM this file does nothing and you're on your own.
- Configs for `gdb`, `sddm`, GTK, GNOME Terminal (I don't use GNOME Terminal),
  Alacritty (I don't use Alacritty either), and a wallpaper JPG.

## Install

See [`INSTALL.md`](./INSTALL.md). It's 200 lines. Read it. Or don't.

Short version:

```bash
git clone https://github.com/echel0nn/mlp-ultimate-config ~/mlp-ultimate-config
cd ~/mlp-ultimate-config
# then follow INSTALL.md, which does not have an install.sh yet because
# I keep meaning to write one and then I don't
```

## Things that will bite you

- **`bin/screenshot`** used to delete `~/.xmonad/xmobar.conf`, run `maim`,
  then restore the config from a `.bak` that didn't exist on any machine
  that wasn't the original author's. So it would just delete the xmobar
  config. This is fixed now. If you find a version that isn't fixed,
  the version in this repo is the fixed one.
- **`bin/init-tilingwm`** and several other scripts used to reference
  `/home/unleashed`, `/home/echelon`, and `/home/rd`. These have been
  changed to `$HOME`. I am aware that this doesn't help you if you are
  named `unleashed`, `echelon`, or `rd`.
- **The xmobar `Font Awesome 6 Free Solid` reference** is a lie. It's not
  installed on stock Arch. Fontconfig substitutes Noto Sans, which has
  wrong glyphs in the PUA range, which means icons render as unrelated
  shapes. The `additionalFonts` block now points at `Cascadia Code NF`
  which actually exists.
- **The volume script's mute glyph** used to be `\uF6A9` which is a
  Font Awesome 7 codepoint that only exists in a woff2 file X cannot load.
  It's now `\uF026` which is in Cascadia Code NF. If you are muted, you
  will now see a speaker with an X through it, as intended.
- **The `bat` alias for `cat`** doesn't exist in this repo. `bat` adds
  file headers and a line-number gutter that turn every terminal
  copy-paste into garbage. It's installed. Type `bat` when you want it.
  Don't alias it.

## Modernization status

The repo was previously in a state I would describe as "a lot". Several
housekeeping commits happened:

- `.gitignore` now exists. Compiled `.hi` and `.o` files are no longer
  tracked. `xmonad/old/` is deleted along with `init-old.vim` and various
  `.7z` archives duplicating unpacked directories.
- `xmonad_xmobar_config_dir/` was renamed to `xmobar-tokyo-night/`
  because the old name looked like somebody sneezed on a keyboard.
- `nvim_config_files/` and `nvim_color_schemes/` are now just `nvim/`
  with a `colors/` subdirectory. That was long overdue.
- Every hardcoded `/home/(rd|echelon|unleashed|dante)/…` was replaced
  with either `$HOME` or a `$HOME`-relative path.

Things that were considered and then deferred: GNU Stow adoption,
`install.sh`, and converting init.vim to Lua with Lazy.nvim. See the
commit log if you want to know why any of this exists.

## Fonts and icons

- `ttf-jetbrains-mono-nerd`
- `ttf-cascadia-code`
- `woff2-font-awesome` (limited use — X can't load woff2, so pretend it's
  not there)
- `papirus-icon-theme`
- `capitaine-cursors`

## License

There isn't one. If you copy something from here and it breaks your
machine, that's a problem you and your machine will have to work through
together.
