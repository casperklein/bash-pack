umask 022

# Path stuff
export PATH=$PATH:/scripts
syslog=/var/log/syslog

# Useful vars
export ua='Mozilla/5.0 (Windows NT 5.1; rv:23.0) Gecko/20100101 Firefox/23.0'

# Prompt
source /scripts/bash-prompt
source /scripts/apt-completion
source /scripts/tmux-completion

# Color my life
export PAGER='most'
export VISUAL='vi' # advanced terminal
export EDITOR='vi' # nowadays not really needed anymore
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -Ahl'
alias l='ls $LS_OPTIONS -Ahl'
alias diff='colordiff'
#alias tail='colortail -q'
alias configure='./configure | ccze -A'
alias make='low colormake'
alias checkinstall='checkinstall colormake install'
#export GREP_OPTIONS='--color=auto' #deprecated
alias grep='grep --color=auto'
alias highlight='ccze -CA'

# Some shortcuts
alias a2ensite='sleep 2 && /etc/init.d/apache2 reload && echo "Apache: reloaded" & a2ensite'
alias a2dissite='sleep 2 && /etc/init.d/apache2 reload && echo "Apache: reloaded" & a2dissite'
alias a2enmod='sleep 2 && /etc/init.d/apache2 reload && echo "Apache: reloaded" & a2enmod'
alias a2dismod='sleep 2 && /etc/init.d/apache2 reload && echo "Apache: reloaded" & a2dismod'
alias apt='aptitude'
alias at='at -v'
alias cata='cat -A' # -vET use ^ and M- notation for non-printable (binary) data; prevent piping binary data :( cat binary > tmp; diff binary tmp
alias cls='clear'
alias clock='watch -n 1 "date +%T"'
alias croncal='croncal.pl -f /etc/crontab -d 900'
alias ct='vi /etc/crontab'
alias da='awk '\''{print NR": "$0; for(i=1;i<=NF;++i)print "\t"i": "$i}'\'''
alias dd='dcfldd'
# Show ext 2, 3 & 4 FS; human readable; sort by 'use%' then 'avail'; highligt root fs
alias df='echo -e "Filesystem Size Used Avail Use% Mountpoint\n$(\df -hP -text{1..4} | tail -n+2 | sort -k5nr -k4n )" | column -t | grep -P '\''.+/$|$'\''; echo'
alias encrypt='low openssl aes-256-cbc -e -salt -md sha256' # when nothing is supplied, openssl defaults are: -e -salt -md md5
alias decrypt='low openssl aes-256-cbc -d -salt -md sha256' # when nothing is supplied, openssl defaults are: -e (if -d is not present) -salt -md md5
alias digl='dig @localhost'
alias grepl='grep --line-buffered'
alias hexdump='hexdump -C'
#alias httpheader='curl -I --compress' # HEAD Request. Not all headers are included, e.g. the Expire and Last-Modified header
alias httpheader='curl -i -s -D- --compress -o /dev/null' # File is completely downloaded. Probably not good for large files..
alias insserv='insserv -v'
alias jobs='jobs -l'
alias killall='killall -v -e'
alias less='less -i'
alias locate='locate -i'
alias locateu='updatedb && locate -i'
alias loop='while [ true ]; do'
alias mkcd='source /scripts/mkcd'
alias mounti='mount | column -t | grep -P '\''.*?on\s+/\s+.*|$'\'
alias mysqlctl='/etc/init.d/mysql'
alias pgrep='pgrep -x'
alias phpcheck='find -name '\''*.php'\'' -exec php -l {} \;'
alias shred='shred -v'
alias syslog='tail -F $syslog | highlight'
alias tcpflow='tcpflow -S enable_report=NO -g -c'
alias tempfile='echo -e "\e[1;32mtempfile is deprecated. Staring mktemp instead..\e[0m"; mktemp'
alias tree='tree -a'
alias su='su -s /bin/bash -l'
alias tailf='tail -F'
alias tmux='tmux a'
alias top='htop'
alias visudo='VISUAL=vi visudo'
alias wget='wget -U "$ua"'
alias curl='curl -A "$ua"'
alias lynx='lynx -useragent "$ua"'

# Lower process priority
alias low='nice -n 20 ionice -c3'
alias md5sum='low md5sum'
alias sha1sum='low sha1sum'
alias sha256sum='low sha256sum'

# Fix display bug when PuTTY is in UTF-8 translation mode
#alias iptraf='echo iptraf is inaccurate. Use nethogs instead.; [ $TERM == "screen" ] && iptraf -d eth0 || TERM=linux iptraf -d eth0'
alias iptraf='echo -e "\e[1;32miptraf is inaccurate. Staring iptraf-ng instead..\e[0m"; iptraf-ng'
alias iptraf-ng='[ $TERM == "screen" ] && iptraf-ng -d eth0 || TERM=linux iptraf-ng -d eth0'
alias htop='[[ $TERM == xterm* ]] && low htop || TERM=screen-256color low htop'

# Some more alias to avoid making mistakes:
alias rm='low rm -i'
alias cp='low cp -i'
alias mv='low mv -i'
alias reboot='echo Are you sure? #'

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
	while read line; do
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
