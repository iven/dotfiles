{ config, pkgs, ... }:
{
  imports = [ ./common.nix ];

  home.username = "iven";
  home.homeDirectory = "/Users/iven";

  home.packages = [
    pkgs.gnupg
  ];
  home.sessionVariables.NIX_PROFILE_NAME = "darwin";
}
