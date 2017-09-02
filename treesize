#!/bin/bash

# see also "ncdu". ncurses based treesize

trapCtrlC() {
        echo
        echo "Aborting.."
        echo
        exit
}

# Catch CTRL-C
trap trapCtrlC SIGINT

# if no directory is supplied, use current directory
if [ ! "$1" ]; then
	set '.'
fi

# get absolute path
DIR=$(readlink -f "$1")/
# beautify
[ "$DIR" == "//" ] && DIR=/

cd "$DIR" 2> /dev/null || {
	echo -e "Error: Could not access '$DIR'.\n" >&2
	exit 1
}

echo -n "Scanning..";

# original source: http://blog.aclarke.eu/a-simple-treesize-shell-script-for-linux/
du -sk "$DIR".[!.]* "$DIR"* 2>/dev/null | sort -n | awk '
	BEGIN {
		split("KB,MB,GB,TB", Units, ",");
	}
	{
		if (skip == "") print "  [Done]\n";
		skip="true";
		sum+=$1
	
		u = 1;
		while ($1 >= 1024) {
			$1 = $1 / 1024;
			u += 1
		}
		$1 = sprintf("%6.1f %s  ", $1, Units[u]);
	
		# print size and basename of directory
		printf("%s ", $1)
		$0 = substr($0, index($0,$1)); # truncate $0 to get basename; $1 may not contain whole directory names, e.g. when a space character is included.
		system("basename \""$0"\"");
		
		# print size and full path of directory
		# print $0;
	}
	END {
		u = 1;
		while (sum >= 1024) {
			sum = sum / 1024;
			u += 1
		}
		# decimal 27 is the ASCII codepoint for the escape character
		printf("\n%c[0;32m%6.1f %s   Summary%c[0m\n\n", 27, sum, Units[u], 27);
		
		# same as above, but no color
		# printf("\n%6.1f %s   Summary\n\n", sum, Units[u]);
	}' 
