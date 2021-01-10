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
