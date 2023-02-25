{ config, pkgs, ... }:
{
  home = {
    stateVersion = "22.11";
    enableNixpkgsReleaseCheck = true;
    packages = [
      pkgs.bat
      pkgs.btop
      pkgs.chezmoi
      pkgs.exa
      pkgs.fd
      pkgs.fish
      pkgs.fx
      pkgs.fzf
      pkgs.getent
      pkgs.git
      pkgs.gnupg
      pkgs.grc
      pkgs.htop
      pkgs.nil
      pkgs.nix-index
      pkgs.nixpkgs-fmt
      pkgs.pyright
      pkgs.ripgrep
      pkgs.rust-analyzer
      pkgs.starship
      pkgs.tig
    ];
  };
  programs.home-manager.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withPython3 = false;
    withRuby = false;
  };
}
