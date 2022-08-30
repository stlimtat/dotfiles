# vim:ft=zsh ts=2 sw=2 sts=2
#
# abnormal's Theme
# Inspired by agnoster theme and zsh2000
# https://github.com/consolemaverick/zsh2000
### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'

case ${SOLARIZED_THEME:-dark} in
    light) CURRENT_FG='white';;
    *)     CURRENT_FG='black';;
esac

ZSH_THEME_GIT_PROMPT_UNTRACKED=" ✭"
ZSH_THEME_GIT_PROMPT_DIRTY=''
ZSH_THEME_GIT_PROMPT_STASHED=' ⚑'
ZSH_THEME_GIT_PROMPT_DIVERGED=' ⚡'
ZSH_THEME_GIT_PROMPT_ADDED=" ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED=" ✹"
ZSH_THEME_GIT_PROMPT_DELETED=" ✖"
ZSH_THEME_GIT_PROMPT_RENAMED=" ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED=" ═"
ZSH_THEME_GIT_PROMPT_AHEAD=' ⬆'
ZSH_THEME_GIT_PROMPT_BEHIND=' ⬇'
ZSH_THEME_GIT_PROMPT_DIRTY=' ±'

# Special Powerline characters

() {
  local LC_ALL="" LC_CTYPE="en_US.UTF-8"
  # NOTE: This segment separator character is correct.  In 2012, Powerline changed
  # the code points they use for their special characters. This is the new code point.
  # If this is not working for you, you probably have an old version of the
  # Powerline-patched fonts installed. Download and install the new version.
  # Do not submit PRs to change this unless you have reviewed the Powerline code point
  # history and have new information.
  # This is defined using a Unicode escape sequence so it is unambiguously readable, regardless of
  # what font the user is viewing this source code in. Do not replace the
  # escape sequence with a single literal character.
  # Do not change this! Do not make it '\u2b80'; that is the old, wrong code point.
  SEGMENT_SEPARATOR_RIGHT='\ue0b2'
  SEGMENT_SEPARATOR_LEFT='\ue0b0'
}

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR_LEFT%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

prompt_segment_right() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
    echo -n "%K{$CURRENT_BG}%F{$1}$SEGMENT_SEPARATOR_RIGHT%{$bg%}%{$fg%} "
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR_LEFT"
    echo -n "\n%{%k%F{223}%}$SEGMENT_SEPARATOR_LEFT"
  else
    echo -n "%{%k%}"
    echo -n "\n%{%k%F{223}%}$SEGMENT_SEPARATOR_LEFT"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Segment 0 - Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local -a symbols

  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}${RETVAL}:✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

  [[ -n "$symbols" ]] && prompt_segment 142 234 "$symbols"
}

# Segment 2 - AWS Profile:
# - display current AWS_PROFILE name
# - displays yellow on red if profile name contains 'production' or
#   ends in '-prod'
# - displays black on green otherwise
prompt_aws() {
  [[ -z "$AWS_PROFILE" || "$SHOW_AWS_PROMPT" = false ]] && return
  case "$AWS_PROFILE" in
    *-prod|*production*) prompt_segment red yellow  "AWS: ${AWS_PROFILE:gs/%/%%}" ;;
    *) prompt_segment 241 235 "AWS: ${AWS_PROFILE:gs/%/%%}" ;;
  esac
}

# Segment 3 - Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ "$USERNAME" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment 239 223 "%n@%m"
  fi
}

# Right Segment 3 - Time: 
prompt_time() {
  prompt_segment_right 239 223 '%D{%F %T%z} '
}

# Segment 4 - Dir: current working directory
prompt_dir() {
  prompt_segment 223 239 '%~'
}

# Right Segment 4 - Virtualenv: current working virtualenv
prompt_virtualenv() {
  # This is modified for pyenv
  PYENV_VENV=$(pyenv version-name)
  if [[ -n "$PYENV_VENV" ]]; then
    prompt_segment_right 223 239 "(${PYENV_VENV})"
  fi
}

# Segment 5 - Git: branch/detached head, dirty status
prompt_git() {
  (( $+commands[git] )) || return
  if [[ "$(git config --get oh-my-zsh.hide-status 2>/dev/null)" = 1 ]]; then
    return
  fi
  local PL_BRANCH_CHAR
  () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    PL_BRANCH_CHAR=$'\ue0a0'         # 
  }
  local ref dirty mode repo_path

  if [[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]]; then
    repo_path=$(git rev-parse --git-dir 2>/dev/null)
    ref=$(plib_git_branch)
    if [[ _ref = "detached" ]]; then ref=$(plib_git_rev); fi
    dirty=$(git_dirty)
    if [[ -n "${dirty}" ]]; then
      prompt_segment 142 239
    else
      prompt_segment 142 red
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '✚'
    zstyle ':vcs_info:*' unstagedstr '±'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    echo -ne "${PL_BRANCH_CHAR}${ref}${vcs_info_msg_0_%% }${dirty}$(git_lr)"
  fi
}

# Copied from https://github.com/eendroroy/promptlib-zsh/blob/master/modules/git.zsh
plib_git_branch(){
  __ref=$(\git symbolic-ref HEAD 2>/dev/null) || __ref="detached" || return
  echo -n "${__ref#refs/heads/}"
  unset __ref
}

# Gets the short SHA-1 of the current revision.
plib_git_rev(){
  git rev-parse HEAD 2>/dev/null | cut -c 1-7 | tr -d ' \n'
}

# For everything related to git status parsing please refer to this documentation:
# https://git-scm.com/docs/git-status#_short_format

plib_git_status(){
  echo -n "$(\git status --porcelain 2>/dev/null)"
}

# Returns the number of staged file modifications.
# Takes a 'git status --porcelain 2' value as argument.
plib_git_staged_mod(){
  echo -n "$1" | grep -c '^M[A,M,D,R, ]\{1\} \|^R[A,M,D,R, ]\{1\} ' | tr -d ' '
}

# Returns the number of unstaged file modifications.
# Takes a 'git status --porcelain 2' value as argument.
plib_git_unstaged_mod(){
  echo -n "$1" | grep -c '^[A,M,D,R, ]\{1\}M \|^[A,M,D,R, ]\{1\}R ' | tr -d ' '
}

# Returns the number of staged file deletions.
# Takes a 'git status --porcelain 2' value as argument.
plib_git_staged_del(){
  echo -n "$1" | grep -c '^D[A,M,D,R, ]\{1\} ' | tr -d ' '
}

# Returns the number of unstaged file deletions.
# Takes a 'git status --porcelain 2' value as argument.
plib_git_unstaged_del(){
  echo -n "$1" | grep -c '^[A,M,D,R, ]\{1\}D ' | tr -d ' '
}

# Returns the number of staged new files.
# Takes a 'git status --porcelain 2' value as argument.
plib_git_staged_add(){
  echo -n "$1" | grep -c '^A[A,M,D,R, ]\{1\} ' | tr -d ' '
}

# Returns the number of unstaged new files.
# Takes a 'git status --porcelain 2' value as argument.
plib_git_unstaged_add(){
  echo -n "$1" | grep -c '^[A,M,D,R, ]\{1\}A ' | tr -d ' '
}

# Returns the number of unstaged untracked files.
# Takes a 'git status --porcelain 2' value as argument.
plib_git_status_new(){
  echo -n "$1" | grep -c '^?? ' | tr -d ' '
}

git_dirty(){
  GIT_TRACKED_COLOR=green
  GIT_UN_TRACKED_COLOR=red
  GIT_ADD_SYM='+'
  GIT_DEL_SYM='-'
  GIT_MOD_SYM='⭑'
  GIT_NEW_SYM='?'

  __git_status=$(plib_git_status)

  __mod_t=$(plib_git_staged_mod "$__git_status")
  __add_t=$(plib_git_staged_add "$__git_status")
  __del_t=$(plib_git_staged_del "$__git_status")

  __mod_ut=$(plib_git_unstaged_mod "$__git_status")
  __add_ut=$(plib_git_unstaged_add "$__git_status")
  __del_ut=$(plib_git_unstaged_del "$__git_status")

  __new=$(plib_git_status_new "$__git_status")

  DIRTY=''
  [[ "$__add_t" != "0" ]]  && DIRTY+="%F{$GIT_TRACKED_COLOR}${GIT_ADD_SYM}%f "
  [[ "$__add_ut" != "0" ]] && DIRTY+="%F{$GIT_UN_TRACKED_COLOR}${GIT_ADD_SYM}%f "
  [[ "$__mod_t" != "0" ]]  && DIRTY+="%F{$GIT_TRACKED_COLOR}${GIT_MOD_SYM}%f "
  [[ "$__mod_ut" != "0" ]] && DIRTY+="%F{$GIT_UN_TRACKED_COLOR}${GIT_MOD_SYM}%f "
  [[ "$__del_t" != "0" ]]  && DIRTY+="%F{$GIT_TRACKED_COLOR}${GIT_DEL_SYM}%f "
  [[ "$__del_ut" != "0" ]] && DIRTY+="%F{$GIT_UN_TRACKED_COLOR}${GIT_DEL_SYM}%f "
  [[ "$__new" != "0" ]]    && DIRTY+="%F{$GIT_UN_TRACKED_COLOR}${GIT_NEW_SYM}%f "

  echo " ${DIRTY}"

  unset __mod_ut __new_ut __add_ut __mod_t __new_t __add_t __del DIRTY
}

plib_git_stash(){
  echo -n "$(\git stash list | wc -l | tr -d ' ')"
}

# This determines how many commit behind or ahead of the target branch the current revision is.
# https://git-scm.com/docs/git-rev-list#Documentation/git-rev-list.txt---left-right
#
# It takes a remote name and a remote branch name as argument.
# Directly returns the git rev-list --left-right value or an empty string if somet:whing went wrong.
plib_git_left_right(){
  __remote_name="$1"
  [[ -z "$__remote_name" ]] && __remote_name='origin'

  __local_branch_name=$(plib_git_branch)

  if [[ "$__local_branch_name" != "detached" ]]; then

    __remote_branch_name="$2"
    [[ -z "$__remote_branch_name" ]] && __remote_branch_name="$__local_branch_name"

    git rev-list --left-right --count \
      "refs/heads/${__local_branch_name}...refs/remotes/${__remote_name}/${__remote_branch_name}" \
      2>/dev/null || echo ''

    unset __remote_branch_name
  fi

  unset __remote_name __local_branch_name
}

git_lr(){
  GIT_PUSH_SYM='↑'
  GIT_PULL_SYM='↓'

  __git_left_right=$(plib_git_left_right)

  __pull=$(echo "$__git_left_right" | awk '{print $2}' | tr -d ' \n')
  __push=$(echo "$__git_left_right" | awk '{print $1}' | tr -d ' \n')

  [[ "$__pull" != 0 ]] && [[ "$__pull" != '' ]] && __pushpull="${__pull}${GIT_PULL_SYM}"
  [[ -n "$__pushpull" ]] && __pushpull+=' '
  [[ "$__push" != 0 ]] && [[ "$__push" != '' ]] && __pushpull+="${__push}${GIT_PUSH_SYM}"

  if [[ "$__pushpull" != '' ]]; then
    echo -ne " ${__pushpull}"
  fi
}

ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT=40
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM=66
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG=red
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL=142

# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
function git_time_since_commit() {
  if [[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]]; then
    # Only proceed if there is actually a commit.
    if [[ "$(git log --pretty=oneline -1 2>&1 | awk '{ print $1 }')" != "fatal:" ]]; then
      # Get the last commit.
      last_commit=$(git log --pretty=format:'%at' -1 2> /dev/null)
      now=$(date +%s)
      seconds_since_last_commit=$(( now - last_commit))

      # Totals
      MINUTES=$((seconds_since_last_commit / 60))
      HOURS=$((seconds_since_last_commit/3600))
     
      # Sub-hours and sub-minutes
      DAYS=$((seconds_since_last_commit / 86400))
      SUB_HOURS=$((HOURS % 24))
      SUB_MINUTES=$((MINUTES % 60))
      
      if [[ -n "$(git status -s 2> /dev/null)" ]]; then
          if [ "$MINUTES" -gt 30 ]; then
              COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
          elif [ "$MINUTES" -gt 10 ]; then
              COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
          else
              COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
          fi
      else
          COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
      fi
      dirty=$(git_dirty)
      if [[ -n $dirty ]]; then
        prompt_segment 239 $COLOR
      else
        prompt_segment 239 $COLOR
      fi

      if [ "$HOURS" -gt 24 ]; then
          echo -n "${DAYS}d${SUB_HOURS}h${SUB_MINUTES}m"
      elif [ "$MINUTES" -gt 60 ]; then
          echo -n "${HOURS}h${SUB_MINUTES}m"
      else
          echo -n "${MINUTES}m"
      fi
    fi
  fi
}

## Main prompt
build_left_prompt() {
  RETVAL=$?
  prompt_status
  prompt_aws
  prompt_context
  prompt_dir
  prompt_git
  git_time_since_commit
  prompt_end
}

build_right_prompt() {
  echo -ne '%{'$'\e[1A''%}' # one line up
  prompt_virtualenv
  prompt_time
  echo -ne '%{'$'\e[1B''%}' # one line down
}

PROMPT='%{%f%b%k%}$(build_left_prompt) '
RPROMPT='%{%f%b%k%}$(build_right_prompt)'
