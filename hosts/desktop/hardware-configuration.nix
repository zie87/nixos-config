# Hardware settings for my Threadripper
#
# flake.nix
#  └─ ./hosts
#      └─ ./desktop
#          ├─ default.nix
#          └─ hardware-configuration.nix *
#
# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
#

{ config, lib, pkgs, modulesPath, host, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/bef81b07-5e09-4b08-8a34-12e40c5accb1";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/1979-62F9";
      fsType = "vfat";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/b2662533-0ec0-47c1-a6f3-44491c0f15c3";
      fsType = "ext4";
    };

  fileSystems."/mnt/data" =
    { device = "/dev/disk/by-uuid/f1238117-5d03-466a-a52d-f061b0da14f3";
      fsType = "btrfs";
    };

  fileSystems."/mnt/backup" =
    { device = "/dev/disk/by-uuid/5bd0e0e9-eb27-4969-bca3-9d3e69987952";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/394e94b5-69f2-4dcb-870c-4fd9fd44210c"; }
    ];



  networking = with host; {
    hostName = hostName;  
    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    useDHCP = lib.mkDefault true;
    # interfaces.enp69s0.useDHCP = lib.mkDefault true;
    # interfaces.enp71s0.useDHCP = lib.mkDefault true;
    # interfaces.wlp70s0.useDHCP = lib.mkDefault true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
