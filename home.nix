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
    sqlite-interactive

    # email
    (gnupg.override {
      guiSupport = true;
      pinentry = pinentry-curses;
    })
    isync
    msmtp
    notmuch
    pinentry-curses
  ];

  services.gpg-agent.enable = true;
  services.lorri.enable = true;

  services.mbsync = {
    enable = true;
    postExec = "${pkgs.notmuch}/bin/notmuch new";
  };

  home.file = {
    ".msmtprc".source = ./home/msmtprc;
    ".mbsyncrc".source = ./home/mbsyncrc;
    ".notmuch-config".source = ./home/notmuch-config;

    ".tmux.conf".source = ./home/tmux.conf;
    ".zshrc".source = ./home/zshrc;
    ".gitconfig".source = ./home/gitconfig;

    ".emacs".source = ./home/emacs;
    ".vimrc".source = ./home/vimrc;

    ".Xresources".source = ./home/Xresources;
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
