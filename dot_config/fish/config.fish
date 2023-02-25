########## PATH ##########

fish_add_path $HOME/.bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.krew/bin

########## 环境变量 ##########

set -gx EDITOR vim
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

########## 交互式会话 ##########

if status is-interactive
    ########## 缩写和别名 ##########

    abbr -a cpr cp -r
    abbr -a rmr rm -Irf
    abbr -a pg pgrep -lf

    if command -sq bat; or command -sq batcat
        if command -sq bat
            alias cat bat
        end

        if command -sq batcat
            alias cat batcat
        end
    end

    if command -sq delta
        alias diff delta
    end

    if command -sq exa
        alias ls "exa --icons"
        abbr -a tree ls --tree
        abbr -a la ls -lahb --time-style long-iso --git
    end

    if command -sq fd
        abbr -a f fd
    end

    if type -q edit-in-kitty
        abbr -a e edit-in-kitty
    end

    if type -q chezmoi
        abbr -a cz chezmoi
        abbr -a cza chezmoi add
        abbr -a czap chezmoi apply --verbose
        abbr -a czcd cd (chezmoi source-path)
        abbr -a czd chezmoi diff
        abbr -a czi chezmoi init
    end

    if command -sq kubectl
        abbr -a k kubectl
    end

    if command -sq systemd
        abbr -a S sudo systemd
        abbr -a start sudo systemd start
        abbr -a stop sudo systemd stop
        abbr -a restart sudo systemd restart
        abbr -a enable sudo systemd enable
        abbr -a disable sudo systemd disable
        abbr -a st sudo systemd status
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

    # gnupg & ssh
    if command -sq gpgconf
        gpgconf --launch gpg-agent
    end
    set -e SSH_AGENT_PID
    set -gx SSH_AUTH_SOCK $HOME/.gnupg/S.gpg-agent.ssh
    # 这种写法在 gpg 低版本下不好使
    # set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    set -x GPG_TTY (tty)
    if command -sq gpg-connect-agent
        gpg-connect-agent updatestartuptty /bye &>/dev/null
    end

    if command -sq fzf
        set fzf_fd_opts --hidden --exclude=.git
        set fzf_preview_dir_cmd exa --all --color=always
    end

    ########## 其他 ##########

    if command -sq starship
        starship init fish | source
    end
end
