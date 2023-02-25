{ config, pkgs, ... }:
{
  imports = [ ./common.nix ];

  home.username = "iven";
  home.homeDirectory = "/home/iven";

  home.sessionVariables.LOCALE_ARCHIVE = "/usr/lib/locale/locale-archive";
  home.sessionVariables.NIX_PROFILE_NAME = "linux";
}
