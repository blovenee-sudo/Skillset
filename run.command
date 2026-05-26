#!/bin/bash
# UX AI 스킬셋 — Mac 실행 스크립트
# 더블클릭으로 실행하세요. 처음 실행 시 우클릭 → 열기 로 Gatekeeper 허용 필요.

cd "$(dirname "$0")"

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
