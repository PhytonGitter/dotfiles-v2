{ config, pkgs, ... }:

{
  # Import the Waybar config and style module
  imports = [
    ./modules/waybar/waybar-config.nix
    ./modules/waybar/waybar-style.nix
  ];

  home.username = "kevin";
  home.homeDirectory = "/home/kevin";

  home.stateVersion = "24.05";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    waybar    
    font-awesome
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
