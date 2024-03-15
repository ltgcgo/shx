#!/bin/bash
# shx Standard Utility
useNix=${1:-env}
if [ -f "nix/${useNix}.nix" ]; then
	echo "Preparing Nix shell with: ${useNix}.nix..."
else
	echo "${useNix}.nix does not exist."
fi
if [ -e "$(which nix-shell)" ]; then
	nix-shell nix/${useNix}.nix --quiet --pure --command zsh
	echo "Quitting Nix shell..."
	rm nix/.zcompdump 2> /dev/null
	rm nix/zsh/.zcompdump 2> /dev/null
elif [ -e "$(which podman)" ]; then
	podman run -ti --rm nixpkgs/nix-unstable
else
	echo "Nix Shell is not available."
fi
exit