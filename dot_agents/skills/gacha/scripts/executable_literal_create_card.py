#!/usr/bin/env python3
"""创建 Gacha 记忆卡文件：生成文件名与 frontmatter，正文从 stdin 读取。

用法：python3 create_card.py [分类] < 正文    （分类默认 日本語）
"""

import argparse
import random
import string
import sys
from datetime import datetime, timezone
from pathlib import Path

MEMORY_ROOT = Path.home() / "Dropbox" / "Notes" / "Gacha" / "memory"
SUFFIX_LEN = 6
SUFFIX_CHARS = string.ascii_lowercase + string.digits


def random_suffix() -> str:
    rng = random.SystemRandom()
    return "".join(rng.choice(SUFFIX_CHARS) for _ in range(SUFFIX_LEN))


def frontmatter(card_id: str, iso: str) -> str:
    return "\n".join(
        [
            "---",
            f"id: {card_id}",
            f"due: {iso}",
            "stability: null",
            "difficulty: null",
            "last_seen: null",
            f"created_at: {iso}",
            f"updated_at: {iso}",
            "---",
        ]
    )


def main() -> int:
    parser = argparse.ArgumentParser(description="创建 Gacha 记忆卡文件")
    parser.add_argument("category", nargs="?", default="日本語", help="分类目录名，默认日本語")
    args = parser.parse_args()

    out_dir = MEMORY_ROOT / args.category
    if not out_dir.is_dir():
        print(f"错误：分类目录不存在：{out_dir}", file=sys.stderr)
        return 1

    ts = datetime.now(timezone.utc)
    card_id = ts.strftime("%Y%m%d-%H%M%S") + "-" + random_suffix()
    iso = ts.strftime("%Y-%m-%dT%H:%M:%S.000Z")
    body = sys.stdin.read().strip("\n")

    path = out_dir / f"{card_id}.md"
    path.write_text(
        frontmatter(card_id, iso) + "\n\n" + body + "\n",
        encoding="utf-8",
    )
    print(path)
    return 0


if __name__ == "__main__":
    sys.exit(main())
