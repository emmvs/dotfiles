# Setup Day (emmvs edition) — archive

Record of my Notion page "Setup Day (emmvs edition)" (last edited 2026-04-16)
and the "VS Code" page it links to (last edited 2024-10-14), kept here so the
information survives even if the Notion pages are deleted or the scripts in
this repo stop working.

This file is a record. The runnable version is [`setup.sh`](setup.sh) +
[`Brewfile`](Brewfile). Where the scripts differ from the original, the
original is kept below and the difference is listed at the end.

> 💡 My personal computer setup

## 🖥️ Computer

- Apple ID
- Keyboard Settings
  - Set key repeat rate to highest
  - Set delay until repeat to highest
- Hot corner
  - Down right: desktop show

## 💻 Terminal

Base reference: <https://github.com/lewagon/setup/blob/master/macos.md>

```bash
# Install xcode commands & homebrew
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# If you see warning, run provided commands

brew update
brew upgrade git || brew install git
brew upgrade gh || brew install gh
brew upgrade glab || brew install glab
brew upgrade wget || brew install wget
brew upgrade imagemagick || brew install imagemagick
brew upgrade jq || brew install jq
brew upgrade openssl || brew install openssl
brew install htop

# Make Terminal ✨pretty✨
# Install Oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

brew install tree

# Change terminal editor from VI to code editor
git config --global core.editor "code --wait"

# Change view to all in terminal instead of opening less
git config --global core.pager "cat"
```

(The Notion block had `brew update` typed twice on one line: `brew updatebrew update`.)

`~/.zshrc` as written in Notion:

```zsh
# ------------------------------------
# Oh My Zsh Setup
# ------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# ------------------------------------
# Aliases
# ------------------------------------
alias zshconfig="open ~/.zshrc"

# Homebrew
alias brew_check="brew update && brew outdated"
alias brew_update="brew update && brew upgrade && brew cleanup"
alias brew_sweep="brew cleanup"

# Navigation
alias icloud="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/"

sl
# ------------------------------------
# Environment Variables & Paths
# ------------------------------------

# PostgreSQL (libpq) config
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/lib/pkgconfig"

# asdf via Homebrew
. "$(brew --prefix asdf)/libexec/asdf.sh"
export PATH="$HOME/.asdf/shims:$PATH"

# Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/completion.zsh.inc"
fi
```

(The bare `sl` line was in the Notion block between the aliases and the
exports. It's not a valid alias and looked like a copy-paste artifact, so it's
not in `zsh/aliases`. Nothing else was lost.)

## 🦁 Browser

```bash
brew install --cask brave-browser
brew install --cask arc
brew install --cask google-chrome
brew install --cask firefox@developer-edition
```

- Install [Momentum Dash](https://momentumdash.com/) for better concentration
  when opening a new tab
- [1Password Extension](https://chromewebstore.google.com/detail/1password-%E2%80%93-password-mana/aeblfdkhhhdcdjpifhhbdiojplfjncoa)
- [Grammarly Extension](https://chromewebstore.google.com/detail/grammarly-ai-writing-and/kbfnbcaeplbcioakkpcpgfkobkghlhen)
- [Deodorant Extension](https://chromewebstore.google.com/detail/deodorant-extra-strength/hlnhcepaohdandmgoifckialkcckfbpa)
- [ColorZilla Extension](https://www.colorzilla.com/chrome/welcome/new/?chrome/133.0.0.0/-/4.1)
- [Vue Devtools Extension](https://chromewebstore.google.com/detail/vuejs-devtools/nhdogjmejiglipccpnnnanhbledajbpd)

## 📲 App Store

- BetterSnapTool ("Bettersnap" in the Notion page) — shortcuts I set up:
  - Maximize
  - Snap window to the left
  - Snap window to the right

(The Notion toggle listed the three actions only, not the key combinations.)

## Apps

```bash
# Coding
brew install --cask visual-studio-code
brew install --cask sublime-text
brew install docker
brew install --cask rubymine
brew install --cask postman
brew install --cask bruno
brew install --cask sourcetree
brew install --cask vnc-viewer
brew install --cask iterm2

brew install --cask signal
brew install --cask telegram-desktop

brew install --cask datadog-agent

# Passwords
brew install --cask 1password
brew install --cask bitwarden

# Communcation
brew install --cask discord
brew install --cask slack
brew install --cask linear-linear
brew install --cask loom

# Notes
brew install --cask obsidian
brew install --cask notion
brew install --cask remarkable

# Desktop
brew install --cask raycast # Add profile to keep extensions when moving computers
brew install --cask vanilla
brew tap pakerwreah/calendr
brew install --cask calendr
brew install stats
brew install --cask spotify
brew install --cask timeular
brew install --cask anki
brew install --cask rize
```

## 💎 Gems & Coding

- 💻 VS Code (linked page, archived below)

```bash
gem install bundler-why
brew install tailwindcss
```

- Enable [Autocomplete](https://tcude.net/enabling-command-autocomplete-in-zsh/)
  in terminal

---

## 💻 VS Code (linked page)

### Settings

Preferences → Settings, use the search bar to find these:

- **Auto Save** ("Never forget to save again!"): set to `onFocusChange`. VS Code
  auto-saves whenever you click somewhere else on the screen.
- **Accept suggestion on enter** (VS Code's autocomplete can be super
  annoying): set to `off`. You can still accept with Tab.
- **Tab Size**: make sure it's set to `2`.

From the View menu you can also change the appearance. It's all preference:

- **View > Appearance**: the default window is a bit cluttered, so I deselect
  most of the checked boxes. Zen mode removes everything but the editor.
- **View > Panel Position > Bottom**: moves the integrated terminal to the
  bottom of the window.
- **View**: also turn on word wrap and render whitespace (shows a little dot
  for every space, which I find helpful).

Other advice from the page: VS Code is super customizable, but understand what
you change, and note any setting you change along with its default value in
case you later dislike the result.

### Extensions

Pre-installed by the Le Wagon setup:

```bash
code --install-extension ms-vscode.sublime-keybindings
code --install-extension emmanuelbeziat.vscode-great-icons
code --install-extension github.github-vscode-theme
code --install-extension MS-vsliveshare.vsliveshare
code --install-extension rebornix.ruby
code --install-extension dbaeumer.vscode-eslint
code --install-extension Rubymaniac.vscode-paste-and-indent
code --install-extension alexcvzz.vscode-sqlite
code --install-extension anteprimorac.html-end-tag-labels
```

Mine:

```bash
code --install-extension kaiwood.endwise
code --install-extension oderwat.indent-rainbow
code --install-extension formulahendry.auto-close-tag
code --install-extension formulahendry.auto-rename-tag
code --install-extension waderyan.gitblame
code --install-extension aaron-bond.better-comments
```

The same IDs are listed in [`vscode/extensions.txt`](vscode/extensions.txt).

#### General (recommended list)

1. Atom Dark Theme
2. **Auto add bracket**: helpful with HTML, automatically creates the closing
   tag whenever you create an opening tag
3. **Auto Close Tag**
4. **Auto Rename Tag**: automatically edits the closing tag when you edit the
   opening tag
5. Bracket Pair Colorizer 2
6. **Code Spell Check**: spell checker, "helpful for us dyslexics"
7. DotENV
8. **Endwise**: never forget to close the `do` ... `end`. Auto-appends `end`
   when you write `do` and press enter
9. **Git Blame**
10. Highlight Matching Tag
11. **indent-rainbow**: shows a different color for each indentation level;
    helps keep code well formatted. Note: I find it too colorful 🌈
12. **JavaScript (ES6) code snippets**: snippets to write JS faster
13. **Output Colorizer**
14. **Paste and Indent**: fixes indentation when pasting lines into VS Code
15. **Path autocomplete**: links files together (`require_relative`) by listing
    the available files when you type `/`
16. **Output Colorizer** (listed twice on the page)
17. **Rainbow CSV**: makes CSVs much more readable
18. **VS Code-gemfile**
19. **VS Code Ruby**
20. **VS Code Icons**

#### Ruby on Rails

1. **Ruby Solargraph**: intelligent code completion and documentation while
   writing code
2. **Endwise**
3. **Emmet in ERB**
4. **ERB Helper tags**
5. **ERB Formatter**
6. **ERB Linter**
7. **Rails DB Schema**
8. **Rails Fast Nav**
9. **Rails Routes Navigator**
10. **Rails Run Specs**
11. **Rubocop**

Plenty more exist; do your research and read the reviews before installing:

- [VS Code Extensions for Ruby on Rails Developers](https://dev.to/thomasvanholder/10-vs-code-extensions-for-ruby-on-rails-developers-89a)
- [Top 10 VS Code Extensions You Need RIGHT NOW](https://www.youtube.com/watch?v=80rrqS2QuBY)

---

## Where the repo differs from the original

| Original (Notion) | This repo | Why |
| --- | --- | --- |
| `brew upgrade X \|\| brew install X` per tool | `Brewfile` + `brew bundle` | One declarative list |
| `brew install docker` (CLI formula) | `cask "docker-desktop"` | Docker Desktop app; the old `docker` cask was renamed. Switch back to `brew "docker"` if you only want the CLI |
| `brew install stats` | `cask "stats"` | It's a cask |
| `brew install --cask vnc-viewer` | `cask "realvnc-connect-viewer"` | Homebrew renamed it |
| `brew install --cask linear-linear` | `cask "linear"` | Homebrew renamed it |
| `brew install openssl` | `brew "openssl@3"` | `openssl` is an alias for it |
| `brew install --cask remarkable` | not installed | No Homebrew cask exists; download from remarkable.com |
| `brew tap pakerwreah/calendr` | no tap | `calendr` is in core casks now |
| `sl` line | dropped | Not a valid alias, likely a paste artifact |
| Key repeat / hot corner as manual steps | `macos/defaults.sh` | Automated |
| VS Code settings and extensions (manual) | recorded above, `vscode/extensions.txt` | Not applied automatically |
