#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # for debugging


function main() {
	local directory=${1:-"$(pwd)"}
	local directory_name=$(basename ${directory})
	
	docker run --rm -d \
		--name rstudio \
		-e PASSWORD=$(cat secrets/password) \
		-v ${directory}:/home/rstudio/${directory_name} \
		-p 8787:8787 rocker/rstudio

	echo -n "Waiting for container to start "
	until nc -z localhost 8787  &> /dev/null; do sleep 1; echo -n ".";	done

	xdg-open "http://localhost:8787"
}


main $@