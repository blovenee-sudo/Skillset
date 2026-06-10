# AX 스킬셋

UX 기획자를 위한 AI 프롬프트 관리 도구.
설치 없이 URL 접속만으로 사용하고, 브라우저에서 Dock 앱으로 설치할 수 있습니다.

---

## 바로 사용하기

**🔗 https://blovenee-sudo.github.io/Skillset/**

URL을 열면 끝입니다. 별도 설치나 서버 실행이 필요 없습니다.

---

## Dock / 작업 표시줄에 앱으로 설치 (선택)

브라우저에서 PWA로 설치하면 일반 앱처럼 Dock에서 바로 실행됩니다.

| 브라우저 | 방법 |
|----------|------|
| **Chrome / Edge** | 주소창 오른쪽 `⊕` 아이콘 클릭 → **설치** |
| **Safari (macOS)** | 공유 버튼 → **Dock에 추가** |
| **Edge (Windows)** | 점 세 개 → **앱** → **이 사이트를 앱으로 설치** |

---

## 데이터 저장 방식

URL로 접속해 사용하는 경우, **사용자 컴퓨터에 어떤 파일이나 폴더도 생성되지 않습니다.**
모든 데이터는 브라우저 내부 저장소(localStorage)에만 저장됩니다.

```
사용자 컴퓨터
├── Documents/   ← 아무것도 생성되지 않음
├── Downloads/   ← 아무것도 생성되지 않음
└── 브라우저 내부
    └── localStorage  ← 세션·스킬·프로젝트가 여기에 저장됨
```

### 유지되는 경우 / 초기화되는 경우

| 상황 | 데이터 |
|------|--------|
| 같은 기기, 같은 브라우저로 재접속 | 유지 ✅ |
| 브라우저를 껐다 켜도 | 유지 ✅ |
| 다른 브라우저로 접속 | 초기화 ❌ |
| 다른 기기에서 접속 | 초기화 ❌ |
| 브라우저 캐시·사이트 데이터 삭제 | 초기화 ❌ |

> 앱 삭제가 필요하면 브라우저에서 **사이트 데이터 지우기**만 하면 됩니다. 컴퓨터 어딘가에 파일이 남지 않습니다.

### 기기 간 데이터 이전이 필요한 경우

현재는 기기 간 자동 동기화를 지원하지 않습니다.
기기를 바꾸거나 브라우저가 초기화된 경우, 기본 스킬은 자동으로 복원되며
사용자가 추가한 스킬·프로젝트는 다시 설정이 필요합니다.

---

## 스킬 관리

### 기본 스킬 추가 · 수정 (관리자)

`skills/` 폴더의 MD 파일과 `skills/index.json`을 함께 수정한 뒤 커밋·푸시하면
GitHub Pages에 자동 반영됩니다.

```
skills/
├── index.json          ← 앱이 읽는 스킬 데이터
├── s1-spec-analysis.md ← 스킬별 프롬프트 파일
├── s2-benchmarking.md
└── ...
```

MD 파일 형식:

```markdown
---
id: s1
name: 스킬 이름
slash: /slash-command
desc: 한 줄 설명
---

프롬프트 본문...
```

### 팀원이 최신 스킬 받는 법

URL을 새로고침하면 끝입니다. `git pull` 불필요.

---

## 업데이트 배포

```
1. 코드 수정
2. sw.js 첫 줄 캐시 버전 번호 +1
3. git commit & push → GitHub Pages 자동 반영
```

> Service Worker 캐시 때문에 버전을 올리지 않으면 최대 24시간 이전 버전이 보일 수 있습니다.

---

## Claude Code 슬래시 명령어 설치 (선택 — Claude Code 사용자만)

> Claude.ai 웹, ChatGPT 등은 앱에서 프롬프트를 복사해 붙여넣어 사용하세요.

### 최초 설치

```bash
git clone https://github.com/blovenee-sudo/Skillset.git
cd Skillset
```

Mac에서 `run.command` 파일을 **우클릭 → 열기** (최초 1회)
→ `~/.claude/commands/` 에 슬래시 명령어 자동 설치

```
/spec-analysis   /benchmarking   /flowchart   /feature-spec
/heuristic       /asis-tobe      /figma-draft  /meeting-notes
/review-comments /site-planning  /ia-structure
```

### 스킬 업데이트 시

```bash
git pull
```

이후 `run.command` 재실행하면 `~/.claude/commands/` 가 자동으로 덮어씌워집니다.

---

## 사내 Git(GitLab)에 배포하기

내부망에서도 동일하게 Pages로 운영할 수 있습니다.

### 1. 사내 Git에 푸시

```bash
git clone https://github.com/blovenee-sudo/Skillset.git
cd Skillset
git push https://oss.navercorp.com/계정명/Skillset.git main
```

### 2. GitLab Pages 확인

레포 → **Settings → Pages** 메뉴에서 배포 URL 확인.
(메뉴가 없으면 IT팀에 Pages 기능 활성화 요청)

CI/CD 파이프라인(`.gitlab-ci.yml`)이 포함되어 있어 푸시하면 자동 배포됩니다.

---

## 환경 설정 (선택 — 관리자 PIN 변경)

기본 관리자 PIN은 `1234`입니다. 변경하려면:

```bash
cp .env.example .env
# .env 파일에서 ADMIN_PIN 값 수정
node scripts/apply-env.mjs
```

> API 키나 PIN을 설정한 `env-config.js`는 Git에 올리지 마세요. `.gitignore`에 추가하여 관리하세요.

---

## 폴더 구조

```
Skillset/
├── index.html             # 진입점 (GitHub/GitLab Pages용)
├── ux_skillset_v10.html   # 앱 본체
├── manifest.json          # PWA 설정
├── sw.js                  # Service Worker (오프라인·캐시)
├── icon.svg               # 앱 아이콘
├── env-config.js          # 환경 변수 (기본값: 빈 객체)
├── .gitlab-ci.yml         # GitLab Pages 자동 배포 설정
├── run.command            # Mac — Claude Code 슬래시 명령어 설치용
├── run.bat                # Windows — Claude Code 슬래시 명령어 설치용
├── skills/
│   ├── index.json         # 스킬 데이터
│   ├── s*.md              # 스킬 프롬프트 파일
│   └── session/           # 사용자 생성 스킬 (로컬 전용, Git 제외)
└── scripts/
    └── apply-env.mjs      # .env → env-config.js 변환
```
