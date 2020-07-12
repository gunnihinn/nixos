{ config, pkgs, lib, ... }:

{
  programs = {
    gnupg.agent.enable = true;

    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };
  };

  services.lorri.enable = true;

  users.users.gmagnusson = {
    description = "Gunnar Þór Magnússon";
    isNormalUser = true;
    createHome = true;
    home = "/home/gmagnusson";
    extraGroups = [ "wheel" ]
      ++ (lib.lists.optional config.networking.networkmanager.enable
        "networkmanager");
    hashedPassword =
      "$6$7TkR9F7GceODYc$CAv6rRm6BrY..7kYAff7Z0ZzOo9xADGxzfIB5a2sGBhCKysopt6hyo2A1cObHAlyc9GJyOphpFZfj8iZ4orVL.";
    shell = pkgs.zsh;
    openssh.authorizedKeys.keyFiles = [ ./data/id_bcom.pub ];
    packages = with pkgs; [
      # development
      asciidoctor
      dhall
      dhall-json
      direnv
      (import ./emacs.nix { inherit pkgs; })
      file
      gnumake
      gitAndTools.gitFull
      gitAndTools.tig
      graphviz
      jq
      niv
      nixfmt
      ripgrep
      psmisc
      sqlite-interactive

      # go
      go
      godef
      gometalinter
      delve

      # email
      (gnupg.override {
        guiSupport = true;
        pinentry = pinentry-curses;
      })
      isync
      msmtp
      notmuch
      pinentry-curses

      mkpasswd
    ];

  };

}
