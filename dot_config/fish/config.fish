########## PATH ##########

fish_add_path $HOME/.bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.krew/bin
fish_add_path /opt/homebrew/bin

########## 环境变量 ##########

set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx PAGER less -RFXM
set -gx PYTHONIOENCODING utf-8
set -gx no_proxy localhost,127.0.0.1

if test -f /etc/profile.d/99-wukong.sh; and type -q replay
    replay source /etc/profile.d/99-wukong.sh
end

if test -f $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh; and type -q replay
    replay source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
end

if test -f $HOME/.nix-profile/etc/profile.d/nix.fish
    source $HOME/.nix-profile/etc/profile.d/nix.fish
end

if test -f /etc/profile.d/nix-daemon.fish
    source /etc/profile.d/nix-daemon.fish
end

########## 交互式会话 ##########

if status is-interactive
    ########## 缩写和别名 ##########

    abbr -a cpr cp -r
    abbr -a rmr rm -Irf
    abbr -a pg pgrep -alf

    if command -sq bat; or command -sq batcat
        if command -sq bat
            alias cat bat
        else if command -sq batcat
            alias cat batcat
        end
    end

    if command -sq delta
        alias diff delta
    end

    if command -sq eza
        alias ls "eza --icons"
        abbr -a tree ls --tree
        abbr -a la ls -lahmubg --time-style long-iso --git
    end

    if command -sq fd
        abbr -a f fd
    end

    if type -q kitten
        abbr -a e edit-in-kitty
        abbr -a icat kitten icat
    end

    if type -q lazygit
        abbr -a lg lazygit
    end

    if type -q nvim
        abbr -a vi nvim
        abbr -a vim nvim
    end

    if type -q chezmoi
        abbr -a cz chezmoi
        abbr -a cza chezmoi add
        abbr -a czap chezmoi apply --verbose
        abbr -a czcd cd (chezmoi source-path)
        abbr -a czd chezmoi diff
        abbr -a cze chezmoi edit
        abbr -a czi chezmoi init
        abbr -a czu chezmoi update
    end

    if command -sq kubectl
        abbr -a k kubectl
    end

    if command -sq systemctl
        abbr -a S sudo systemctl
        abbr -a start sudo systemctl start
        abbr -a stop sudo systemctl stop
        abbr -a restart sudo systemctl restart
        abbr -a enable sudo systemctl enable
        abbr -a disable sudo systemctl disable
        abbr -a st sudo systemctl status
    end

    if command -sq yay
        abbr -a y yay
        abbr -a ys yay -S
        abbr -a ysu yay -Su
        abbr -a ysyu yay -Syu
        abbr -a yr yay -Rs
        abbr -a yrd yay -Rdd
        abbr -a yql yay -Ql
        abbr -a yqo yay -Qo
        abbr -a yu yay -U
    end

    ########## 环境变量 ##########

    # gnupg
    set -x GPG_TTY (tty)
    if command -sq gpgconf
        gpgconf --launch gpg-agent
    end
    if command -sq gpg-connect-agent
        gpg-connect-agent updatestartuptty /bye &>/dev/null
    end

    # ssh
    set -e SSH_AGENT_PID
    if command -sq gpgconf
        if test -n "$SSH_TTY"
            set -gx SSH_AUTH_SOCK (gpgconf --list-dirs homedir)/S.gpg-agent.ssh
        else
            set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
        end
    end

    if command -sq fzf
        set fzf_fd_opts --hidden --exclude=.git
        set fzf_preview_dir_cmd eza --all --color=always
    end

    if command -sq direnv
        set -gx DIRENV_LOG_FORMAT ""
        direnv hook fish | source
    end

    ########## 其他 ##########

    if command -sq starship
        set -gx STARSHIP_LOG error
        starship init fish | source
    end
end
