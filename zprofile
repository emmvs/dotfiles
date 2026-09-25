# Sourced only by interactive login shells.

# Homebrew (Apple Silicon)
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Machine-specific PATH tweaks go in ~/.machine-specific, not here.
