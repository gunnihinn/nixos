{ config, pkgs, ... }:

{
  imports = [ ./base.nix ];

  console.useXkbConfig = true;

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    chromium
    networkmanager-openconnect
    mpc_cli
    pavucontrol
    rxvt-unicode
    vorbis-tools
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
    extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";
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

  # Enable mpd
  services.mpd = {
    enable = true;
    user = "gmagnusson";
    group = "users";
    dataDir = "/home/gmagnusson/mpd";
    extraConfig = ''
audio_output {
  type "pulse"
  name "Pulseaudio"
  server "127.0.0.1"
}
'';
  };

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
