# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)

# 1. 비대화형 쉘일 경우 즉시 종료 (보안 및 오류 방지)
[[ $- != *i* ]] && return

# 2. 히스토리 설정
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=50000
HISTFILESIZE=100000
#export HISTTIMEFORMAT="%F %T " # 사용시 __fzf_rg_history_search 함수가 오동작 함

# 3. 윈도우 사이즈 자동 체크
shopt -s checkwinsize

# 4. 프롬프트(PS1) 설정
K_BG="\[\e[48;5;236m\]"       # 배경: 기존 유지 (Sumi Ink)
K_RESET="\[\e[0m\]"           # 초기화 (입력 텍스트용)
K_GOLD="\[\e[38;5;220m\]"     # 펭귄: Bright Gold (더 쨍한 금색)
K_BLUE="\[\e[38;5;117m\]"     # 디렉토리: Sky Blue (밝은 하늘색)
K_GREEN="\[\e[38;5;157m\]"    # Git: Mint Green (밝은 민트색)
K_GRAY="\[\e[38;5;252m\]"     # 구분선: Bright Grey (밝은 회색)
K_VIOLET="\[\e[38;5;183m\]"   # User/Host: Lavender (밝은 라벤더색)
K_MUTE="\[\e[38;5;245m\]"     # 괄호: Medium Grey (적당한 회색)

function parse_git_branch() {
    git rev-parse --is-inside-work-tree &> /dev/null || return
    local ref=$(git symbolic-ref --short HEAD 2> /dev/null)
    if [ -z "$ref" ]; then ref=$(git describe --tags --exact-match HEAD 2> /dev/null); fi
    if [ -z "$ref" ]; then ref=$(git rev-parse --short HEAD 2> /dev/null); fi

    if [ -n "$ref" ]; then
        printf " \e[38;5;252m│\e[38;5;157m  (%s)" "$ref"
    fi
}

PS1='\n'
# [배경 블록] 펭귄 | 디렉토리 (Git)
PS1+="╭─${K_BG} ${K_GOLD} ${K_GRAY}│${K_BLUE}  \w"
PS1+="\$(parse_git_branch) "
PS1+="${K_RESET} "
# [순서 변경] 유저@호스트 (라벤더)
PS1+="${K_MUTE}[ ${K_VIOLET}\u@\h ${K_MUTE}] "
# [순서 변경] 날짜 (회색) (줄바꿈 \n 포함)
PS1+="${K_MUTE}< ${K_GRAY}\D{%m/%d/%Y %H:%M} ${K_MUTE}>\n"
# 입력 라인
PS1+="${K_RESET}╰─ \$ "

# 5. xterm 윈도우 타이틀 설정
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;\u@\h: \w\a\]$PS1"
        ;;
esac

# 6. 색상 지원 및 Alias
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# 7. 별도 alias 파일 로드
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# 8. Bash Completion (자동 완성)
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# 9. Vi 모드
set -o vi

# 10. FZF
if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
	export FZF_DEFAULT_OPTS="
	--reverse
	--height 40%
	--color=fg:#DCD7BA,bg:-1,hl:#658594
    --color=fg+:#DCD7BA,bg+:#2D4F67,hl+:#FF9E3B
    --color=info:#98BB6C,prompt:#7E9CD8,pointer:#FF5D62
    --color=marker:#98BB6C,spinner:#FF5D62,header:#7E9CD8
	--bind 'tab:down,btab:up'
	"
	export FZF_CTRL_T_COMMAND="fd --type f --hidden --follow --exclude .git"
	export FZF_ALT_C_COMMAND="fd --type d --hidden --exclude .git"
	source /usr/share/doc/fzf/examples/key-bindings.bash
fi
