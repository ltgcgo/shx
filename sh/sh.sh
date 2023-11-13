#!/bin/bash
if [ -e "$(which nix-shell)" ]; then
	echo "Preparing Nix shell environment..."
	nix-shell nix/env.nix --quiet --pure --command zsh
	echo "Quitting Nix shell environment..."
else
	echo "Nix Shell is not available."
fi
exit