#!/usr/bin/env bash
# 查询日语词的音调。
# 用法：get_pitch_accent.sh <词> [词...]
# 同一个词应同时传入汉字表记与假名表记。
set -uo pipefail

if [ $# -eq 0 ]; then
    echo "用法：$(basename "$0") <词> [词...]" >&2
    echo "提示：同时传入汉字表记与假名表记，如：$(basename "$0") 訪ねる たずねる" >&2
    exit 1
fi

for word in "$@"; do
    echo "===== $word ====="

    echo "--- dict.asia ---"
    dict_result=$(curl -L --silent "https://m.dict.asia/jc/$word" | rg -n "jpword|kana_|tone_jp" || true)
    if [ -n "$dict_result" ]; then
        printf '%s\n' "$dict_result"
    else
        echo "(无匹配)"
    fi

    echo "--- jpdb.io ---"
    jpdb_result=$(curl -Ls "https://jpdb.io/search?q=$word" | rg -o 'Pitch accent.{0,1500}' | head -1 || true)
    if [ -n "$jpdb_result" ]; then
        printf '%s\n' "$jpdb_result"
    else
        echo "(无匹配)"
    fi

    echo
done

exit 0
