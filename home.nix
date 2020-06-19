{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.magit
      epkgs.nix-mode
      epkgs.solarized-theme
    ];
  };

  home.packages = with pkgs; [
    # development
    asciidoctor
    dhall
    dhall-json
    direnv
    jq
    niv
    ripgrep

    # email
    isync
    msmtp
    notmuch
  ];

  services.lorri.enable = true;

  services.mbsync = {
    enable = true;
    postExec = "${pkgs.notmuch}/bin/notmuch new";
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
