{ config, pkgs, ... }:

{
  boot.loader.grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = true;
  };

  time.timeZone = "Europe/Warsaw";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  services.xserver = {
      layout = "pl";
      xkbVariant = "";
  };

  console.keyMap = "pl2";

  networking.networkmanager.enable = true;

  services.logind = {
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
    lidSwitch = "ignore";

    extraConfig = ''
      HandleLidSwitch=ignore
      HandleLidSwitchExternalPower=ignore
    '';
  };

  powerManagement = {
      enable = true;
      powertop.enable = true;
      cpuFreqGovernor = "performance";
  };
}
