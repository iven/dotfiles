#!/usr/bin/env bash
# Gacha 卡片格式检查。
# 用法：check_card.sh <文件路径> [文件路径...]
# 退出码：0 = 全部通过，1 = 有匹配项
set -uo pipefail

if [ $# -eq 0 ]; then
    echo "用法：$(basename "$0") <文件路径> [文件路径...]" >&2
    exit 1
fi

for cmd in rg perl; do
    if ! command -v "$cmd" >/dev/null; then
        echo "缺少命令：$cmd" >&2
        exit 1
    fi
done

status=0

run_check() {
    local label=$1
    shift
    local output rc
    output=$("$@" 2>&1) && rc=0 || rc=$?
    if [ "$rc" -gt 1 ]; then
        echo "[ERROR] $label（命令执行失败，退出码 $rc）" >&2
        printf '%s\n' "$output" >&2
        status=1
    elif [ -n "$output" ]; then
        echo "[NG] $label"
        printf '%s\n' "$output"
        status=1
    fi
}

for file in "$@"; do
    if [ ! -f "$file" ]; then
        echo "文件不存在：$file" >&2
        status=1
        continue
    fi

    echo "===== $file ====="

    run_check '1. 残缺注音' rg -n '\{[^}|]*\}' "$file"
    run_check '2. 注音块外残留汉字' rg -n -P '\{[^}|]*\|[^}]*\}(*SKIP)(*F)|\[[^\[\]]*\](*SKIP)(*F)|[一-龠々]' "$file"
    run_check '3. 粗体贴字（前）' rg -n '[ぁ-ゖァ-ヺ一-龠々]\*\*\{' "$file"
    run_check '4. 粗体贴字（后）' rg -n '[ぁ-ゖァ-ヺ一-龠々}]\*\*(?=[ぁ-ゖァ-ヺ一-龠々{])' --pcre2 "$file"
    run_check '5. 注音块基底含假名' rg -n -P '\{[^}|]*[ぁ-ゖァ-ヺ][^}|]*\|[^}]*\}' "$file"
    run_check '6. 注音切分段数与基底字符数不一致' perl -CSD -Mutf8 -ne 'while(/\{([^|}]*)\|([^}]*)\}/g){my($b,$r)=($1,$2);my$k=()=$b=~/[\p{Han}々0-9]/g;my$d=()=$r=~/・/g;print "$ARGV:$.:$_\n" if$d+1!=$k}' "$file"
    run_check '7. 连续引用块（中间缺空行）' rg -n -U '^>[^\n]*\n>' "$file"

    echo
done

if [ "$status" -eq 0 ]; then
    echo '全部通过'
else
    echo '发现问题'
fi

exit "$status"
