# UX AI 스킬셋

UX 기획자를 위한 AI 프롬프트 관리 도구. 로컬에서 실행하고 브라우저에 앱으로 설치해 사용합니다.

---

## 설치 & 실행

### 1. 저장소 다운로드

```bash
git clone https://github.com/blovenee-sudo/Skillset.git
cd Skillset
```

또는 GitHub에서 **Code → Download ZIP** 으로 받아 압축 해제해도 됩니다.

### 2. 로컬 서버 실행

> Python 3 또는 Node.js 중 하나가 설치되어 있어야 합니다.  
> 없으면 https://www.python.org 에서 Python 3 설치 후 진행하세요.

| OS | 방법 |
|----|------|
| **Mac** | `run.command` 파일 **우클릭 → 열기** (최초 1회만) → 이후엔 더블클릭 |
| **Windows** | `run.bat` 파일 더블클릭 |

실행하면 터미널 창이 열리고 브라우저에서 앱이 자동으로 열립니다.  
터미널 창을 닫으면 서버가 종료됩니다.

---

## PWA 앱 설치 (Mac Dock / Windows 작업 표시줄)

로컬 서버로 앱을 열고 나면 브라우저에서 앱으로 설치할 수 있습니다.  
설치하면 터미널 없이 Dock이나 작업 표시줄에서 바로 실행됩니다.

### Mac — Chrome

1. `run.command` 실행 → 브라우저에서 앱이 열림
2. 오른쪽 상단 **점 세 개 (⋮)** 클릭
3. **전송, 저장, 공유** 항목 위에 마우스를 올리면 하위 메뉴 펼쳐짐
4. **UX AI 스킬셋에서 열기** 클릭
5. 팝업에서 **설치** 확인 → Dock에 앱 추가됨

### Mac — Edge

1. `run.command` 실행 → 브라우저에서 앱이 열림
2. 오른쪽 상단 **점 세 개 (…)** 클릭
3. **앱** → **이 사이트를 앱으로 설치** 클릭
4. **설치** 확인 → Dock에 앱 추가됨

### Mac — Safari

1. `run.command` 실행 → 브라우저에서 앱이 열림
2. Safari 주소창에서 `http://localhost:8080/ux_skillset_v10.html` 확인
3. 상단 **공유 버튼 (□↑)** 클릭
4. 목록에서 **Dock에 추가** 선택
5. 이름 확인 후 **추가** → Dock에 앱 추가됨

### Windows — Edge (권장)

1. `run.bat` 실행 → 브라우저에서 앱이 열림
2. 오른쪽 상단 **점 세 개 (…)** 클릭
3. **앱** → **이 사이트를 앱으로 설치** 클릭
4. **설치** 확인 → 작업 표시줄 및 시작 메뉴에 앱 추가됨

### Windows — Chrome

1. `run.bat` 실행 → 브라우저에서 앱이 열림
2. 오른쪽 상단 **점 세 개 (⋮)** 클릭
3. **전송, 저장, 공유** 위에 마우스를 올리면 하위 메뉴 펼쳐짐
4. **UX AI 스킬셋에서 열기** 클릭
5. 팝업에서 **설치** 확인 → 작업 표시줄에 앱 추가됨

---

## 앱 실행 방법 (설치 후)

| 상황 | 방법 |
|------|------|
| **Dock/작업 표시줄에서 바로 열기** | 먼저 `run.command` (Mac) 또는 `run.bat` (Windows) 로 서버를 켠 뒤, Dock 아이콘 클릭 |
| **브라우저에서 열기** | 서버 실행 후 `http://localhost:8080/ux_skillset_v10.html` 접속 |
| **오프라인 사용** | 한 번이라도 서버로 접속한 적 있으면 인터넷·서버 없이도 캐시로 실행됨 |

> 앱 아이콘은 서버가 켜진 상태에서 클릭해야 최신 스킬을 받을 수 있습니다.  
> 서버 없이 열면 마지막으로 캐시된 상태로 열립니다.

---

## 환경 설정 (선택 — 관리자 PIN 변경)

기본 관리자 PIN은 `1234` 입니다. 변경하려면:

```bash
cp .env.example .env
# .env 파일을 열어 ADMIN_PIN 값 수정
node scripts/apply-env.mjs
```

> `env-config.js` 와 `.env` 는 Git에 올라가지 않습니다 (`.gitignore` 처리됨).

---

## 업데이트 배포 방법

앱을 수정하고 팀원에게 배포할 때의 절차입니다.

### 관리자 (배포하는 사람)

1. 코드 수정
2. `sw.js` 첫 줄 캐시 버전 번호를 올린다

   ```js
   // 수정 전
   const CACHE = 'skillset-v1';
   // 수정 후 (숫자를 1씩 올림)
   const CACHE = 'skillset-v2';
   ```

3. Git 커밋 & 푸시

   ```bash
   git add .
   git commit -m "fix: 수정 내용 요약"
   git push origin main
   ```

4. 팀원에게 업데이트 공지 (버전 번호 포함 권장)

### 팀원 (업데이트 받는 사람)

```bash
git pull          # 최신 파일 받기
```

이후 `run.command` (Mac) 또는 `run.bat` (Windows) 재실행 → PWA 앱에서 `Cmd+R` / `F5` 새로고침

> **왜 버전을 올려야 하나요?**  
> Service Worker가 파일을 캐시해두기 때문에, 버전을 올리지 않으면 브라우저가 최대 24시간 동안 이전 버전을 계속 보여줄 수 있습니다. 버전을 바꾸면 브라우저가 즉시 새 캐시를 적용합니다.

---

## 스킬 관리

### 스킬 추가 · 수정 (관리자)

`skills/` 폴더의 MD 파일을 편집하고 `skills/index.json` 을 동일하게 업데이트합니다.

```
skills/
├── index.json          ← 앱이 읽는 스킬 데이터 (이 파일을 수정해야 앱에 반영됨)
├── s0-figma-draft.md   ← 사람이 읽는 스킬 문서
├── s1-spec-analysis.md
└── ...
```

MD 파일 형식:

```markdown
---
id: s0
name: 스킬 이름
slash: /slash-command
desc: 한 줄 설명
---

프롬프트 본문...
```

### 팀원이 최신 스킬 받는 법

```bash
git pull
```

이후 앱에서 관리자 로그인 → 헤더 **↻ 스킬 업데이트** 버튼 클릭

---

## 폴더 구조

```
Skillset/
├── ux_skillset_v10.html   # 앱 본체
├── manifest.json          # PWA 설정
├── sw.js                  # Service Worker (오프라인·설치 지원)
├── icon.svg               # 앱 아이콘
├── run.command            # Mac 실행 스크립트
├── run.bat                # Windows 실행 스크립트
├── skills/
│   ├── index.json         # 스킬 데이터 (앱 로딩용)
│   └── s*.md              # 스킬 문서 (사람이 읽는 용)
├── scripts/
│   └── apply-env.mjs      # .env → env-config.js 변환
├── .env.example           # 환경 변수 예시
└── .gitignore
```
