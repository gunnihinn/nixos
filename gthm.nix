{ pkgs, modulesPath, lib, ... }:

{
  imports = [ (modulesPath + "/virtualisation/digital-ocean-config.nix") ];

  # Use cgroups v2
  boot = {
    kernelParams =
      [ "cgroup_no_v1=all" "systemd.unified_cgroup_hierarchy=yes" ];
  };
  systemd.services."user@".serviceConfig = { Delegate = "yes"; };

  i18n.defaultLocale = "en_US.UTF-8";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  system.autoUpgrade.enable = true;

  environment.variables = {
    TERM = "rxvt";
    EDITOR = "vim";
  };

  environment.systemPackages = with pkgs; [
    wget
    tree
    vim
    rxvt-unicode

    # sysadmin
    bind
    borgbackup
    htop
    inetutils
    netcat
    ngrep
    strace
    tcpdump
    traceroute
  ];

  programs = {
    tmux = {
      enable = true;
      clock24 = true;
    };

    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };
  };

  users.users = {
    janitor = {
      isNormalUser = true;
      createHome = true;
      home = "/home/janitor";
      extraGroups = [ "wheel" ];
      hashedPassword =
        "$6$3WkR2MG.wn$THIpbgkzOpe2IzOK0MVJG7rH/pYBcQ/84F8wShlR5C003VbkMVQqgEMl5z9ZczSFThGwr94otU1Ce3y2CamBe.";
      shell = pkgs.zsh;
      openssh.authorizedKeys.keyFiles = [ ./data/id_gthm.pub ];
      packages = with pkgs; [ git ];
    };

    gmagnusson = {
      isNormalUser = true;
      createHome = true;
      home = "/home/gmagnusson";
      hashedPassword =
        "$6$MnpM67SJuDE$rGzRwnfcsesW1M98cdOBlQaukWP4rEKefGuSdBlihKK1pQWCjoxqXxT3poT4ti7OUr.BU3WCxZTHaqD7TAsnF1";
      shell = pkgs.zsh;
      openssh.authorizedKeys.keyFiles = [ ./data/id_gthm.pub ];
      packages = with pkgs; [ git irssi ];
    };
  };

}