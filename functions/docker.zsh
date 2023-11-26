# ░░░░░░░░░█▀▄░█▀█░█▀▀░█░█░█▀▀░█▀▄░░░░░░░░░░
# ░░░░░░░░░█░█░█░█░█░░░█▀▄░█▀▀░█▀▄░░░░░░░░░░
# ░░░░░░░░░▀▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░░░░░░░░░░

alias d.up='docker compose up'
alias d.down='docker compose down'
alias d.kick='docker compose restart'
alias d.stop='docker compose stop'
alias d.ps='docker compose ps'
alias d.build='docker compose up -d --build --force-recreate' # Rebuild Container
alias d.logs='docker compose logs -f --tail=100'
alias d.bomb='docker stop $(docker ps -q) || true && docker rm -v $(docker ps -aq) || true' # Destroy all containers (including running ones)
alias d.nuke='d.bomb && docker rmi $(docker images)' # Destroy all containers & images
alias d.clean='docker rm -v $(docker ps -aq) || true' # Cleanup exited containers
alias d.imgclean='docker rmi $(docker images) || true' # Cleanup images
alias d.sync='docker run -it --rm --privileged --pid=host debian nsenter -t 1 -m -u -n -i date -u $(date -u +%m%d%H%M%Y)' # Resync time within docker container
