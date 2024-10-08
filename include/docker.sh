#!/bin/bash

alias db='docker build --check . 2> /dev/null && echo && docker build -t'
alias dc='docker rmi -f $(docker images -q) 2>/dev/null; docker volume prune --all --force; docker system prune --all --force; dv; trash ~/.docker/manifests/'
alias de='docker exec -it'
alias dev='dr --name dev -h dev -v dev:/root casperklein/dev'
alias di='docker images'
alias dl='docker logs -f'
alias dps='docker ps -a --format "table {{.Names}}\t{{.Command}}\t{{.Ports}}\t{{.Status}}\t{{.Image}}\t{{.Size}}" | grep -P "unhealthy|$"'
alias dr='docker run --rm -it'
alias drm='docker rm -f $(docker ps -aq)'
alias drmi='docker rmi -f $(docker images -q)'
alias ds='hash docker-ctop 2> /dev/null && TERM=linux docker-ctop || docker stats'
alias dv='docker volume ls'

# docker apps
alias hadolint='docker run --rm -i -v "$PWD"/Dockerfile:/Dockerfile:ro hadolint/hadolint /bin/hadolint --ignore DL3008 /Dockerfile'
alias portainer='dr -p 9000:9000 --name portainer -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer'

# docker-compose-plugin alias
alias docker-compose='docker compose'

dockerignore() {
	#echo "# Exclude all"
	echo '*'
	#echo
	#echo "# Include:"
	grep ^COPY Dockerfile | while read -r LINE; do
		# ignore multi-stage build COPYs
		[[ "$LINE" == *"--from"* ]] && continue
		# get second last column
		FILE=$(echo "$LINE" | awk '{print $(NF-1)}')
		echo "!$FILE"
	done
}

# add bash_completion for the following aliases
complete -F _complete_alias db
complete -F _complete_alias de
complete -F _complete_alias di
complete -F _complete_alias dl
complete -F _complete_alias docker-compose
complete -F _complete_alias dr
