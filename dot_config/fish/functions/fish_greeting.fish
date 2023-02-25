function fish_greeting
    if type -q archey
        echo
        archey
        echo
    end

    if not type -q fisher
        echo "✨使用以下命令初始化 Fisher："
        echo
        echo "    \$ curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher && fisher update"
        echo
    end
end
