# zsh-lazyload
zsh plugin for lazy load commands and eval caching.  
speed up start up time of zsh!!

**fork from [lazyload](https://github.com/qoomon/zsh-lazyload), 
[evalcache](https://github.com/mroth/evalcache).**

## Usage

### Lazy Load
`lazyload <load-command> <command-name...>`

#### Examples
`lazyload 'source "$(brew --prefix nvm)/nvm.sh"' nvm`

Load functions prefixed with `init:` will be unloaded by `lazyload` after first usage
```
load:nvm(){
'source "$(brew --prefix nvm)/nvm.sh"'
}n
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

### [zgem](https://github.com/black7375/zgem)
`zgem bundle 'https://github.com/black7375/zsh-lazyload.git' from:'git' use:'zsh-lazyload.zsh'`
### [zplugin](https://github.com/zdharma/zplugin)
`zplugin load black7375/zsh-lazyload`
### [zgen](https://github.com/tarjoilija/zgen)
```
zgen load black7375/zsh-lazyload
zgen save
```
### [Antigen](https://github.com/zsh-users/antigen)
```
antigen bundle black7375/zsh-lazyload
antigen apply
```
### [Oh My ZSH! custom plugin](http://ohmyz.sh/)
```
git clone https://github.com/black7375/zsh-lazyload $ZSH_CUSTOM/plugins/zsh-lazyload
plugins+=(k)
```
### [zplug](https://github.com/zplug/zplug)
`zplug "black7375/zsh-lazyload"`
### manually
```
git clone https://github.com/black7375/zsh-lazyload.git
source zsh-lazyload/zsh-lazyload.zsh
```
