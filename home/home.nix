{pkgs,  ...}: let
  username = "zie";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";
  defaultPkgs = with pkgs; [
    brave
    btop                 # alternative to htop & ytop
    cacert               # ca certificates
    duf                  # disk usage/free utility
    fd                   # "find" for files
    pavucontrol          # pulseaudio volume control
    paprefs              # pulseaudio preferences
    ranger               # terminal file manager
    zathura              # document viewer
    just                 # command runner inspired by make
    p7zip                # Zip Encryption
    unzip                # Zip Files
    unrar                # Rar Files
    zip                  # Zip

    neovide
    calibre		 # e-book manager and software
    steam-run
    glxinfo
    vulkan-tools
  ];
in {
  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
  };

  programs.home-manager.enable = true;
  imports = builtins.concatMap import [
    ./programs
    ./services
  ];

  xdg = {
    inherit configHome;
    enable = true;
  };

  home = {
    inherit username homeDirectory;
    stateVersion = "23.05";
    packages = defaultPkgs;
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  # notifications about home-manager news
  news.display = "silent";
}
