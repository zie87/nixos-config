#
# Podman 
#

{ config, pkgs, vars, ... }:

{
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
      extraPackages = [
        pkgs.podman-tui
        pkgs.podman-compose
      ];
    };
    oci-containers = {
      backend = "podman";
    };
  };

  users.groups.docker.members = [ "${vars.user}" ];
}
