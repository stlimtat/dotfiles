#!/usr/bin/env bash 
# PreToolUse hook: block dangerous Bash commands before execution
# The command Claude is about to run is passed via the CLAUDE_TOOL_INPUT_COMMAND env var

COMMAND="${CLAUDE_TOOL_INPUT_COMMAND:-}"

# Allow if no command provided
if [ -z "$COMMAND" ]; then
  exit 0
fi

# ─────────────────────────────────────────────
# Dangerous pattern list
# ─────────────────────────────────────────────

# 1. Filesystem destruction
if echo "$COMMAND" | grep -qE 'rm\s+-[a-z]*r[a-z]*f|rm\s+-[a-z]*f[a-z]*r'; then
  echo "[block-dangerous] Denied: 'rm -rf' command is not allowed." >&2
  echo "[block-dangerous] Alternative: Specify files to delete explicitly or move to trash." >&2
  exit 2
fi

# 2. Database table deletion
if echo "$COMMAND" | grep -qiE 'DROP\s+TABLE|DROP\s+DATABASE|TRUNCATE\s+TABLE'; then
  echo "[block-dangerous] Denied: SQL DROP/TRUNCATE commands are not allowed." >&2
  echo "[block-dangerous] Alternative: Manage schema changes through migration files." >&2
  exit 2
fi

# 3. Git force push
if echo "$COMMAND" | grep -qE 'git\s+push.*(--force|-f)'; then
  echo "[block-dangerous] Denied: 'git push --force' is not allowed." >&2
  echo "[block-dangerous] Alternative: Use 'git push --force-with-lease' or consult an admin." >&2
  exit 2
fi

# 4. Git history destruction
if echo "$COMMAND" | grep -qE 'git\s+reset\s+--hard|git\s+clean\s+-[a-z]*f'; then
  echo "[block-dangerous] Denied: 'git reset --hard' or 'git clean -f' is not allowed." >&2
  echo "[block-dangerous] Alternative: Stash your changes or ask the user for confirmation." >&2
  exit 2
fi

# 5. Deleting or overwriting environment variable files
if echo "$COMMAND" | grep -qE '(rm|>|truncate)\s+.*\.env'; then
  echo "[block-dangerous] Denied: Deleting or overwriting .env files is not allowed." >&2
  echo "[block-dangerous] Alternative: Modify .env.example or add new variables to .env.local." >&2
  exit 2
fi

# 6. Modifying system-wide global packages
if echo "$COMMAND" | grep -qE 'npm\s+install\s+-g|pnpm\s+add\s+-g|yarn\s+global'; then
  echo "[block-dangerous] Warning: Installing global packages is discouraged." >&2
  echo "[block-dangerous] Alternative: Add as a project local dependency: pnpm add -D [package]" >&2
  exit 2
fi

# All checks passed → allow
exit 0
