# dotfiles

My personal macOS setup, based on my "Setup Day" checklist.

Everything from the original Notion notes — commands, links, VS Code settings
and extension lists — is archived in [`SETUP-DAY.md`](SETUP-DAY.md), so the
information survives even if the scripts stop working.

## Quick start

```bash
git clone https://github.com/emmvs/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

If Xcode command line tools aren't installed yet, the script triggers the
installer and exits — finish the dialog, then run `./setup.sh` again.

`setup.sh`:

- installs Homebrew and everything in [`Brewfile`](Brewfile)
- installs Oh My Zsh + `zsh-autosuggestions`
- symlinks the files below (existing real files are moved to `*.backup`)
- applies [macOS defaults](macos/defaults.sh): fastest key repeat, bottom-right
  hot corner → show desktop
- asks for your git name/email if none is set
- installs `bundler-why`

## What gets symlinked

| Repo                       | Target                                                  |
| -------------------------- | ------------------------------------------------------- |
| `zshrc`                    | `~/.zshrc`                                              |
| `zprofile`                 | `~/.zprofile`                                           |
| `zsh/`                     | `~/.zsh` (`aliases`, `exports`, sourced from `zshrc`)   |
| `gitconfig`                | `~/.gitconfig`                                          |
| `gitignore_global`         | `~/.gitignore_global`                                   |
| `vscode/settings.json`     | `~/Library/Application Support/Code/User/settings.json` |
| `vscode/keybindings.json`  | `~/Library/Application Support/Code/User/keybindings.json` |

## Manual checklist

- [ ] Sign in to Apple ID
- [ ] Verify keyboard repeat rate / delay (System Settings → Keyboard)
- [ ] Verify hot corner (bottom right → Desktop)
- [ ] Browser extensions (links in [`SETUP-DAY.md`](SETUP-DAY.md#-browser)):
      Momentum Dash, 1Password, Grammarly, Deodorant, ColorZilla, Vue Devtools
- [ ] App Store: BetterSnapTool — set shortcuts for Maximize, Snap window to
      the left, Snap window to the right
- [ ] reMarkable desktop app (no Homebrew cask; download from remarkable.com)
- [ ] Raycast: import your profile to keep extensions
- [ ] VS Code: settings and extensions from my notes (Auto Save `onFocusChange`,
      accept suggestion on enter off, tab size 2; extensions in
      [`vscode/extensions.txt`](vscode/extensions.txt))

## Updating

```bash
brew_update          # alias: brew update && brew upgrade && brew cleanup
cd ~/dotfiles && git pull
./setup.sh           # only needed if new symlinks were added
```

## Security

This repo is public, so it only holds things that are safe to publish.

Safe here: package lists, aliases, editor/pager preferences, macOS defaults.

Never committed (see [`.gitignore`](.gitignore)):

- git identity → `~/.gitconfig.local`, written by `setup.sh` and pulled in via
  `[include]` in [`gitconfig`](gitconfig). Don't run `git config --global
  user.email …` by hand — `~/.gitconfig` is a symlink into this repo, so that
  would write your email into the tracked file.
- tokens, work-only env vars, per-machine PATH tweaks → `~/.machine-specific`
  (seeded from [`machine-specific.example`](machine-specific.example))
- `.env*`, SSH keys, password-manager exports

## Credits

Structure and ideas from [lewagon/dotfiles](https://github.com/lewagon/dotfiles)
(backup-then-symlink, VS Code settings sync) and
[glsignal/dotfiles](https://github.com/glsignal/dotfiles) (`zsh/` split,
`machine-specific` overrides).
