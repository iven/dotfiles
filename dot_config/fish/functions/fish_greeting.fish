function fish_greeting
    if type -q archey
        echo
        archey
        echo
    end

    if not type -q fisher
        echo "✨设置好代理服务器后，使用以下命令初始化 Fisher："
        echo
        echo "    \$ curl -sL https://git.io/fisher | source && fisher update"
        echo
    end
end
