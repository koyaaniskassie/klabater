# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "junkyard-01"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  services.logind.lidSwitchExternalPower = "ignore";

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  services.k3s = {
    enable = true;
    role = "server";
    token = "49l5BGTMWkM92AME";
    extraFlags = toString ([
	    "--write-kubeconfig-mode \"0644\""
	    "--cluster-init"
    ]);
    clusterInit = true;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kassie = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
    hashedPassword = "$6$RQAoEkGtl0cc1CWN$69wtijGfXBPBuOuczqpvx635FcGpDTdhna52xKju2wgcI4V7kZaZ27F/9xQVmPAB5Dg2ss7YGdKVRS7lXwXd60";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCZdUM+ZCQ0Odgh3KDHw1Fk/iC9L/jE4muEjbqnU/465vVfOngSc/lJGydPg/a8NfBxt8SMSqJXPHgi7UFI8rv9utbst0xawW76KHtlsfSzNQrantRmlyUxCY0LAjSE1pdsk1p2TrKT3jttLUxPGjXCxRkV4P0FHmjASsbVgEhYagyKRLXTb722+BRkZbQqXQPu5xBLVBMOIlQiLnbC0riLblBlNX8Bv44nWiUgmscuz4vlQNudKgcJn0JkGE5hnI0tMoaHNGsz9tjHxKUbMavOfsQ9mzXqH0WPsdvXbaEC6yWrR+e6ODl1tC0byn7OuP89QyFfimuBO2xdV1KVsn1ZPdWCJkgLjYPy5OkjGZttU/wzcQo8SFYwaxsr4QK+nx3ploLSZyjjP8YWqUkl1r3vFB4x9M7B7EkGzITXfAhNwHDjv4CiKJk24mULOLe4zg07Ek4ax0N8eHjeg4RvjKvitCFnDIacoyNpNpKqmwYVKLbNyHtD0WVHjshhNOL5DeAf/GnSEVhkA939KVNIuDrgnQyHFOu2gM+wEX7iZUtkooOSmLxan7WAJoLhX0Es4Izl0zabQA7IerspMKnvx5R8Mms2tyDrws+rcWJRKXtd4lz4Iz9Bn1m7TFQ1KFZMdYcGSEpoJZHxo3jOAJiFmpSzxatBt12XfEBCEQSodDMx5Q=="
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     neovim
     k3s
     git
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 80 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}
