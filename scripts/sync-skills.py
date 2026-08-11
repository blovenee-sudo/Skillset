"""
skills/*.md → skills/index.json 동기화 스크립트

각 기본 스킬 MD 파일의 내용(frontmatter 제거 후)을
index.json의 prompt 필드에 반영합니다.

사용:
    python3 scripts/sync-skills.py
"""

import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).parent.parent
INDEX_PATH = ROOT / "skills" / "index.json"

# MD 파일명: {skill_id}-{slash_without_slash}.md
MD_MAP = {
    "s1": "s1-spec",
    "p2": "p2-token",
    "p3": "p3-mockup",
    "p4": "p4-handoff",
    "qa": "qa-qa",
}

def strip_frontmatter(text):
    return re.sub(r"^---[\s\S]*?---\s*\n", "", text).strip()

def extract_downloads(text):
    fm = re.match(r"^---[\s\S]*?---", text)
    if not fm:
        return None
    dl = re.search(r"^downloads:\s*(.+)$", fm.group(0), re.MULTILINE)
    if not dl:
        return None
    try:
        return json.loads(dl.group(1).strip())
    except Exception:
        return None

def main():
    with open(INDEX_PATH, encoding="utf-8") as f:
        skills = json.load(f)

    updated = []
    for sk in skills:
        sid = sk.get("id")
        if sid not in MD_MAP:
            continue
        md_path = ROOT / "skills" / f"{MD_MAP[sid]}.md"
        if not md_path.exists():
            print(f"  경고: {md_path.name} 없음, 건너뜀")
            continue
        raw = md_path.read_text(encoding="utf-8")
        body = strip_frontmatter(raw)
        downloads = extract_downloads(raw)
        changed = False
        if body and sk.get("prompt") != body:
            sk["prompt"] = body
            changed = True
        if downloads != sk.get("downloads"):
            if downloads is not None:
                sk["downloads"] = downloads
            elif "downloads" in sk:
                del sk["downloads"]
            changed = True
        if changed:
            updated.append(sid)

    if updated:
        with open(INDEX_PATH, "w", encoding="utf-8") as f:
            json.dump(skills, f, ensure_ascii=False, indent=2)
        print(f"sync-skills: index.json 업데이트 ({', '.join(updated)})")
    else:
        print("sync-skills: 변경 없음")

if __name__ == "__main__":
    main()
