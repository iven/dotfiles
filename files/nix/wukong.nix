{ config, pkgs, ... }:
{
  imports = [ ./linux.nix ];

  home.username = pkgs.lib.mkForce "wukong";
  home.homeDirectory = pkgs.lib.mkForce "/home/wukong";

  home.sessionVariables.NIX_PROFILE_NAME = pkgs.lib.mkForce "wukong";
}
