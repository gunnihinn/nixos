/* See https://nixos.org/nixos/manual/index.html#module-services-emacs.

   To build the project, type the following from the current directory:

   $ nix-build emacs.nix

   To run the newly compiled executable:

   $ ./result/bin/emacs

   Querying packages:

   nix-env -f "<nixpkgs>" -qaP -A emacsPackages.elpaPackages
   nix-env -f "<nixpkgs>" -qaP -A emacsPackages.melpaPackages
   nix-env -f "<nixpkgs>" -qaP -A emacsPackages.melpaStablePackages
   nix-env -f "<nixpkgs>" -qaP -A emacsPackages.orgPackages
*/
{ pkgs ? import <nixpkgs> { } }:

let
  myEmacs = pkgs.emacs;
  emacsWithPackages = (pkgs.emacsPackagesGen myEmacs).emacsWithPackages;
in emacsWithPackages (epkgs:
  (with epkgs.melpaPackages; [
    adoc-mode
    company
    company-go
    company-nixos-options
    dhall-mode
    flycheck
    helm
    helm-projectile
    helm-rg
    go-errcheck
    go-imports
    go-mode
    go-projectile
    graphviz-dot-mode
    nix-mode
    magit
    paredit
    projectile
    rainbow-delimiters
    solarized-theme
    use-package
    visual-fill-column
  ]) ++ [
    pkgs.notmuch # From main packages set
  ])
