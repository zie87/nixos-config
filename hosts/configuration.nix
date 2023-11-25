{ config, lib, pkgs, inputs, vars, ... }:
{
  imports = [./system];

  system.stateVersion = "23.11";
  # NixOS Network Configuration
  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
  };

  nix = {                                   # Nix Package Manager Settings
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
    gc = {                                  # Garbage Collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    optimise = {                            # Enable optimisation
      automatic = true;
      dates = ["weekly"];
    };
    package = pkgs.nixVersions.unstable;    # Enable Flakes
  };
  nixpkgs.config.allowUnfree = true;        # Allow Proprietary Software.

  time.timeZone = "Europe/Zurich";        # Time zone and Internationalisation
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  # Configure console keymap
  console = {
    keyMap =  lib.mkDefault "us";
    useXkbConfig = true;
  };
  
  programs.dconf.enable = true;
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
  sound.enable = true;
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  hardware = {
    opengl = {                                  # Hardware Accelerated Video
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = [ pkgs.mesa.drivers pkgs.amdvlk ];
      extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
    };
    bluetooth.enable = true;
    # Enable braodcom chip for bluetooth
    enableAllFirmware = true;
    pulseaudio.enable = false;
  };  

  virtualisation = {
    podman.enable = true;
    libvirtd.enable = true;
    docker = {
      enable = true;
      daemon.settings = {
        data-root = "/opt/docker";
      };
    };
  };
}
