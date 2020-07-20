{
  imports = [ <nixpkgs/nixos/modules/virtualisation/digital-ocean-image.nix> ];

  environment.etc."nixos/do-userdata.nix" = {
    text = ''
      { config, pkgs, ... }:

      {
        programs.zsh = {
          enable = true;
          autosuggestions.enable = true;
          syntaxHighlighting.enable = true;
        };

        users.users.gmagnusson = {
          description = "Gunnar Þór Magnússon";
          isNormalUser = true;
          extraGroups = [ "wheel" ];
          hashedPassword = "$6$7TkR9F7GceODYc$CAv6rRm6BrY..7kYAff7Z0ZzOo9xADGxzfIB5a2sGBhCKysopt6hyo2A1cObHAlyc9GJyOphpFZfj8iZ4orVL.";
          shell = pkgs.zsh;
          openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD9Bf2uDuL+TlfQt1iUYEYCBTxePIKLD0TLo3hfZXP4ag9C+xKjlTZQpty2zBhYqdzyjfe9puDuhDmyF72lfkxhR5trTLdx/TMi8kc5kQBBQ3PYhrvrlpYQvsEFjCOU4n6Y+NhTZuCOnKw6g9URTRMsNoCgnVER8GWJGuvG8oVru4MHCoLU3NGce3TT+daJ/eqoin8UFffri8XANZETDSUxNeCQZWoCoF9lOmy94y0cfhykOszKqAU+GItQrIlyvcNzfbjaRgOk68yAsKeokuy2EhrbzVmJ7CaL6qDI9YAstB1BzrP3U2unxRGZr16ukdjcl9nuZ8/DscaRkqp4rRy2WZ93xPfkLfPc+f9o3Zi35k5bPcgQYN3rPRZ8Y+Ltc55+aJAzPVnhr+PHMPXSO2S4GqGpgy2SAtRUqRB2JguzX/xXCR3BlUDiPWMQB3Q3gbmZDDKO4A8MVMyrOK0q6djCd+A5sIc3ySl7b1oLs7tEJTmK/wtl9SftF3ZVymP+fSk= gmagnusson@bcom"
          ];
        };

      }
    '';
    mode = "0644";
  };
}
