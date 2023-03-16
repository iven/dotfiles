{ config, pkgs, ... }:
{
  home = {
    stateVersion = "22.11";
    enableNixpkgsReleaseCheck = true;
    packages = [
      pkgs.bat
      pkgs.btop
      pkgs.chezmoi
      pkgs.delta
      pkgs.exa
      pkgs.fd
      pkgs.fish
      pkgs.fx
      pkgs.fzf
      pkgs.getent
      pkgs.git
      pkgs.grc
      pkgs.htop
      pkgs.sumneko-lua-language-server
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
  # # nix 的 neovim 的 treesitter 不好使，禁用
  # # https://github.com/NixOS/nixpkgs/issues/207003
  # programs.neovim = {
  #   enable = true;
  #   package = pkgs.nix;
  #   defaultEditor = true;
  #   viAlias = true;
  #   vimAlias = true;
  #   vimdiffAlias = true;
  #   withPython3 = false;
  #   withRuby = false;
  # };
}
