{

  description = "k8s cluster"

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flke-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
      in
      {
        nixosConfigurations.k8s-master = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              ({ config, pkgs, ... }: {
                  boot.isContainer = false;

                  networking = {
                      hostName = "k8s-master";
                      firewall.allowedTCPPorts = [
                        6443 
                        2379 
                        2380 
                        10250 
                        10251 
                        10252
                      ];
                    };

                  services.kubernetes = {
                      roles = ["master"];
                      masterAddress = "k8s-master";
                      apiserverAddress = "https://k8s-master:6433";
                      easyCerts = true;
                      apiServer = {
                          extraOpts = "--allow-privileged";
                        };
                    };

                  environment.systemPackages = with pkgs; [
                    kubectl
                    kubernetes
                  ]
                })
            ]
          }
        }
    )

}
