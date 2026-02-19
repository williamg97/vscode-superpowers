#!/usr/bin/env bash
set -euo pipefail

# Copilot Superpowers installer
# Usage: ./install.sh /path/to/your/project

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:?Usage: $0 /path/to/target/project}"

if [ ! -d "$TARGET" ]; then
    echo "Error: Target directory does not exist: $TARGET"
    exit 1
fi

TARGET_GITHUB="$TARGET/.github"

echo "Installing Copilot Superpowers to $TARGET..."

mkdir -p "$TARGET_GITHUB/skills" "$TARGET_GITHUB/instructions" "$TARGET_GITHUB/agents"

# Copy all skills
for skill_dir in "$SCRIPT_DIR/.github/skills"/*/; do
    skill_name=$(basename "$skill_dir")
    rm -rf "${TARGET_GITHUB:?}/skills/$skill_name"
    cp -r "$skill_dir" "$TARGET_GITHUB/skills/$skill_name"
    echo "  Installed skill: $skill_name"
done

# Copy all instructions
for instr_file in "$SCRIPT_DIR/.github/instructions"/*.instructions.md; do
    cp "$instr_file" "$TARGET_GITHUB/instructions/"
    echo "  Installed instructions: $(basename "$instr_file")"
done

# Copy all agents
for agent_file in "$SCRIPT_DIR/.github/agents"/*.agent.md; do
    cp "$agent_file" "$TARGET_GITHUB/agents/"
    echo "  Installed agent: $(basename "$agent_file")"
done

# Merge copilot-instructions.md
MARKER_START="<!-- copilot-superpowers-start -->"
MARKER_END="<!-- copilot-superpowers-end -->"
SOURCE_INSTRUCTIONS="$SCRIPT_DIR/.github/copilot-instructions.md"
TARGET_INSTRUCTIONS="$TARGET_GITHUB/copilot-instructions.md"

SUPERPOWERS_CONTENT="$(cat "$SOURCE_INSTRUCTIONS")"

if [ -f "$TARGET_INSTRUCTIONS" ]; then
    if grep -q "$MARKER_START" "$TARGET_INSTRUCTIONS"; then
        # Replace existing superpowers section using perl for multiline
        perl -0777 -i -pe "s|\Q${MARKER_START}\E.*?\Q${MARKER_END}\E|${MARKER_START}\n${SUPERPOWERS_CONTENT}\n${MARKER_END}|s" "$TARGET_INSTRUCTIONS"
        echo "  Updated copilot-instructions.md (replaced existing section)"
    else
        printf '\n\n%s\n%s\n%s\n' "$MARKER_START" "$SUPERPOWERS_CONTENT" "$MARKER_END" >> "$TARGET_INSTRUCTIONS"
        echo "  Updated copilot-instructions.md (appended section)"
    fi
else
    printf '%s\n%s\n%s\n' "$MARKER_START" "$SUPERPOWERS_CONTENT" "$MARKER_END" > "$TARGET_INSTRUCTIONS"
    echo "  Created copilot-instructions.md"
fi

echo ""
echo "Done! Copilot Superpowers installed."
echo ""
echo "Skills installed:"
ls "$TARGET_GITHUB/skills/" | sed 's/^/  - /'
