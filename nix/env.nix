let
	pkgs = import <nixpkgs> {
		config = {};
		overlays = [];
	};
in
pkgs.mkShell {
	packages = with pkgs; [
		git
		nano
		bash
		zsh
		curl
	];
	GIT_EDITOR = "${pkgs.nano}/bin/nano";
	shellHook = ''
		export ZDOTDIR=$PWD/nix/zsh
		export XDG_CONFIG_HOME=$PWD/nix
		export PATH=$PWD:$PATH
	'';
}