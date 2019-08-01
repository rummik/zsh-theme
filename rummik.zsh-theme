function _colorize {
	[[ $1 == 'rummik' ]] && print green && return

	local i char sum colors
	sum=0
	colors=(blue magenta cyan yellow white green)

	# Sum the ASCII value of each letter
	for ((i=1; i<=$#1; i++)); do
		char=${1[$i]}
		sum=$(($sum + $((#char))))
	done

	print ${colors[$((($sum % $#colors) + 1))]}
}

PS1="%(!.%{${fg_bold[red]}%}.%{${fg_bold[$(_colorize $USER)]}%})%n%{${fg_bold[black]}%}@%{${fg_bold[$(_colorize $HOST)]}%}%m%{${fg_bold[black]}%}"
PS1+=":%{${fg[gray]}%}%~\$(git_prompt_info)\$(git_prompt_status)%{$fg_bold[black]%} {%{$fg_bold[yellow]%}%?%{$fg_bold[black]%}}>%{$reset_color%} "

# see https://github.com/rummik/zsh-psmin
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

prompt_nix_shell() {
	local nsprompt i packages package
	local black="%{$fg_bold[black]%\}"
	local yellow="%{$fg[yellow]%\}"

	if [[ -n "$IN_NIX_SHELL" ]]; then
		if [[ -n $NIX_SHELL_PACKAGES ]]; then
			packages=(${(s: :)NIX_SHELL_PACKAGES})

			for (( i=1; i<=$#packages; i++ )); do
				packages[$i]=${packages[$i]##*Packages.}
				packages[$i]=${packages[$i]%.out}
			done

			nsprompt="${(j:$black,$yellow :)packages}"
		elif [[ -n $name ]]; then
			nsprompt=$name
			nsprompt=${nsprompt#interactive-}
			nsprompt=${nsprompt%-environment}
			nsprompt=${nsprompt%-env}
		else # This case is only reached if the nix-shell plugin isn't installed or failed in some way
			nsprompt="nix-shell {}"
		fi
		
		print -n "$black{ $yellow$nsprompt$black } "
	fi

}

PS1="\$(prompt_nix_shell)$PS1"
PSMIN="\${IN_NIX_SHELL:+%{$fg[yellow]%\}λ}$PSMIN" 


# vim: set ft=zsh :
