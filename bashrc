umask 022

# Path stuff
SCRIPTS=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
export PATH=$PATH:$SCRIPTS
syslog=/var/log/syslog

# Useful vars
export ua='Mozilla/5.0 (Windows NT 5.1; rv:23.0) Gecko/20100101 Firefox/23.0'

# Prompt
source "$SCRIPTS"/bash-prompt
source "$SCRIPTS"/apt-completion
source "$SCRIPTS"/tmux/tmux-completion
source /usr/share/bash-completion/bash_completion

# Color my life
export PAGER='most'
export VISUAL='vi' # advanced terminal
export EDITOR='vi' # nowadays not really needed anymore
export LS_OPTIONS='--color=auto' # -N https://www.gnu.org/software/coreutils/quotes.html ; https://unix.stackexchange.com/a/262162/45235
eval "$(dircolors)"
alias ls='ls $LS_OPTIONS'
alias ll='LC_COLLATE=C ls $LS_OPTIONS -Ahl' # https://unix.stackexchange.com/a/39853/45235
alias l='ls $LS_OPTIONS -Ahl'
alias diff='colordiff'
alias diffv='colordiff --width=$COLUMNS -y'
#alias tail='colortail -q'
alias configure='./configure | ccze -A'
#alias make='low colormake' # https://github.com/pagekite/Colormake/issues/21 --> 'docker push' progress is suppressed
#alias checkinstall='checkinstall colormake install'
#export GREP_OPTIONS='--color=auto' #deprecated
alias grep='grep --color=auto'
alias highlight='ccze -CA'

# Some shortcuts
alias apt='aptitude'
alias at='at -v'
alias cata='cat -A' # -vET use ^ and M- notation for non-printable (binary) data; prevent piping binary data :( cat binary > tmp; diff binary tmp
alias catz='zcat -f'
alias cls='clear'
alias clock='watch -n 1 "date +%T"'
alias croncal='croncal.pl -f /etc/crontab -d 900'
alias ct='vi /etc/crontab'
alias da='awk '\''{print NR": "$0; for(i=1;i<=NF;++i)print "\t"i": "$i}'\'''
alias dd='dd status=progress'
# Show ext 2, 3 & 4 FS; human readable; sort by 'use%' then 'avail'; highligt root fs
alias df='echo -e "Filesystem Size Used Avail Use% Mountpoint\n$(\df -hP | tail -n+2 | sort -k5nr -k4n )" | column -t | grep -P '\''.+/$|$'\''; echo'
alias encrypt='low openssl aes-256-cbc -e -salt -md sha256' # when nothing is supplied, openssl defaults are: -e -salt -md md5
alias decrypt='low openssl aes-256-cbc -d -salt -md sha256' # when nothing is supplied, openssl defaults are: -e (if -d is not present) -salt -md md5
alias digl='dig @localhost'
alias grepl='grep --line-buffered'
alias hexdump='hexdump -C'
#alias httpheader='curl -I --compress' # HEAD Request. Not all headers are included, e.g. the Expire and Last-Modified header
#alias httpheader='curl -s --compress -D- -o /dev/null' # File is completely downloaded. Probably not good for large files..
alias httpheader='timeout 2 curl -s --compress -D- -o /dev/null' # Terminate after 2 seconds. That prevents downloading a large file :)
alias insserv='insserv -v'
alias ipcalc='ipcalc -nb'
alias jobs='jobs -l'
alias killall='killall -v -e'
alias less='less -i'
alias locate='locate -i'
alias locateu='updatedb && locate -i'
alias loop='while :; do'
alias mkcd="source \"$SCRIPTS\"/mkcd"
alias mounti='mount | column -t | grep -P '\''.*?on\s+/\s+.*|$'\' # or use findmnt
alias mtr='mtr -o LSDNABW'
alias mysqlctl='/etc/init.d/mysql'
alias pgrep='pgrep -x'
alias phpcheck='find -name '\''*.php'\'' -exec php -l {} \;'
alias ping='ping -O'
alias shred='shred -v'
alias syslog='tail -F $syslog | highlight'
alias tcpflow='tcpflow -S enable_report=NO -g -c'
alias tempfile='echo -e "\e[1;32mtempfile is deprecated. Staring mktemp instead..\e[0m"; mktemp'
alias tree='tree -a'
alias su='su -s /bin/bash -l'
alias tailf='tail -F'
alias tmux="tmux -u new-session -A -s $(hostname)"
alias top='htop'
alias uniqq='awk '\''!x[$0]++'\'''
alias vidir='vidir -v'
alias visudo='VISUAL=vi visudo'
alias wget='wget -U "$ua"'
# remove ?querystring appended to filename by wget
alias wgetRemoveQuery='for i in $(find -maxdepth 1 -type f -name '\''*\?*'\''); do echo "Old: $i"; echo "$(echo New: $i | cut -d? -f1)"; echo; read -p '\''Rename? [y/N] '\'' LINE; [ "$LINE" == "y" ] && mv "$i" "$(echo $i | cut -d? -f1)"; done'
alias curl='curl -A "$ua"'
alias lynx='lynx -useragent "$ua"'

# copy with progress
alias copy='low rsync -aHXz --numeric-ids --info=progress2 --no-inc-recursive'
copyfile() {
	local dst line
	if [ ! -f "$1" ]; then
		echo "Error: File '$1' does not exist."
		echo
		return 1
	fi >&2
	dst="$2"
	if [ -d "$dst" ]; then
		dst="$dst/$(basename "$1")"
	fi

	if [ -f "$dst" ]; then
		echo "File '$dst' already exist."
		read -p "Overwrite? [y/N] " line
		if [ "$line" == "y" ]; then
			echo
			pv -bper "$1" > "$dst"
		else
			echo
			return 1
		fi
	else
		pv -bper "$1" > "$dst"
	fi
	if [ ! $? -eq 0 ]; then
		echo
		return 1
	fi
	echo
}
movefile() {
	copyfile "$1" "$2" &&
	trash "$1"
}

# trash
export trash=/trash
export TRASHDIR=/trash
alias et='mkdir -p "$TRASHDIR";  trash-empty zip rar flv mkv nfo sha1 jpg jpeg png gif'	# shred some
alias ets='mkdir -p "$TRASHDIR"; trash-empty --shred'					# shred all
alias etn='mkdir -p "$TRASHDIR"; trash-empty'						# shred none
alias ts='mkdir -p "$TRASHDIR";  du -sh $trash'
alias tt='mkdir -p "$TRASHDIR";  tree $trash'

# Lower process priority
alias low='nice -n 20 ionice -c3'
alias md5sum='low md5sum'
alias sha1sum='low sha1sum'
alias sha256sum='low sha256sum'

# Some more alias to avoid making mistakes:
alias rm='low rm -i'
alias cp='low cp -i'
alias mv='low mv -i'
alias reboot='read -p "Are you sure? [y] " -n 1 line && echo && [ "$line" == "y" ] && reboot'
alias poweroff='read -p "Are you sure? [y] " -n 1 line && echo && [ "$line" == "y" ] && poweroff'

# Docker aliase
hash docker 2> /dev/null && source docker-aliase.sh

# Apache stuff
alias ac='exe apachectl configtest'
alias ar='exe apachectl configtest && exe service apache2 restart'

a2() {
	local CMD=$1
	shift
	command a2$CMD "$@" &&
	exe apachectl configtest &&
	exe service apache2 reload
}

a2ensite()  { a2 ensite "$@";  }
a2dissite() { a2 dissite "$@"; }
a2enmod()   { a2 enmod "$@";   }
a2dismod()  { a2 dismod "$@";  }

# git clone shortcut
alias commit='git diff; git commit -a && git push'
alias gs='git status'
alias gd='git diff'
gc() {
	local URL DIR
	if [[ "$1" != "https://github.com/"* ]]; then
		if [[ "$1" == *"/"* ]]; then
			URL="https://github.com/$1"
		else
			URL="https://github.com/casperklein/$1"
		fi
	else
		local URL="$1"
	fi
	DIR=$(basename "$1")
	git clone --recurse-submodules "$URL" "$DIR" && cd "$DIR"
}

# make shell script
msh() {
	if [ -e "$1" ]; then
		echo "Error: '$1' does already exist."
		echo
		return 1
	fi >&2
	cat > "$1" <<"EOF"
#!/bin/bash


EOF
        chmod u+x "$1"
        vi "$1"
}


# Writes bash history immediately;  Useful for concurrent user log ins
# Applies only on interactive shells
shopt -s histappend

# Save execution time in history
HISTTIMEFORMAT='%d.%m.%Y %H:%M:%S '

# This causes any lines matching the previous history entry not to be saved. Also commands beginning with a space character are not saved.
HISTCONTROL='ignoreboth'

# This prevents writing history of this colon-separated list of patterns
HISTIGNORE='truecrypt*'

# The  number  of commands to remember in the command history (default value is 500)
HISTSIZE=500000

# Reminder Function
reminder() {
	out=
	while read -r line; do
		if [ "$out" != "" ]; then
			out="$out\n"$line
		else
			out=$line
		fi
	done
	clear
	echo -e "\e[1;33m$(echo -e "$out" | boxes -d shell -a c -s 66)\e[1m"
}

# Delay until given time
delay() {
	# Sleep until given time
	#current_epoch=$(date +%s)
	#target_epoch=$(date -d '01/01/2010 12:00' +%s)
	#sleep_seconds=$(( $target_epoch - $current_epoch ))
	#sleep $sleep_seconds
	
	# $1 = [dd] hh:mm
	[ "$2" ] && set "$1 $2"
	if [ ${#1} -ne 5 ] && [ ${#1} -ne 8 ]; then
		echo -e "Usage: delay [<dd>] <hh:mm>\n" >&2
		#echo ${#1} >&2
		return 1
	fi
	while [ "$(date +%R)" != "$*" ] && [ "$(date '+%d %R')" != "$*" ]; do
		sleep 30
	done
}

# if WSL, then create lowercase aliases for windows executables in Windows\System32 directory
if [ -d /mnt/c/Windows/System32 ]; then
	PATH=$PATH:/mnt/c/Windows/System32/
	for i in $(find /mnt/c/Windows/System32 -maxdepth 1 -type f -name '*\.EXE'); do BASENAME=${i##*/}; alias ${BASENAME,,}=\'$BASENAME\' ; done
	# empty 'low' alias, to avoid ionice error: ioprio_set failed: Invalid argument
	alias low=''
fi

[ -f ~/.bashrc.local ] && source ~/.bashrc.local
