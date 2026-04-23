function wmo -d "workmux open - select a worktree with fzf"
    set selected (workmux list | tail -n +2 | grep -v '^\s*main\s' \
        | awk '{printf "%-35s %s\n", $1, $NF}' \
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
