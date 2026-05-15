function wmo -d "workmux open - select a worktree with fzf"
    set selected (workmux list | tail -n +2 | grep -v '^\s*main\s' \
        | awk '{
            age = $2
            if (age == "<1m") sec = 0
            else {
                n = age + 0
                unit = substr(age, length(n "") + 1)
                if (unit == "m") sec = n * 60
                else if (unit == "h") sec = n * 3600
                else if (unit == "d") sec = n * 86400
                else if (unit == "w") sec = n * 604800
                else if (unit == "mo") sec = n * 2592000
                else if (unit == "y") sec = n * 31536000
                else sec = 9999999999
            }
            printf "%012d\t%-35s %-6s %s\n", sec, $1, $2, $NF
        }' \
        | sort -n \
        | cut -f2- \
        | fzf \
            --height=~10 \
            --reverse \
            --border=rounded \
            --prompt="worktree> ")
    if test -n "$selected"
        set branch (echo $selected | awk '{print $1}')
        workmux open $branch
    end
end
