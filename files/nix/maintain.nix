{ config, pkgs, ... }:
{
  imports = [ ./wukong.nix ];

  home.username = pkgs.lib.mkOverride 10 "maintain";
  home.homeDirectory = pkgs.lib.mkOverride 10 "/home/maintain";

  home.packages = [
    pkgs.gnupg
  ];
  home.sessionVariables.NIX_PROFILE_NAME = pkgs.lib.mkOverride 10 "maintain";
}
