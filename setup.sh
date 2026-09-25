#!/bin/bash
set -e

CURRENT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [[ "$(uname)" != "Darwin" ]]; then
  echo "This setup is macOS-only. Exiting."
  exit 1
fi

# Move `target` to `target.backup` if it exists and isn't already a symlink
backup() {
  target=$1
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    mv "$target" "$target.backup"
    echo "-----> Moved your old $target to $target.backup"
  fi
}

symlink() {
  file=$1
  link=$2
  if [ ! -e "$link" ]; then
    echo "-----> Symlinking $link"
    ln -s "$file" "$link"
  fi
}

# ------------------------------------
# Xcode command line tools & Homebrew
# ------------------------------------
if ! xcode-select -p &>/dev/null; then
  echo "-----> Installing Xcode command line tools (finish the dialog, then re-run ./setup.sh)"
  xcode-select --install
  exit 0
fi

if ! command -v brew &>/dev/null; then
  echo "-----> Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "-----> Installing packages from Brewfile"
brew bundle --file="$CURRENT_DIR/Brewfile"

# ------------------------------------
# Oh My Zsh + plugins
# ------------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "-----> Installing Oh My Zsh"
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

ZSH_PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"
mkdir -p "$ZSH_PLUGINS_DIR"
if [ ! -d "$ZSH_PLUGINS_DIR/zsh-autosuggestions" ]; then
  echo "-----> Installing zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_PLUGINS_DIR/zsh-autosuggestions"
fi

# ------------------------------------
# Dotfiles symlinks
# ------------------------------------
for name in zshrc zprofile gitconfig gitignore_global; do
  backup "$HOME/.$name"
  symlink "$CURRENT_DIR/$name" "$HOME/.$name"
done

backup "$HOME/.zsh"
symlink "$CURRENT_DIR/zsh" "$HOME/.zsh"

if [ ! -e "$HOME/.machine-specific" ]; then
  echo "-----> Creating ~/.machine-specific from machine-specific.example"
  cp "$CURRENT_DIR/machine-specific.example" "$HOME/.machine-specific"
fi

# ------------------------------------
# VS Code settings
# ------------------------------------
CODE_PATH="$HOME/Library/Application Support/Code/User"
mkdir -p "$CODE_PATH"
for name in settings.json keybindings.json; do
  backup "$CODE_PATH/$name"
  symlink "$CURRENT_DIR/vscode/$name" "$CODE_PATH/$name"
done

# ------------------------------------
# macOS defaults (keyboard repeat, hot corner)
# ------------------------------------
echo "-----> Applying macOS defaults"
bash "$CURRENT_DIR/macos/defaults.sh"

# ------------------------------------
# Git identity
# Written to ~/.gitconfig.local (included by gitconfig), NOT to ~/.gitconfig,
# which is a symlink into this public repo.
# ------------------------------------
if [ -z "$(git config --global --includes user.email)" ]; then
  read -r -p "Your name (for git commits): " full_name
  read -r -p "Your email (for git commits): " email
  git config --file "$HOME/.gitconfig.local" user.name "$full_name"
  git config --file "$HOME/.gitconfig.local" user.email "$email"
fi

# ------------------------------------
# Gems
# ------------------------------------
if command -v gem &>/dev/null; then
  echo "-----> Installing gems"
  gem install bundler-why
fi

cat <<'EOF'

👌 All set. Restart your terminal, or run: exec zsh

Still manual: Apple ID, browser extensions, BetterSnapTool (App Store),
Momentum Dash, Raycast profile import. See README.md.
EOF
