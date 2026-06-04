export OP_PLUGIN_ALIASES_SOURCED=1
if [[ -z "$CLAUDE_SESSION" ]]; then
  alias gh="op plugin run -- gh"
fi
alias claude="op run --env-file=\"${HOME}/.config/op/env\" -- $(brew --prefix)/bin/claude"
