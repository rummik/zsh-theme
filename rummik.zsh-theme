() {
	local colorize=localfn_colorize$RANDOM

	function $colorize {
		local i sum
		local string=$1

		# Sum the ASCII value of each letter
		for ((sum = 0, i = 1; i <= $#string; i++)); do
			((sum += $((#\\$string[$i]))))
		done

		if functions hsl >/dev/null; then
			hsl $((sum % 360)) 1 0.5
		else
			local colors=(blue magenta cyan yellow white green)
			print ${colors[$(((sum % $#colors) + 1))]}
		fi
	}

	local hostcolor=${themePrimaryColor:-$($colorize $USER)}
	local usercolor=${themeSecondaryColor:-$($colorize $USER)}

	unfunction $colorize


	PS1="%(!.%B%F{red}.%B%F{$usercolor})%n%F{black}@%B%F{$hostcolor}%m%F{black}"
	PS1+=":%F{black}%~\$(git_prompt_info)\$(git_prompt_status)%F{black} {%B%F{yellow}%?%F{black}}>%f "

	# see https://gitlab.com/rummik/zsh/psmin
	PSMIN="%(!.%B%F{red}$.%B%F{$usercolor}#)%B%F{$hostcolor}%%"
	PSMIN+="\$(git_prompt_info)\$(git_prompt_status)%F{black}> %f"

	PS1="\$(prompt_nix_shell)$PS1"
	PSMIN="\${IN_NIX_SHELL:+%F{yellow\}λ}$PSMIN"
}


# Git prompt theme
ZSH_THEME_GIT_PROMPT_PREFIX=" %F{blue}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""

ZSH_THEME_GIT_PROMPT_DIRTY=" "
ZSH_THEME_GIT_PROMPT_CLEAN=" %F{green}="

ZSH_THEME_GIT_PROMPT_ADDED="%F{green}+"
ZSH_THEME_GIT_PROMPT_DELETED="%F{red}-"
ZSH_THEME_GIT_PROMPT_RENAMED="%B%F{cyan}→"

ZSH_THEME_GIT_PROMPT_UNTRACKED="%B%F{yellow}·"
ZSH_THEME_GIT_PROMPT_MODIFIED="%B%F{magenta}≠"

ZSH_THEME_GIT_PROMPT_STASHED="%B%F{blue}↔"

ZSH_THEME_GIT_PROMPT_UNMERGED="%B%F{red}×"

ZSH_THEME_GIT_PROMPT_AHEAD="%B%F{green}↑"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="%B%F{green}↓"
ZSH_THEME_GIT_PROMPT_BEHIND="%B%F{yellow}↓"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="%B%F{yellow}↑"
ZSH_THEME_GIT_PROMPT_DIVERGED="%B%F{yellow}↕"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="%B%F{yellow}↕"


functions prompt_nix_shell >/dev/null || function prompt_nix_shell {
	local nsprompt i packages package

	if [[ -n "$IN_NIX_SHELL" ]]; then
		if [[ -n $NIX_SHELL_PACKAGES ]]; then
			packages=(${(s: :)NIX_SHELL_PACKAGES})

			for (( i=1; i<=$#packages; i++ )); do
				packages[$i]=${packages[$i]##*Packages.}
				packages[$i]=${packages[$i]%.out}
			done

			nsprompt="${(j:%F{black},%F{yellow} :)packages}"
		elif [[ -n $name ]]; then
			nsprompt=$name
			nsprompt=${nsprompt#interactive-}
			nsprompt=${nsprompt%-environment}
			nsprompt=${nsprompt%-env}
		else # This case is only reached if the nix-shell plugin isn't installed or failed in some way
			nsprompt="nix-shell {}"
		fi
		
		print -Pn "%F{black}{ %F{yellow}$nsprompt%F{black} } "
	fi
}

# vim: set ft=zsh :
