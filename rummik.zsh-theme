function _colorize {
	[[ $1 == 'rummik' ]] && print green && return

	local i n colors
	n=0
	colors=(blue magenta cyan yellow white green)

	for i in $(sed 's/./ \0/g;' <<< $1); do
		n=$(($n + $((#i))))
	done

	print ${colors[$((($n % 6) + 1))]}
}

PS1="%(!.%{${fg_bold[red]}%}.%{${fg_bold[$(_colorize $USER)]}%})%n%{${fg_bold[black]}%}@%{${fg_bold[$(_colorize $HOST)]}%}%m%{${fg_bold[black]}%}"
PS1+=":%{${fg[gray]}%}%~\$(git_prompt_info)\$(git_prompt_status)%{$fg_bold[black]%} {%{$fg_bold[yellow]%}%?%{$fg_bold[black]%}}>%{$reset_color%} "

PSMIN="%(!.%{${fg_bold[red]}%}$.%{${fg_bold[$(_colorize $USER)]}%}#)%{${fg_bold[$(_colorize $HOST)]}%}%%"
PSMIN+="\$(git_prompt_info)\$(git_prompt_status)%{$fg_bold[black]%}> %{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX=" %{${fg[blue]}%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""

ZSH_THEME_GIT_PROMPT_DIRTY=" "
ZSH_THEME_GIT_PROMPT_CLEAN=" %{${fg[green]}%}="

ZSH_THEME_GIT_PROMPT_ADDED="%{${fg[green]}%}+"
ZSH_THEME_GIT_PROMPT_DELETED="%{${fg[red]}%}-"
ZSH_THEME_GIT_PROMPT_RENAMED="%{${fg_bold[cyan]}%}→"

ZSH_THEME_GIT_PROMPT_UNTRACKED="%{${fg_bold[yellow]}%}·"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{${fg_bold[magenta]}%}≠"

ZSH_THEME_GIT_PROMPT_STASHED="%{${fg_bold[blue]}%}↔"

ZSH_THEME_GIT_PROMPT_UNMERGED="%{${fg_bold[red]}%}×"

ZSH_THEME_GIT_PROMPT_AHEAD="%{${fg_bold[green]}%}↑"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="%{${fg_bold[green]}%}↓"
ZSH_THEME_GIT_PROMPT_BEHIND="%{${fg_bold[yellow]}%}↓"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="%{${fg_bold[yellow]}%}↑"
ZSH_THEME_GIT_PROMPT_DIVERGED="%{${fg_bold[yellow]}%}↕"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="%{${fg_bold[yellow]}%}↕"
# vim: set ft=zsh :
