# zsh-lazyenv
zsh plugin for lazy load envs and caching.  
speed up start up time of zsh!!

**Main fork from [lazyload](https://github.com/qoomon/zsh-lazyload), 
[evalcache](https://github.com/mroth/evalcache).**

**env forks**

- [zsh-jenv-lazy](https://github.com/shihyuho/zsh-jenv-lazy/)
- [zsh-pyenv-lazy](https://github.com/davidparsson/zsh-pyenv-lazy)
- [@kaddan’s lazy env](https://github.com/kadaan?utf8=%E2%9C%93&tab=repositories&q=lazy)

## Usage
### Lazy Environments
`lazyenv-enabled`

**Target of Environments**
- [nvm](https://github.com/nvm-sh/nvm)
- [rvm](https://github.com/rvm/rvm)
- [jenv](https://github.com/jenv/jenv)
- [goenv](https://github.com/syndbg/goenv)
- [plenv](https://github.com/tokuhirom/plenv)
- [pyenv](https://github.com/pyenv/pyenv)
- [pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv)
- [rbenv](https://github.com/rbenv/rbenv)
- [nodenv](https://github.com/nodenv/nodenv)
- [phpenv](https://github.com/phpenv/phpenv)

**lazy functions**
- [thefuck](https://github.com/nvbn/thefuck)
- [hub](https://github.com/github/hub)
- [kubectl](https://github.com/kubernetes/kubectl)
- [scmpuff](https://github.com/mroth/scmpuff)

### Lazy Load
`lazyload <load-command> <command-name...>`

#### Examples
`lazyload 'source "$(brew --prefix nvm)/nvm.sh"' nvm`

Load functions prefixed with `init:` will be unloaded by `lazyload` after first usage
```
load:nvm(){
    source "$(brew --prefix nvm)/nvm.sh"
}
lazyload init:nvm nvm
```

### Eval Cache
`evalcache <command> <generation args...>`

#### Examples
`eval "$(hub alias -s)"` to `_evalcache hub alias -s`

#### Options

- `$ZSH_EVALCACHE_DIR`: cache files storage, default `$HOME/.zsh-evalcache`.
- `$ZSH_EVALCACHE_DISABLE`: set to `true` if you wish to bypass evalcache.


## Install

### [zgem](https://github.com/qoomon/zgem)
`zgem bundle 'https://github.com/black7375/zsh-lazyenv.git' from:'git' use:'zsh-lazyenv.zsh'`
### [zplugin](https://github.com/zdharma/zplugin)
`zplugin load black7375/zsh-lazyenv`
### [zgen](https://github.com/tarjoilija/zgen)
```
zgen load black7375/zsh-lazyenv
zgen save
```
### [Antigen](https://github.com/zsh-users/antigen)
```
antigen bundle black7375/zsh-lazyenv
antigen apply
```
### [Oh My ZSH! custom plugin](http://ohmyz.sh/)
```
git clone https://github.com/black7375/zsh-lazyenv $ZSH_CUSTOM/plugins/zsh-lazyenv
plugins+=(zsh-lazyenv)
```
### [zplug](https://github.com/zplug/zplug)
`zplug "black7375/zsh-lazyenv"`
### manually
```
git clone https://github.com/black7375/zsh-lazyenv.git
source zsh-lazyenv/zsh-lazyenv.zsh
```
