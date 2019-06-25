##-------------------- mroth/evalcache --------------------
# Caches the output of a binary initialization command, to avoid the time to
# execute it in the future.
#
# Usage: _evalcache <command> <generation args...>

# default cache directory
export ZSH_EVALCACHE_DIR=${ZSH_EVALCACHE_DIR:-"$HOME/.zsh-evalcache"}

function _evalcache ()
{
    local cacheFile="$ZSH_EVALCACHE_DIR/init-${1##*/}.sh"

    if [[ "$ZSH_EVALCACHE_DISABLE" = "true" ]]; then
        eval "$("$@")"
    elif [[ -s "$cacheFile" ]]; then
        source "$cacheFile"
    else
        if type "$1" > /dev/null; then
            (>&2 echo "$1 initialization not cached, caching output of: $*")
            mkdir -p "$ZSH_EVALCACHE_DIR"
            "$@" > "$cacheFile"
            source "$cacheFile"
        else
            echo "evalcache ERROR: $1 is not installed or in PATH"
        fi
    fi
}

function _evalcache_clear ()
{
    rm -i "$ZSH_EVALCACHE_DIR"/init-*.sh
}

function eval
{
    local eval_command=$1
    alias eval=_evalcache
    eval $@
}

##-------------------- qoomon/zsh-lazyload --------------------
# zsh plugin for lazy load commands and speed up start up time of zsh
#
# Usage: lazyload <load-command> <command-name...>
# Load functions prefixed with init: will be unloaded by lazyload after first usage
function lazyload {
  local load_cmd=$1; shift
  local cmd_list=($@); shift $#

  for cmd_name in $cmd_list; do
    alias $cmd_name="lazyload: '$load_cmd' $cmd_list; $cmd_name"
  done
}

function lazyload: {
  local load_cmd=$1; shift
  local alias_list=($@); shift $#

  unalias $alias_list
  eval $load_cmd

  if [[ ${(kM)functions:#$load_cmd} ]] && [[ $load_cmd == 'init:'* ]]; then
    unfunction $load_cmd
  fi
}
