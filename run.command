#!/bin/bash
# UX AI 스킬셋 — Mac 실행 스크립트
# 더블클릭으로 실행하세요. 처음 실행 시 우클릭 → 열기 로 Gatekeeper 허용 필요.

cd "$(dirname "$0")"

# ── Claude Code 슬래시 명령어 자동 설치 ──────────────────────
SKILLS_DIR="$(dirname "$0")/skills"
CLAUDE_CMD="$HOME/.claude/commands"
mkdir -p "$CLAUDE_CMD"
installed=0
for md in "$SKILLS_DIR"/s*.md; do
  [ -f "$md" ] || continue
  filename=$(basename "$md")
  cmdname="${filename#s[0-9]*-}"          # s0-figma-draft.md → figma-draft.md
  # frontmatter(--- 블록) 제거 후 본문만 복사
  awk '/^---/{f++; next} f>=2' "$md" | sed '/./,$!d' > "$CLAUDE_CMD/$cmdname"
  installed=$((installed + 1))
done
[ $installed -gt 0 ] && echo "✅ Claude Code 스킬 명령어 ${installed}개 설치 → ~/.claude/commands/"
# ─────────────────────────────────────────────────────────────

PORT=8080
URL="http://localhost:$PORT/ux_skillset_v10.html"

# 기존 서버 정리
lsof -ti tcp:$PORT | xargs kill -9 2>/dev/null

if command -v python3 &>/dev/null; then
  python3 -m http.server $PORT &>/dev/null &
  SERVER_PID=$!
elif command -v node &>/dev/null; then
  npx -y serve -l $PORT . &>/dev/null &
  SERVER_PID=$!
else
  echo "❌ Python3 또는 Node.js가 필요합니다."
  echo "   https://www.python.org 에서 Python 3 를 설치하세요."
  read -rp "Enter 키를 눌러 종료..."
  exit 1
fi

sleep 1
open "$URL"

echo "✅ 스킬셋 실행 중: $URL"
echo "   이 창을 닫으면 서버가 종료됩니다."
wait $SERVER_PID
