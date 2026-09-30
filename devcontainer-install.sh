#!/bin/bash
set -e

# Runs inside dev containers via VS Code's "dotfiles.installCommand".
# Non-interactive and Linux-only; setup.sh stays the macOS entry point.

SKILLS_REPO="https://github.com/emmvs/skills"
SKILLS_SRC="$HOME/.claude/skills-src"
SKILLS_DIR="$HOME/.claude/skills"

# ------------------------------------
# Claude Code skills
# ------------------------------------
if [ -d "$SKILLS_SRC/.git" ]; then
  echo "-----> Updating Claude Code skills"
  git -C "$SKILLS_SRC" pull --ff-only --quiet
else
  echo "-----> Cloning Claude Code skills"
  git clone --quiet "$SKILLS_REPO" "$SKILLS_SRC"
fi

mkdir -p "$SKILLS_DIR"
for skill in "$SKILLS_SRC"/*/; do
  [ -f "$skill/SKILL.md" ] || continue
  name="$(basename "$skill")"
  echo "-----> Linking skill $name"
  ln -sfn "${skill%/}" "$SKILLS_DIR/$name"
done
