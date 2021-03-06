{ config, pkgs, ... }:

{
  # Use cgroups v2
  boot = {
    kernelParams =
      [ "cgroup_no_v1=all" "systemd.unified_cgroup_hierarchy=yes" ];
  };
  systemd.services."user@".serviceConfig = { Delegate = "yes"; };

  i18n.defaultLocale = "en_US.UTF-8";

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

    ssh.startAgent = true;
  };
}
