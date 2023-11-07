{ config, lib, modulesPath, ... }:
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi = {
        canTouchEfiVariables = true;
      };
      timeout = 5;
    };

    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "ahci" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = ["amdgpu"];
    };
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
  };

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

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
