##-------------------- mroth/evalcache --------------------
# Caches the output of a binary initialization command, to avoid the time to
# execute it in the future.
#
# Usage: evalcache <command> <generation args...>

# default cache directory
export ZSH_EVALCACHE_DIR=${ZSH_EVALCACHE_DIR:-"$HOME/.zsh-evalcache"}

function evalcache
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

function evalcache_clear
{
    rm -i "$ZSH_EVALCACHE_DIR"/init-*.sh
}

##-------------------- qoomon/zsh-lazyload --------------------
# zsh plugin for lazy load commands and speed up start up time of zsh
#
# Usage: lazyload <load-command> <command-name...>
# Load functions prefixed with init: will be unloaded by lazyload after first usage
function lazyload
{
  local load_cmd=$1; shift
  local cmd_list=($@); shift $#

  for cmd_name in $cmd_list; do
    alias $cmd_name="lazyload: '$load_cmd' $cmd_list; $cmd_name"
  done
}

function lazyload:
{
  local load_cmd=$1; shift
  local alias_list=($@); shift $#

  unalias $alias_list
  evalcache $load_cmd

  if [[ ${(kM)functions:#$load_cmd} ]] && [[ $load_cmd == 'init:'* ]]; then
    unfunction $load_cmd
  fi
}


##-------------------- black7375/zsh-lazyenv --------------------
function lazyenv-enabled
{
    # autoload
    AUTOENVFUNC="${0:h}/autoload"
    fpath+="${AUTOENVFUNC}"
    if [[ -d "$AUTOENVFUNC" ]]; then
        for func in $AUTOENVFUNC/*; do
            autoload -Uz ${func:t}
        done
    fi

    # init envs
    lazyload init:nvm    nvm
    lazyload init:jenv   jenv
    lazyload init:goenv  goenv
    lazyload init:plenv  plenv
    lazyload init:pyenv  pyenv
    lazyload init:rbenv  rbenv
    lazyload init:nodenv nodenv
    lazyload init:phpenv phpenv
}
