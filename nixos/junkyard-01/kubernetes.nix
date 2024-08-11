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
    addons.dashboard.enable = true;

    kubelet.extraOps = "--network-plugin=cni";
  };

  networking.firewall = {
    allowedTCPPorts = [
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

  services.flannel = {
    enable = true;
    network = "10.244.0.0/16";
  };

  environment.etc."cni/net.d/10-flannel.conflist".source = pkgs.writeText "10-flannel.conflist" ''
    {
      "name": "cbr0",
      "cniVersion": "0.3.1",
      "plugins": [
        {
          "type": "flannel",
          "delegate": {
            "hairpinMode": true,
            "isDefaultGateway": true
          }
        },
        {
          "type": "portmap",
          "capabilities": {
            "portMappings": true
          }
        }
      ]
    }
  '';

  environment.systemPackages = with pkgs; [
    kubectl
    kubernetes
    cri-tools
  ];
}
