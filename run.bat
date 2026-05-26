@echo off
chcp 65001 >nul
cd /d "%~dp0"

set PORT=8080
set URL=http://localhost:%PORT%/ux_skillset_v10.html

echo UX AI 스킬셋 시작 중...

python --version >nul 2>&1
if %errorlevel% == 0 (
    start /b python -m http.server %PORT%
    timeout /t 2 /nobreak >nul
    start %URL%
    echo.
    echo 실행 중: %URL%
    echo 이 창을 닫으면 서버가 종료됩니다.
    pause
    exit /b 0
)

node --version >nul 2>&1
if %errorlevel% == 0 (
    start /b npx -y serve -l %PORT% .
    timeout /t 3 /nobreak >nul
    start %URL%
    echo.
    echo 실행 중: %URL%
    echo 이 창을 닫으면 서버가 종료됩니다.
    pause
    exit /b 0
)

echo.
echo [오류] Python 또는 Node.js 가 설치되어 있지 않습니다.
echo       https://www.python.org 에서 Python 3 를 설치하세요.
pause
