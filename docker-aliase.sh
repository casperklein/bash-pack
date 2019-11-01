alias db='docker build -t'
alias dc='drm 2>/dev/null; drmi 2>/dev/null; docker volume prune -f; docker system prune -af; dv; trash ~/.docker/manifests/'
alias de='docker exec -it'
alias dev='dr -v dev:/root casperklein/dev'
alias di='docker images'
alias dl='docker logs -f'
alias dps='docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Command}}\t{{.Ports}}\t{{.Status}}\t{{.Image}}\t{{.Size}}"'
alias dr='docker run --rm -it'
alias drm='docker rm -f $(docker ps -aq)'
alias drmi='docker rmi -f $(docker images -q)'
alias ds='docker stats $(docker ps -q)'
alias dv='docker volume ls'

# docker apps
alias hadolint='docker run --rm -i -v "$(pwd)"/Dockerfile:/Dockerfile:ro hadolint/hadolint /bin/hadolint --ignore DL3008 /Dockerfile'
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
