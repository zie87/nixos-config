#
#  Main system configuration. More information available in configuration.nix(5) man page.
#
#  flake.nix
#   ├─ ./hosts
#   │   ├─ default.nix
#   │   └─ configuration.nix *
#   └─ ./modules
#       ├─ ./desktops
#       │   └─ default.nix
#       ├─ ./editors
#       │   └─ default.nix
#       ├─ ./programs
#       │   └─ default.nix
#       ├─ ./services
#       │   └─ default.nix
#       ├─ ./shell
#       │   └─ default.nix
#

{ config, lib, pkgs, unstable, inputs, vars, ... }:

{
  imports = ( import ../modules/desktops ++
              import ../modules/browsers ++
              import ../modules/editors ++
              import ../modules/programs ++
              import ../modules/services ++
              import ../modules/shell);

  users.users.${vars.user} = {              # System User
    isNormalUser = true;
    description = "${vars.userDescription}";
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "kvm"];
  };

  time.timeZone = "Europe/Zurich";        # Time zone and Internationalisation
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  fonts.fonts = with pkgs; [                # Fonts
    roboto
    font-awesome                            # Icons
    powerline-fonts                         # Powerline
    (nerdfonts.override {                   # Nerdfont Icons override
      fonts = [
        "RobotoMono"
        "Monofur"
      ];
    })
  ];

  environment = {
    variables = {                           # Environment Variables
      TERMINAL = "${vars.terminal}";
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
    };
    systemPackages = with pkgs; [           # System-Wide Packages
      # Terminal
      btop              # Resource Manager
      coreutils         # GNU Utilities
      git               # Version Control
      killall           # Process Killer
      nano              # Text Editor
      ranger            # File Manager
      usbutils          # Manage USB
      wget              # Retriever

      # Video/Audio
      alsa-utils        # Audio Control
      pavucontrol       # Audio Control
      pipewire          # Audio Server/Control
      pulseaudio        # Audio Server/Control

      # Apps

      # File Management
      pcmanfm           # File Browser
      p7zip             # Zip Encryption
      rsync             # Syncer - $ rsync -r dir1/ dir2/
      unzip             # Zip Files
      unrar             # Rar Files
      zip               # Zip

      # Other Packages Found @
      # - ./<host>/default.nix
      # - ../modules
    ];
  };

  programs = {
    dconf.enable = true;
    gnupg = {
      agent = {
        enable = true;
        enableExtraSocket = true;
        pinentryFlavor = "curses";
      };
    };
  };

  services = {
    printing = {                            # CUPS
      enable = true;
    };
    pipewire = {                            # Sound
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
    openssh = {                             # SSH
      enable = true;
      allowSFTP = true;                     # SFTP
      extraConfig = ''
        HostKeyAlgorithms +ssh-rsa
      '';
    };
  };

  # flatpak.enable = true;                    # Enable Flatpak (see module options)

  nix = {                                   # Nix Package Manager Settings
    settings ={
      auto-optimise-store = true;
    };
    gc = {                                  # Garbage Collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    package = pkgs.nixVersions.unstable;    # Enable Flakes
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  nixpkgs.config.allowUnfree = true;        # Allow Proprietary Software.

  system = {                                # NixOS Settings
    stateVersion = "23.05";
  };

  home-manager.users.${vars.user} = {       # Home-Manager Settings
    home = {
      stateVersion = "23.05";
    };

    programs = {
      home-manager.enable = true;
    };
  };
}
