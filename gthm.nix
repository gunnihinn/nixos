{ config, pkgs, modulesPath, lib, ... }:

{
  imports = [ (modulesPath + "/virtualisation/digital-ocean-config.nix") ];
  
  # Use cgroups v2
  boot = {
    kernelParams =
      [ "cgroup_no_v1=all" "systemd.unified_cgroup_hierarchy=yes" ];
  };
  systemd.services."user@".serviceConfig = {
    Delegate = "yes";
  };

  i18n.defaultLocale = "en_US.UTF-8";
  networking.hostName = "gthm";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  system.autoUpgrade.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    tree
    vim

    # sysadmin
    bind
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

    ssh.startAgent = true;

    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };
  };

  users.users.janitor = {
    isNormalUser = true;
    createHome = true;
    home = "/home/janitor";
    extraGroups = [ "wheel" ];
    hashedPassword =
      "$6$3WkR2MG.wn$THIpbgkzOpe2IzOK0MVJG7rH/pYBcQ/84F8wShlR5C003VbkMVQqgEMl5z9ZczSFThGwr94otU1Ce3y2CamBe.";
    shell = pkgs.zsh;
    openssh.authorizedKeys.keyFiles = [ ./data/id_gthm.pub ];
  };

}
