# git stuff
alias commit='git diff; git commit -a && git push'
alias gb='PAGER= git branch -a'
alias gd='git diff'
alias gl='git log --graph --decorate --abbrev-commit --all --pretty=oneline'
alias gs='git status'
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
	git clone --recurse-submodules --depth 1 "$URL" "$DIR" && cd "$DIR"
}
