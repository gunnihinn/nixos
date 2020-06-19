/*
See:
	https://nixos.org/nixos/manual/index.html#module-services-emacs
*/

{ pkgs ? import <nixpkgs> {} }:

let
  myEmacs = pkgs.emacs;
  emacsWithPackages = (pkgs.emacsPackagesGen myEmacs).emacsWithPackages;
in
  emacsWithPackages (epkgs: with epkgs.melpaStablePackages; [
    magit
  ] ++ [
    pkgs.notmuch
  ])
