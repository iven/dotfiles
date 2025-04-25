{ config, pkgs, ... }: {
  home = {
    stateVersion = "23.05";
    enableNixpkgsReleaseCheck = true;
    packages = with pkgs; [
      aider-chat
      basedpyright
      bat
      bat-extras.batman
      bat-extras.prettybat
      btop
      chezmoi
      cmake-language-server
      delta
      eza
      fastfetch
      fd
      fish
      fx
      fzf
      getent
      gersemi
      git
      grc
      htop
      isort
      jinja-lsp
      lazygit
      sumneko-lua-language-server
      nil
      nix-index
      nixfmt
      ripgrep
      ruff
      rustup
      starship
      typescript-language-server
      tig
      vscode-langservers-extracted
      xh
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
