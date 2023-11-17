{ pkgs, lib, ...}: 
{
  imports = [
    ./hardware-configuration.nix
  ];

  desktop.environment = "hyprland";
  users.users = {
    zie = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "docker" "libvirtd" "kvm" "video" "audio" "plugdev"];
    };
  };

  networking = {
    hostName = "fenrisulfr";  
    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    useDHCP = lib.mkDefault true;
    # interfaces.enp69s0.useDHCP = lib.mkDefault true;
    # interfaces.enp71s0.useDHCP = lib.mkDefault true;
    # interfaces.wlp70s0.useDHCP = lib.mkDefault true;
  };

  services = {
    dbus.enable = true;
    xserver = {
      videoDrivers = ["amdgpu"];
      displayManager = {
        sessionCommands = ''
          ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
        '';
      };
    };
    keyd = {
      enable = false;
      keyboards = {
        default = {
          ids = ["*"];
          settings = {
            main = {
              capslock = "overload(esc, meta)";
            };
          };
        };
      };
    };
  };
}
