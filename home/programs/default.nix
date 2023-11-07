let
  more = {pkgs, ...}: {
    programs = {
      lf.enable = true;       # terminal file browser
      eza.enable = true;      # a better `ls`
      bat.enable = true;      # cat alternative
      ripgrep.enable = true;  # fast grep
      tealdeer.enable = true; # tldr front end
      imv.enable = true;      # image viewer
      zathura.enable = true;  # pdf viewer
      zoxide = {              # directory jumps
        enable = true;
        enableBashIntegration = true;
      };
      zellij = {              # terminal multiplexer
        enable = true;
        enableBashIntegration = true;
      };
      fzf = {                 # fuzzy finder
        enable = true;
        enableBashIntegration = true;
      };

      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      gpg.enable = true;
      ssh.enable = true;
    };
  };
in [
  ./browser/firefox.nix
  ./config
  ./cli
  ./alacritty.nix
  ./git.nix
  ./network.nix
  more
]
