---
id: p4
name: Dev Hand-off 리포트
slash: /handoff
desc: Phase 3 HTML 목업 → 개발자 전달용 Split-screen 인터랙션 스펙 + 컴포넌트 명세 리포트 (Phase 4)
---

# [Phase 4] Dev Hand-off Report (/handoff)

> 역할: 완성된 HTML 목업과 디자이너 검수 메모, 인터랙션 가이드를 하나로 결합한 Split-screen 구조의 개발 전달용 리포트 HTML을 생성합니다.

---

입력 자료 (Phase 3 /mockup 산출물 — HTML 코드 전체 붙여넣기):



---

디자이너 검수 메모 & 인터랙션 가이드 (선택 — 없으면 생략):



---

<!-- AI INSTRUCTIONS -->

# Role: UI/UX Designer → Developer Handoff Specialist

당신은 HTML 목업 코드와 디자이너 메모를 읽어 개발자가 즉시 구현에 착수할 수 있는 **Single-file Dev Hand-off Report**를 생성하는 전문가입니다.
출력 HTML은 좌측에 목업 미리보기, 우측에 컴포넌트 명세·인터랙션 가이드·CSS 변수를 표시하는 Split-screen 구조입니다.

---

## Step 1 — 목업 파싱 & 컴포넌트 추출

Phase 3 HTML 코드에서 아래 항목을 파악합니다.

1. `<!-- Component: 이름 -->` 주석 → 컴포넌트 목록 추출
2. `:root { }` 블록 → 사용된 CSS 변수 전체 추출
3. 주요 인터랙션 (탭·모달·화면 전환) → JavaScript 이벤트 로직 요약
4. 반응형 breakpoint → 모바일/데스크톱 레이아웃 차이 파악
5. Empty·Loading·Error 상태 → 상태별 UI 변화 파악

---

## Step 2 — Hand-off Report HTML 생성

아래 구조로 완전한 Single-file HTML을 생성합니다.

### 리포트 레이아웃

```
┌─────────────────────────────────────────────────────────┐
│  [좌] 목업 미리보기 (iframe 또는 직접 렌더링)  │  [우] 스펙 패널  │
│                                                          │
│  화면 전환: [버튼 목록]                                  │
│                                                          │
│  ┌───────────── 스펙 패널 탭 ──────────────┐            │
│  │  컴포넌트 명세  │  디자인 토큰  │  인터랙션  │        │
│  └────────────────────────────────────────┘            │
└─────────────────────────────────────────────────────────┘
```

### 스펙 패널 내용

**컴포넌트 명세 탭**
- 컴포넌트별 Variant 표
- 상태(State) 목록: default / hover / active / disabled / loading / error / empty
- 최소 터치 영역 (44px 기준)
- z-index 레이어 순서

**디자인 토큰 탭**
- Phase 2에서 추출한 `:root` CSS 변수 테이블 (변수명 | 값 | 사용처)
- 타이포그래피 규칙 표
- 스페이싱 Scale 표

**인터랙션 탭**
- 화면별 트리거 → 동작 → 결과 표
- 애니메이션 지침 (duration·easing 값)
- 주의사항 (에러 처리 방식, API 연결 포인트)

---

## Step 3 — Hand-off HTML 템플릿

```html
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>[서비스명] — Dev Hand-off Report</title>
  <style>
    /* ── Design Tokens (Phase 2 복사) ── */
    :root { /* ... */ }

    /* ── Hand-off Report Layout ── */
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { display: flex; flex-direction: column; height: 100vh; font-family: -apple-system, 'Pretendard', sans-serif; background: #0f0f10; color: #e8e8ea; }

    .report-header { padding: 12px 20px; background: #18181b; border-bottom: 1px solid #2a2a2e; display: flex; align-items: center; gap: 16px; }
    .report-header h1 { font-size: 14px; font-weight: 600; }
    .report-header .badge { font-size: 11px; padding: 2px 8px; background: #6366f1; color: #fff; border-radius: 999px; }

    .split { display: flex; flex: 1; overflow: hidden; }

    /* 좌측 — 목업 미리보기 */
    .preview-pane { flex: 1; display: flex; flex-direction: column; border-right: 1px solid #2a2a2e; }
    .preview-toolbar { padding: 8px 12px; background: #18181b; border-bottom: 1px solid #2a2a2e; display: flex; gap: 8px; flex-wrap: wrap; }
    .screen-btn { font-size: 12px; padding: 4px 10px; border: 1px solid #3a3a3e; background: transparent; color: #a1a1aa; border-radius: 6px; cursor: pointer; }
    .screen-btn.active { background: #6366f1; color: #fff; border-color: #6366f1; }
    .preview-frame { flex: 1; background: #fff; }
    .preview-frame iframe { width: 100%; height: 100%; border: none; }

    /* 우측 — 스펙 패널 */
    .spec-pane { width: 420px; display: flex; flex-direction: column; overflow: hidden; }
    .spec-tabs { display: flex; border-bottom: 1px solid #2a2a2e; background: #18181b; }
    .spec-tab { flex: 1; padding: 10px; font-size: 12px; text-align: center; cursor: pointer; color: #71717a; border-bottom: 2px solid transparent; }
    .spec-tab.active { color: #e8e8ea; border-bottom-color: #6366f1; }
    .spec-content { flex: 1; overflow-y: auto; padding: 16px; }
    .spec-section { margin-bottom: 24px; }
    .spec-section h3 { font-size: 12px; font-weight: 600; color: #6366f1; text-transform: uppercase; letter-spacing: .05em; margin-bottom: 10px; }

    /* 표 스타일 */
    table { width: 100%; border-collapse: collapse; font-size: 12px; }
    th { background: #1e1e22; padding: 6px 8px; text-align: left; color: #71717a; font-weight: 500; border-bottom: 1px solid #2a2a2e; }
    td { padding: 6px 8px; border-bottom: 1px solid #1e1e22; color: #d4d4d8; vertical-align: top; }
    td code { font-family: 'SF Mono', monospace; font-size: 11px; background: #1e1e22; padding: 2px 4px; border-radius: 3px; color: #a78bfa; }

    /* 토큰 색상 미리보기 */
    .color-swatch { display: inline-block; width: 14px; height: 14px; border-radius: 3px; margin-right: 6px; vertical-align: middle; border: 1px solid rgba(255,255,255,.1); }
  </style>
</head>
<body>

  <!-- Component: Report Header -->
  <header class="report-header">
    <h1>[서비스명] UI 목업</h1>
    <span class="badge">Hand-off v1.0</span>
    <span style="margin-left:auto;font-size:11px;color:#71717a;">[날짜]</span>
  </header>

  <div class="split">

    <!-- Component: Preview Pane (Left) -->
    <div class="preview-pane">
      <div class="preview-toolbar">
        <!-- Phase 3의 각 화면별 버튼 -->
        <button class="screen-btn active" onclick="showScreen('main')">메인 화면</button>
        <!-- ... 추가 화면 버튼 ... -->
      </div>
      <div class="preview-frame">
        <!-- Phase 3 HTML 코드를 srcdoc에 인라인 포함 -->
        <iframe id="mockupFrame" srcdoc=""></iframe>
      </div>
    </div>

    <!-- Component: Spec Pane (Right) -->
    <div class="spec-pane">
      <div class="spec-tabs">
        <div class="spec-tab active" onclick="showTab('components')">컴포넌트</div>
        <div class="spec-tab" onclick="showTab('tokens')">디자인 토큰</div>
        <div class="spec-tab" onclick="showTab('interaction')">인터랙션</div>
      </div>
      <div class="spec-content">

        <!-- 컴포넌트 탭 -->
        <div id="tab-components">
          <div class="spec-section">
            <h3>컴포넌트 목록</h3>
            <table>
              <tr><th>컴포넌트</th><th>Variant</th><th>상태</th></tr>
              <!-- Phase 3 파싱 결과 자동 생성 -->
            </table>
          </div>
        </div>

        <!-- 디자인 토큰 탭 -->
        <div id="tab-tokens" class="hidden">
          <div class="spec-section">
            <h3>Color Tokens</h3>
            <table>
              <tr><th>변수명</th><th>값</th><th>사용처</th></tr>
              <!-- :root CSS 변수 자동 추출 -->
            </table>
          </div>
          <div class="spec-section">
            <h3>Typography</h3>
            <table>
              <tr><th>용도</th><th>크기</th><th>굵기</th></tr>
            </table>
          </div>
          <div class="spec-section">
            <h3>Spacing Scale</h3>
            <table>
              <tr><th>토큰</th><th>값</th></tr>
            </table>
          </div>
        </div>

        <!-- 인터랙션 탭 -->
        <div id="tab-interaction" class="hidden">
          <div class="spec-section">
            <h3>인터랙션 명세</h3>
            <table>
              <tr><th>트리거</th><th>동작</th><th>결과</th></tr>
            </table>
          </div>
          <div class="spec-section">
            <h3>애니메이션 가이드</h3>
            <table>
              <tr><th>요소</th><th>속성</th><th>duration</th><th>easing</th></tr>
            </table>
          </div>
          <div class="spec-section">
            <h3>개발자 주의사항</h3>
            <ul style="font-size:12px;color:#d4d4d8;padding-left:16px;line-height:1.7;">
              <!-- 에러 처리, API 포인트, 접근성 등 -->
            </ul>
          </div>
        </div>

      </div>
    </div>

  </div>

  <script>
    // ── Phase 3 HTML 목업 인라인 삽입 ──
    const MOCKUP_HTML = `[Phase 3 HTML 코드 전체]`;
    document.getElementById('mockupFrame').srcdoc = MOCKUP_HTML;

    // ── 탭 전환 ──
    function showTab(name) {
      document.querySelectorAll('[id^="tab-"]').forEach(el => el.classList.add('hidden'));
      document.querySelectorAll('.spec-tab').forEach(el => el.classList.remove('active'));
      document.getElementById('tab-' + name).classList.remove('hidden');
      event.currentTarget.classList.add('active');
    }

    // ── 미리보기 화면 전환 ──
    function showScreen(id) {
      document.querySelectorAll('.screen-btn').forEach(b => b.classList.remove('active'));
      event.currentTarget.classList.add('active');
      const frame = document.getElementById('mockupFrame');
      frame.contentWindow?.showScreen?.(id);
    }
  </script>
</body>
</html>
```

---

## 출력 규칙

- Phase 3 HTML 전체를 `MOCKUP_HTML` 변수에 포함하여 iframe `srcdoc`으로 렌더링
- 스펙 패널 내 모든 표는 Phase 3 코드를 파싱하여 실제 데이터로 채움 (빈 표 금지)
- 다크 테마 기반 리포트 UI — 개발자 도구 느낌의 레이아웃
- 외부 CDN 없이 단일 HTML 파일로 완결
- 마지막 줄 출력: `→ /qa 로 최종 검수를 진행하거나 개발팀에 전달할 수 있습니다.`
