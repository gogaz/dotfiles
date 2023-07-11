autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '%F{green}●'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git svn 
theme_precmd () {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats ' (%b%c%u%F{default})'
    } else {
        zstyle ':vcs_info:*' formats ' (%b%c%u%F{default}%F{red}●%F{default})'
    }   

    vcs_info
}

ZSH_THEME_GIT_PROMPT_EQUAL_REMOTE="%F{green}✔"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="%B%F{blue}➚"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="%F{yellow}➘"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="%F{red}↯"

setopt prompt_subst
# PROMPT="[%*] %n:%c $(git_prompt_info)%(!.#.$) "
if [[ "$(uname)" == "Darwin" ]]; then
    # MacOS
    PROMPT='[%*] %{$fg[green]%}%~%{$reset_color%}% ${vcs_info_msg_0_}$(git_remote_status)%{$reset_color%} %(!.#.$) '
else
    # Unix
    PROMPT='[%*] %{$fg[yellow]%}%n%B%{$fg[blue]%}@%{$reset_color%}%{$fg[cyan]%}%M%{$reset_color%}:%{$fg[green]%}%~%{$reset_color%}% ${vcs_info_msg_0_}$(git_remote_status)%{$reset_color%} %(!.#.$) '
fi

#ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[yellow]%}("
#ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"

autoload -U add-zsh-hook
add-zsh-hook precmd  theme_precmd
