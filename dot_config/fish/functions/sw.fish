function sw -d "切换/更新 home-manager 配置"
    if type -q chezmoi
        set CHEZMOI_ROOT (chezmoi source-path)
    else
        set CHEZMOI_ROOT $HOME/.local/share/chezmoi/
    end

    home-manager switch --flake "$CHEZMOI_ROOT/files#$NIX_PROFILE_NAME"
end
