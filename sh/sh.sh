#!/bin/bash
if [ -e "$(which nix-shell)" ]; then
	nix-shell nix/env.nix --pure --command zsh
else
	echo "Nix Shell is not available."
fi
exit