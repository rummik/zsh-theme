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

PS1="%(!.%{$fg_bold[red]%}.%{$fg_bold[$(_colorize $USER)]%})%n%{$fg_bold[black]%}@%{$fg_bold[$(_colorize $HOST)]%}%m%{$fg_bold[black]%}"
PS1="$PS1:%{$fg_bold[black]%}%~ {%{$fg_bold[yellow]%}%h%{$fg_bold[black]%}}> %{$reset_color%}"
PSMIN="%(!.%{$fg_bold[red]%}$.%{$fg_bold[$(_colorize $USER)]%}#)%{$fg_bold[black]%}> %{$reset_color%}"

# vim: set ft=zsh :
