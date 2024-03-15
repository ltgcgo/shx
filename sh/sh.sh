#!/bin/bash
# shx Standard Utility
useNix=${1:-env}
if [ -f "nix/${useNix}.nix" ]; then
	echo "Preparing Nix shell with: ${useNix}.nix..."
else
	echo "${useNix}.nix does not exist."
fi
if [ -e "$(which nix-shells)" ]; then
	nix-shell nix/${useNix}.nix --quiet --pure --command zsh
	echo "Quitting Nix shell..."
	rm nix/.zcompdump 2> /dev/null
	rm nix/zsh/.zcompdump 2> /dev/null
elif [ -e "$(which podman)" ]; then
	if [ ! -f "nix/zsh/.docker_name" ]; then
		dd if=/dev/random bs=3 count=4 | basenc --base64url > nix/zsh/.docker_name
	fi
	ociName="$(cat nix/zsh/.docker_name)"
	echo "Starting Podman..."
	podman run -it -d --name "$ociName" -v "$SOURCE_DIR":/data docker.io/nixpkgs/nix sleep infinity 2>/dev/null
	podman start "$ociName" 2>/dev/null
	podman exec -it "$ociName" bash /data/nix/zsh/boot.sh "$useNix"
	echo "Quitting Podman..."
else
	echo "Nix Shell is not available."
fi
exit