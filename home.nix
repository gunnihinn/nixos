{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # I have to look this up every time:
  #   nix-env -f '<nixpkgs>' -qaP -A emacsPackages
  # See also:
  #   man home-configuration.nix
  #   https://nixos.org/nixos/manual/index.html#module-services-emacs
  programs.emacs = {
    enable = true;
    extraPackages = epkgs:
      (with epkgs; [
        adoc-mode
        company
        company-go
        company-nixos-options
        dhall-mode
        flycheck
        go-errcheck
        go-imports
        go-mode
        go-projectile
        graphviz-dot-mode
        magit
        nix-mode
        paredit
        projectile
        rainbow-delimiters
        solarized-theme
        use-package
        visual-fill-column
      ]);
  };

  services.gpg-agent.enable = true;
  services.lorri.enable = true;

  services.mbsync = {
    enable = true;
    postExec = "${pkgs.notmuch}/bin/notmuch new";
  };

  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        username = "gunnar@magnusson.io";
        password = "pfmiaJKGkqy5p9vVUqga";
        device_name = "booking";
        cache_path = "/home/gmagnusson/.cache/spotifyd";
      };
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.03";
}
