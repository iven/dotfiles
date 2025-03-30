{ config, pkgs, ... }: {
  home = {
    stateVersion = "23.05";
    enableNixpkgsReleaseCheck = true;
    packages = [
      pkgs.aider-chat
      pkgs.basedpyright
      pkgs.bat
      pkgs.btop
      pkgs.chezmoi
      pkgs.cmake-language-server
      pkgs.delta
      pkgs.eza
      pkgs.fastfetch
      pkgs.fd
      pkgs.fish
      pkgs.fx
      pkgs.fzf
      pkgs.getent
      pkgs.gersemi
      pkgs.git
      pkgs.grc
      pkgs.htop
      pkgs.isort
      pkgs.jinja-lsp
      pkgs.lazygit
      pkgs.sumneko-lua-language-server
      pkgs.nil
      pkgs.nix-index
      pkgs.nixfmt
      pkgs.ripgrep
      pkgs.ruff
      pkgs.rustup
      pkgs.starship
      pkgs.typescript-language-server
      pkgs.tig
      pkgs.vscode-langservers-extracted
      pkgs.xh
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
