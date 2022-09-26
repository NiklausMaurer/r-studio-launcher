#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # for debugging


function main() {
	local directory=$(realpath ${1:-"$(pwd)"})
	
	local container_id=$(run_container ${directory})
	local container_port=$(get_container_port ${container_id})

	open_browser_when_ready ${container_port} &

	docker attach ${container_id}
}

function run_container() {
	local directory=${1}
	local directory_name=$(basename ${directory})

	docker run --rm -d \
		-e DISABLE_AUTH=true  \
		-v ${directory}:/home/rstudio/${directory_name} \
		-p 127.0.0.1:0:8787 \
		rocker/rstudio
}

function get_container_port() {
	local container_id=${1}
	local container_port=$( \
		docker \
			inspect \
			--format '{{ (index (index .NetworkSettings.Ports "8787/tcp") 0).HostPort }}' \
			${container_id}
	)

	echo ${container_port}
}

function open_browser_when_ready() {
	local container_port=${1}

	until nc -z localhost ${container_port}  &> /dev/null; do sleep 1; done
	xdg-open "http://localhost:${container_port}"
}


main $@
