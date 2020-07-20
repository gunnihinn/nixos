result/nixos.qcow2.gz: digitalocean-vm.nix
	nix-build '<nixpkgs/nixos>' --arg configuration ./$< -A config.system.build.digitalOceanImage
