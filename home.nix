{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableAutoSuggestions = true;
    syntaxHighlighting.enable = true;
    dotdir = ".config/zsh";

    initExtra = ''
autoload colors && colors
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
    eval $COLOR='%{$fg_no_bold[${(L)COLOR}]%}'  #wrap colours between %{ %} to avoid weird gaps in autocomplete
    eval BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done
eval RESET='%{$reset_color%}'

PROMPT="%B%(?..[%?] )%b${GREEN}%n${RESET}@%U${YELLOW}%m${RESET}%u> "

LS_COLORS='no=0:fi=0:di=34:ln=35:or=35;47:mi=33;47:pi=36:so=32:bd=34;46:cd=34;47:ex=31:'
export LS_COLORS

# Fix SSH environment variables when re-attaching to existing session
# http://stackoverflow.com/a/34683596/1569492
function fixssh() {
    eval $(tmux show-env -s | /bin/grep '^SSH')
}

# ls everything we cd into
function cd() {
    builtin cd "$@"
    ls
}

eval "$(direnv hook zsh)"
      '';

      shellAliases = {
        grep = "grep --color=auto";
        ls="ls --color=auto -F --group-directories-first";
        ll="ls -al";
      };

  };


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.03";
}
