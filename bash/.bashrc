# Check shell interactivity
if [[ $- != *i* ]] ; then
	return
fi

# Enable completion
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
	source /usr/share/bash-completion/bash_completion
elif [[ -f /etc/bash/bashrc.d/bash_completion.sh ]]; then
	source /etc/bash/bashrc.d/bash_completion.sh
fi

# Enable checkwinsize so that bash will check the terminal size when it regains control.
shopt -s checkwinsize

# Disable completion when the input buffer is empty.  i.e. Hitting tab
# and waiting a long time for bash to expand all of $PATH.
shopt -s no_empty_cmd_completion

# Set vi-mode
set -o vi

# avoid duplicates in history
export HISTCONTROL=ignoredups:erasedups
# append history entries
shopt -s histappend
# After each command, save and reload history
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

HISTSIZE=100000000
HISTFILESIZE=20000000

history_mrProper() {
	nl ~/.bash_history |sort -k2 -k 1,1nr | uniq -f1 | sort -n | cut -f2 | egrep -v ".*[а-яА-Я]+.*" > /tmp/bash_history.clean
	mv -v /tmp/bash_history.clean ~/.bash_history
}

# Colors
Color_Off='\e[0m'

# Usual colors
Black='\e[0;30m'
Red='\e[0;31m'
Green='\e[0;32m'
Yellow='\e[0;33m'
Blue='\e[0;34m'
Purple='\e[0;35m'
Cyan='\e[0;36m'
White='\e[0;37m'

# Bold colors
BBlack='\e[1;30m'
BRed='\e[1;31m'
BGreen='\e[1;32m'
BYellow='\e[1;33m'
BBlue='\e[1;34m'
BPurple='\e[1;35m'
BCyan='\e[1;36m'
BWhite='\e[1;37m'

# Underlined colors
UBlack='\e[4;30m'
URed='\e[4;31m'
UGreen='\e[4;32m'
UYellow='\e[4;33m'
UBlue='\e[4;34m'
UPurple='\e[4;35m'
UCyan='\e[4;36m'
UWhite='\e[4;37m'

# Background colors
On_Black='\e[40m'
On_Red='\e[41m'
On_Green='\e[42m'
On_Yellow='\e[43m'
On_Blue='\e[44m'
On_Purple='\e[45m'
On_Cyan='\e[46m'
On_White='\e[47m'

# Intensive colors
IBlack='\e[0;90m'
IRed='\e[0;91m'
IGreen='\e[0;92m'
IYellow='\e[0;93m'
IBlue='\e[0;94m'
IPurple='\e[0;95m'
ICyan='\e[0;96m'
IWhite='\e[0;97m'

# Bold Intensive colors
BIBlack='\e[1;90m'
BIRed='\e[1;91m'
BIGreen='\e[1;92m'
BIYellow='\e[1;93m'
BIBlue='\e[1;94m'
BIPurple='\e[1;95m'
BICyan='\e[1;96m'
BIWhite='\e[1;97m'

# Intensive Background colors
On_IBlack='\e[0;100m'
On_IRed='\e[0;101m'
On_IGreen='\e[0;102m'
On_IYellow='\e[0;103m'
On_IBlue='\e[0;104m'
On_IPurple='\e[0;105m'
On_ICyan='\e[0;106m'
On_IWhite='\e[0;107m'



# Set colorful PS1 with git-prompt only on colorful terminals.
if [[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]]; then
	source /usr/share/git-core/contrib/completion/git-prompt.sh
elif [[ -f /usr/share/git/git-prompt.sh ]]; then
	source /usr/share/git/git-prompt.sh
fi

use_color=false
if type -P dircolors >/dev/null ; then
	LS_COLORS=
	if [[ -f ~/.dir_colors ]] ; then
		used_default_dircolors="no"
		eval "$(dircolors -b ~/.dir_colors)"
	elif [[ -f /etc/DIR_COLORS ]] ; then
		used_default_dircolors="maybe"
		eval "$(dircolors -b /etc/DIR_COLORS)"
	else
		used_default_dircolors="yes"
		eval "$(dircolors -b)"
	fi
	if [[ -n ${LS_COLORS:+set} ]] ; then
		use_color=true

		case ${used_default_dircolors} in
		no) ;;
		yes) unset LS_COLORS ;;
		*)
			ls_colors=$(eval "$(dircolors -b)"; echo "${LS_COLORS}")
			if [[ ${ls_colors} == "${LS_COLORS}" ]] ; then
				unset LS_COLORS
			fi
			;;
		esac
	fi
	unset used_default_dircolors
else
	case ${TERM} in
	[aEkx]term*|rxvt*|gnome*|konsole*|screen|cons25|*color) use_color=true;;
	esac
fi

if ${use_color} ; then
	if [[ ${EUID} == 0 ]] ; then
		PS1="\[$BRed\]\u@\h\[$Color_Off\] \[$BBlue\]\w \[$Color_Off\]\[$BRed\]"
		PS1+='$(__git_ps1 "(%s) ")'
		PS1+="\[$Color_Off\]\[$BBlue\]\$\[$Color_Off\] "
	else
		PS1="\[$BGreen\]\u@\h\[$Color_Off\] \[$BBlue\]\w \[$Color_Off\]\[$BRed\]"
		PS1+='$(__git_ps1 "(%s) ")'
		PS1+="\[$Color_Off\]\[$BBlue\]\$\[$Color_Off\] "
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		PS1+='\u@\h \W \$ '
	else
		PS1+='\u@\h \w \$ '
	fi
fi

# Aliases
alias rm='rm -v'
alias cp='cp -v'
alias mv='mv -v'
alias ll='ls -l'
alias la='ls -la'

# Exports
export EDITOR="vim"
