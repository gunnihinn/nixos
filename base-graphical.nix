{ config, pkgs, ... }:

{
  imports = [ ./base.nix ];

  console.useXkbConfig = true;

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    chromium
    networkmanager-openconnect
    rxvt-unicode
  ];

  fonts.fonts = with pkgs; [ source-code-pro ];

  programs = {
    ssh.startAgent = true;
    nm-applet.enable = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  # Enable bluetooth & headphone support
  hardware.bluetooth = {
    enable = true;
    config = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
  services.blueman.enable = true;
  environment.systemPackages = [
    pkgs.pavucontrol
    pkgs.vorbis-tools
  ];

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "caps:ctrl_modifier";
    displayManager.defaultSession = "none+i3";
    desktopManager.xterm.enable = false;
    windowManager.i3.enable = true;
  };

  # Enable touchpad support.
  services.xserver.libinput = {
    enable = true;
    disableWhileTyping = true;
    sendEventsMode = "disabled-on-external-mouse";
  };

}
