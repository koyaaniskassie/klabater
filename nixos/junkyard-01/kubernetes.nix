{ config, pkgs, ... }:

{

  services.kubernetes = {
    roles = ["master" "node"];
    masterAddress = "junkyard-01";
    apiserverAddress = "https://junkyard-01:6443";
    easyCerts = true;
    apiserver = {
      securePort = 6443;
      advertiseAddress = "192.168.1.37";
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      8080 
      6443
      2379
      2380
      10250
      10251
      10252
      10255
    ];

    allowedUDPPorts = [
      8472
    ];
  };

  virtualisation.containerd = {
    enable = true;
    settings = {
      version = 2;
      plugins."io.containerd.grpc.v1.cri" = {
        cni = {
          bin_dir = "/opt/cni/bin";
          conf_dir = "/etc/cni/net.d";
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    kubectl
    kubernetes
    cri-tools
    cni-plugins
  ];

}
