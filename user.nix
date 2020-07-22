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

  services.emacs = {
    enable = true;
    package = import ./emacs.nix { inherit pkgs; };
  };

  systemd.user.services.mbsync = {
    serviceConfig.Type = "oneshot";
    script = "${pkgs.isync}/bin/mbsync -a";
    postStart = "${pkgs.notmuch}/bin/notmuch new";
  };

  systemd.user.timers.mbsync = {
    wantedBy = [ "timers.target" ];
    partOf = [ "mbsync.service" ];
    timerConfig.OnCalendar = "*:0/5";
  };

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
      clang
      file
      gnumake
      gitAndTools.gitFull
      gitAndTools.tig
      graphviz
      irssi
      ripgrep
      psmisc
      python39Full

      # dhall
      dhall
      dhall-json

      # nix
      direnv
      nixfmt
      niv

      # html / webshit
      html-tidy
      jq

      # sql
      sqlite-interactive
      python38Packages.sqlparse

      # shell
      shfmt
      shellcheck

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
