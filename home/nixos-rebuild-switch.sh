#!/usr/bin/env bash

set -euo pipefail

NIX="$HOME/etc/nixos"

UNSAVED_CHANGES=$(git -C "$NIX" diff-index --name-only HEAD --)
if [[ -n "${UNSAVED_CHANGES}" ]]; then
	echo "Commit your changes in $NIX:"
    echo "$UNSAVED_CHANGES"
	exit 1
elif [[ $(git -C "$NIX" rev-parse HEAD) != $(git -C "$NIX" rev-parse @{u}) ]]; then
	echo "Push your changes in $NIX"
	exit 1
else
    export NIXOS_LABEL_VERSION="$(date "+%Y-%m-%d_%H%M%S")_$(git -C "$NIX" rev-parse --short HEAD)"
	sudo nixos-rebuild switch "$@"
fi

home-manager switch
