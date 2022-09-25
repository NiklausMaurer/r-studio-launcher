#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # for debugging


function main() {
	local directory=$(realpath ${1:-"$(pwd)"})
	local directory_name=$(basename ${directory})
	
	open_prowser_when_ready &

	docker run --rm \
		--name rstudio \
		-e PASSWORD=$(cat secrets/password) \
		-v ${directory}:/home/rstudio/${directory_name} \
		-p 8787:8787 rocker/rstudio
}

function open_prowser_when_ready() {
	until nc -z localhost 8787  &> /dev/null; do sleep 1; done
	xdg-open "http://localhost:8787"
}


main $@