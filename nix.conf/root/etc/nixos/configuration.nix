{ config, pkgs, ... } :

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-larluo"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  virtualisation.docker.enable = true ;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8"
                         "zh_CN.UTF-8/UTF-8"
                         "zh_CN/GB2312"
                         "zh_CN.GBK/GBK"
                         "zh_CN.GB18030/GB18030"
                         "zh_TW.UTF-8/UTF-8"
                         "zh_TW/BIG5" ];
  };
  i18n.inputMethod = {
    enabled = "fcitx" ;
    fcitx.engines = with pkgs.fcitx-engines; [ rime ] ;
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai" ;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget vim
  ];


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  services.privoxy.enable = true ;
  services.privoxy.listenAddress = "0.0.0.0:8118" ;
  services.privoxy.extraConfig = ''
    forward-socks5 / 0.0.0.0:1080 .
  '' ;

  users.extraUsers.larluo = {
    isNormalUser = true ;
    home = "/home/larluo" ;
    hashedPassword = "$6$hmE0Eyz0J235ca$mS7HW6HJfWSzlCX3BBszOZGD8wcHSYP8kVHIFZD5KHtzOA9F0aqnmtFPIjIQObw5jIvtIeLyyClnwXF4PPNhJ1" ;
    extraGroups = ["wheel" "networkmanager" "docker" ] ;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?


}
