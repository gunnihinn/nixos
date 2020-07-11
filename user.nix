{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  users.users.gmagnusson = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]
      ++ (if config.networking.networkmanager.enable then [ "networkmanager" ] else [ ]);
    shell = pkgs.zsh;
  };

}
