{

  description = "k8s cluster";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.junkyard-01 = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./general-settings.nix
          ./hardware-configuration.nix
          ./kubernetes.nix

          ({ config, pkgs, ... }: {
            nixpkgs.config.allowUnfree = true;
            nix.settings.experimental-features = [ "nix-command" "flakes" ];

            networking = {
              hostName = "junkyard-01";
              firewall.allowedTCPPorts = [
                22
              ];
            };

            services.openssh = {
              enable = true;
              passwordAuthentication = true;
            };

            environment.systemPackages = with pkgs; [
              kubectl
              kubeseal
              helm
              vim
              git
              wget
              curl
            ];

            users.users.kassie = {
              isNormalUser = true;
              description = "Kubernetes administrator";
              home = "/home/kassie";
              extraGroups = [ "wheel" "networkmanager" "docker" "kubernetes" ];
              hashedPassword = "$6$UJF4nxZgr0sWa87q$OL.oo1txNlzy9SrxWs0N8aN3Ox9PttBXfpbBcOviS67qLN8EWWieqWBpm4OlK1ZiA3lWisI7gwyhvtKC9JZem/";
              openssh.authorizedKeys.keys = [
                "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCZdUM+ZCQ0Odgh3KDHw1Fk/iC9L/jE4muEjbqnU/465vVfOngSc/lJGydPg/a8NfBxt8SMSqJXPHgi7UFI8rv9utbst0xawW76KHtlsfSzNQrantRmlyUxCY0LAjSE1pdsk1p2TrKT3jttLUxPGjXCxRkV4P0FHmjASsbVgEhYagyKRLXTb722+BRkZbQqXQPu5xBLVBMOIlQiLnbC0riLblBlNX8Bv44nWiUgmscuz4vlQNudKgcJn0JkGE5hnI0tMoaHNGsz9tjHxKUbMavOfsQ9mzXqH0WPsdvXbaEC6yWrR+e6ODl1tC0byn7OuP89QyFfimuBO2xdV1KVsn1ZPdWCJkgLjYPy5OkjGZttU/wzcQo8SFYwaxsr4QK+nx3ploLSZyjjP8YWqUkl1r3vFB4x9M7B7EkGzITXfAhNwHDjv4CiKJk24mULOLe4zg07Ek4ax0N8eHjeg4RvjKvitCFnDIacoyNpNpKqmwYVKLbNyHtD0WVHjshhNOL5DeAf/GnSEVhkA939KVNIuDrgnQyHFOu2gM+wEX7iZUtkooOSmLxan7WAJoLhX0Es4Izl0zabQA7IerspMKnvx5R8Mms2tyDrws+rcWJRKXtd4lz4Iz9Bn1m7TFQ1KFZMdYcGSEpoJZHxo3jOAJiFmpSzxatBt12XfEBCEQSodDMx5Q== kassie@fedora-2.home"
              ];
            };

            system.stateVersion = "24.05";

            })

        ];

      };

    };
}
