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
      claude-code
      cmake-language-server
      delta
      eza
      fastfetch
      fd
      fish
      fx
      fzf
      gersemi
      getent
      git
      grc
      htop
      isort
      jinja-lsp
      lazygit
      nil
      nix-index
      nixfmt
      ripgrep
      ruff
      rustup
      starship
      sumneko-lua-language-server
      tig
      typescript-language-server
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
