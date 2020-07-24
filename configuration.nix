# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./base-graphical.nix
    ./user.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices.crypted.device =
    "/dev/disk/by-uuid/b8e8115c-a76b-4aa1-97f4-109e0b144be8";
  fileSystems."/".device = "/dev/mapper/crypted";

  networking.hostName = "booking"; # Define your hostname.
  networking.interfaces.wlo1.useDHCP = true;
  networking.hosts = {
    "64.225.73.140" = [ "sky" ];
    "134.122.53.95" = [ "gthm" ];
    "68.183.12.154" = [ "gthmcloud" ];
  };

  time.timeZone = "Europe/Amsterdam";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

  # https://discourse.nixos.org/t/is-it-possible-to-recover-configuration-nix-from-an-older-generation/2659/6
  environment.etc."nixos/active".text = config.system.nixos.label;
}

