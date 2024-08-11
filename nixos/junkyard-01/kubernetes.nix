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
    flannel.enable = true;
    kubelet.extraOpts = "--network-plugin=cni";
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

  # Ensure the CNI plugin directory exists
  # system.activationScripts.mkCniPluginDir = ''
  #   mkdir -p /opt/cni/bin
  # '';

  # Set up Flannel configuration
  # environment.etc."kube-flannel/net-conf.json".text = ''
  #   {
  #     "Network": "10.244.0.0/16",
  #     "Backend": {
  #       "Type": "vxlan"
  #     }
  #   }
  # '';

}
