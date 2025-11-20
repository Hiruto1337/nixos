{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./users.nix
    ];
  xdg.portal.enable = true;
  nixpkgs.config.permittedInsecurePackages = [
    "broadcom-sta-6.30.223.271-57-6.12.55"
  ];
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    # substituters = ["https://hyprland.cachix.org"];
    # trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  time.timeZone = "Europe/Copenhagen";
  services.libinput.enable = true;
  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
  };
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  ################################################################
  # NixOS Modules
  programs.hyprland.enable = true;
  services.xserver = {
    displayManager.gdm.enable = true;
    xkb = {
      layout = "dk";
      variant = "";
    };
  };

  # NixOS Packages
  # environment.systemPackages = with pkgs; [];
  ################################################################

  programs.mtr.enable = true;
  system.stateVersion = "25.05";
}

