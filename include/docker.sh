#!/bin/bash

alias db='docker build -t'
alias dc='drm 2>/dev/null; drmi 2>/dev/null; docker volume prune -f; docker system prune -af; dv; rm -rf ~/.docker/manifests/'
alias de='docker exec -it'
alias dev='dr --name dev -h dev -v dev:/root casperklein/dev'
alias di='docker images'
alias dl='docker logs -f'
alias dps='docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Command}}\t{{.Ports}}\t{{.Status}}\t{{.Image}}\t{{.Size}}" | grep -P "unhealthy|$"'
alias dr='docker run --rm -it'
alias drm='docker rm -f $(docker ps -aq)'
alias drmi='docker rmi -f $(docker images -q)'
alias ds='hash docker-ctop 2> /dev/null && TERM=linux docker-ctop || docker stats'
alias dv='docker volume ls'

# docker apps
alias hadolint='docker run --rm -i -v "$PWD"/Dockerfile:/Dockerfile:ro hadolint/hadolint /bin/hadolint --ignore DL3008 /Dockerfile'
alias portainer='dr -p 9000:9000 --name portainer -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer'

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
