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

디자인 시스템 참고 자료 (선택 — 없으면 생략):



---

디자이너 검수 메모 & 인터랙션 가이드 (선택 — 없으면 생략):



---

<!-- AI INSTRUCTIONS -->

# Role: UI/UX Designer → Developer Handoff Specialist

당신은 HTML 목업 코드와 디자이너 메모를 읽어 개발자가 즉시 구현에 착수할 수 있는 **Single-file Dev Hand-off Report**를 생성하는 전문가입니다.
출력 HTML은 좌측에 목업 미리보기, 우측에 컴포넌트 명세·인터랙션 가이드·CSS 변수·디스크립션 주석·소스 코드를 표시하는 Split-screen 구조입니다.

---

## Step 1 — 목업 파싱

Phase 3 HTML 코드에서 아래 항목을 파악합니다.

1. **화면(스크린) 분리**: 목업 내 별개 페이지/화면을 식별합니다. 각 화면은 독립된 HTML 문서로 추출합니다 (공통 `:root`, `<style>` 포함).
2. `<!-- Component: 이름 -->` 주석 → 컴포넌트 목록 추출
3. `:root { }` 블록 → 사용된 CSS 변수 전체 추출
4. 주요 인터랙션 (탭·모달·화면 전환) → JavaScript 이벤트 로직 요약
5. 반응형 breakpoint, Empty/Loading/Error 상태 파악
6. **디스크립션 주석 생성**: 화면별 주요 UI 요소 3~7개를 선정하여 위치(x%, y%)와 설명을 작성합니다.

---

## Step 2 — Hand-off Report 구조

```
┌─────────────────────────────────────────────────────────────┐
│  HEADER: 서비스명 │ Hand-off v1.0 │ 날짜                    │
├──────────────────────────┬──────────────────────────────────┤
│  [좌] 목업 미리보기       │  [우] 스펙 패널                   │
│                          │  탭: 컴포넌트│토큰│인터랙션│       │
│  ┌── toolbar ──┐         │       디스크립션│코드             │
│  │ [페이지1] [페이지2]... │                                   │
│  └────────────┘         │                                   │
│  ┌── iframe ──┐          │                                   │
│  │  목업 미리보기         │                                   │
│  │  (페이지별 독립 HTML)  │                                   │
│  └────────────┘         │                                   │
│  ┌── ann overlay ──┐     │                                   │
│  │  번호 핀 (클릭 가능)   │                                   │
│  └─────────────────┘    │                                   │
└──────────────────────────┴──────────────────────────────────┘
```

### 스펙 패널 탭 5개

1. **컴포넌트**: 컴포넌트명 / Variant / 상태(State) 표
2. **디자인 토큰**: `:root` CSS 변수 테이블 (변수명 | 값 | 사용처), 타이포그래피, 스페이싱
3. **인터랙션**: 트리거 → 동작 → 결과 표, 애니메이션 가이드
4. **디스크립션**: 현재 페이지의 주석 번호 목록 (핀 클릭 ↔ 목록 하이라이트 연동)
5. **코드**: 현재 페이지의 HTML 소스 코드 (pre/code 블록)

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
    :root { /* Phase 2 / 3 디자인 토큰 복사 */ }
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { display: flex; flex-direction: column; height: 100vh; font-family: -apple-system, 'Pretendard', sans-serif; background: #0f0f10; color: #e8e8ea; }

    .report-header { padding: 10px 20px; background: #18181b; border-bottom: 1px solid #2a2a2e; display: flex; align-items: center; gap: 12px; flex-shrink: 0; }
    .report-header h1 { font-size: 14px; font-weight: 600; }
    .badge { font-size: 11px; padding: 2px 8px; background: #6366f1; color: #fff; border-radius: 999px; }
    .report-date { margin-left: auto; font-size: 11px; color: #71717a; }

    .split { display: flex; flex: 1; overflow: hidden; }

    /* 좌측 — 목업 미리보기 */
    .preview-pane { flex: 1; display: flex; flex-direction: column; border-right: 1px solid #2a2a2e; min-width: 0; }
    .preview-toolbar { padding: 8px 12px; background: #18181b; border-bottom: 1px solid #2a2a2e; display: flex; gap: 6px; flex-wrap: wrap; flex-shrink: 0; }
    .screen-btn { font-size: 12px; padding: 4px 10px; border: 1px solid #3a3a3e; background: transparent; color: #a1a1aa; border-radius: 6px; cursor: pointer; transition: all .15s; }
    .screen-btn.active { background: #6366f1; color: #fff; border-color: #6366f1; }
    .preview-wrap { flex: 1; position: relative; overflow: hidden; }
    .preview-wrap iframe { width: 100%; height: 100%; border: none; background: #fff; }
    /* 주석 핀 오버레이 */
    #annOverlay { position: absolute; top: 0; left: 0; width: 100%; height: 100%; pointer-events: none; }
    .ann-pin { position: absolute; width: 22px; height: 22px; border-radius: 50%; background: #6366f1; color: #fff; font-size: 11px; font-weight: 700; display: flex; align-items: center; justify-content: center; cursor: pointer; transform: translate(-50%, -50%); pointer-events: auto; border: 2px solid #fff; box-shadow: 0 2px 6px rgba(0,0,0,.5); transition: transform .15s; z-index: 10; }
    .ann-pin:hover { transform: translate(-50%,-50%) scale(1.2); }

    /* 우측 — 스펙 패널 */
    .spec-pane { width: 400px; display: flex; flex-direction: column; overflow: hidden; flex-shrink: 0; }
    .spec-tabs { display: flex; border-bottom: 1px solid #2a2a2e; background: #18181b; flex-shrink: 0; overflow-x: auto; }
    .spec-tab { padding: 9px 12px; font-size: 11px; white-space: nowrap; text-align: center; cursor: pointer; color: #71717a; border-bottom: 2px solid transparent; background: none; border-top: none; border-left: none; border-right: none; transition: color .15s; }
    .spec-tab.active { color: #e8e8ea; border-bottom-color: #6366f1; }
    .spec-content { flex: 1; overflow-y: auto; padding: 14px; }
    .spec-panel { display: none; }
    .spec-panel.active { display: block; }
    .spec-section { margin-bottom: 20px; }
    .spec-section h3 { font-size: 11px; font-weight: 600; color: #6366f1; text-transform: uppercase; letter-spacing: .06em; margin-bottom: 8px; }
    table { width: 100%; border-collapse: collapse; font-size: 12px; }
    th { background: #1e1e22; padding: 6px 8px; text-align: left; color: #71717a; font-weight: 500; border-bottom: 1px solid #2a2a2e; }
    td { padding: 6px 8px; border-bottom: 1px solid #1e1e22; color: #d4d4d8; vertical-align: top; }
    td code { font-family: 'SF Mono', monospace; font-size: 11px; background: #1e1e22; padding: 2px 4px; border-radius: 3px; color: #a78bfa; }
    .color-swatch { display: inline-block; width: 12px; height: 12px; border-radius: 3px; margin-right: 4px; vertical-align: middle; border: 1px solid rgba(255,255,255,.15); }

    /* 디스크립션 탭 */
    .desc-item { display: flex; gap: 8px; padding: 8px 10px; border-radius: 6px; cursor: pointer; transition: background .15s; border: 1px solid transparent; margin-bottom: 4px; }
    .desc-item:hover { background: #1e1e22; }
    .desc-item.active { background: #1e204a; border-color: #6366f1; }
    .desc-num { width: 20px; height: 20px; border-radius: 50%; background: #6366f1; color: #fff; font-size: 11px; font-weight: 700; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
    .desc-text { font-size: 12px; color: #d4d4d8; line-height: 1.5; }

    /* 코드 탭 */
    #code-pre { background: #0a0a0c; border-radius: 6px; padding: 12px; overflow: auto; max-height: 100%; }
    #code-pre code { font-family: 'SF Mono', 'Fira Code', monospace; font-size: 11px; color: #a8c3e8; white-space: pre; line-height: 1.6; }
  </style>
</head>
<body>

  <header class="report-header">
    <h1>[서비스명] UI 목업</h1>
    <span class="badge">Hand-off v1.0</span>
    <span class="report-date">[날짜]</span>
  </header>

  <div class="split">

    <!-- 좌측: 목업 미리보기 -->
    <div class="preview-pane">
      <div class="preview-toolbar">
        <!-- 화면별 버튼 — 파싱 결과에 따라 생성 -->
        <button class="screen-btn active" onclick="showScreen('screen1', this)">화면 1</button>
        <button class="screen-btn" onclick="showScreen('screen2', this)">화면 2</button>
        <!-- ... 추가 화면 버튼 ... -->
      </div>
      <div class="preview-wrap">
        <iframe id="mockupFrame" title="목업 미리보기"></iframe>
        <div id="annOverlay"></div>
      </div>
    </div>

    <!-- 우측: 스펙 패널 -->
    <div class="spec-pane">
      <div class="spec-tabs">
        <button class="spec-tab active" data-tab="components" onclick="showTab('components',this)">컴포넌트</button>
        <button class="spec-tab" data-tab="tokens" onclick="showTab('tokens',this)">디자인 토큰</button>
        <button class="spec-tab" data-tab="interaction" onclick="showTab('interaction',this)">인터랙션</button>
        <button class="spec-tab" data-tab="desc" onclick="showTab('desc',this)">디스크립션</button>
        <button class="spec-tab" data-tab="code" onclick="showTab('code',this)">코드</button>
      </div>
      <div class="spec-content">

        <!-- 컴포넌트 탭 -->
        <div id="panel-components" class="spec-panel active">
          <div class="spec-section">
            <h3>컴포넌트 목록</h3>
            <table>
              <tr><th>컴포넌트</th><th>Variant</th><th>State</th></tr>
              <!-- Phase 3 파싱 결과로 채움 -->
            </table>
          </div>
          <div class="spec-section">
            <h3>레이어 순서 (z-index)</h3>
            <table>
              <tr><th>레이어</th><th>z-index</th></tr>
            </table>
          </div>
        </div>

        <!-- 디자인 토큰 탭 -->
        <div id="panel-tokens" class="spec-panel">
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
              <tr><th>용도</th><th>크기</th><th>굵기</th><th>line-height</th></tr>
            </table>
          </div>
          <div class="spec-section">
            <h3>Spacing Scale</h3>
            <table>
              <tr><th>토큰</th><th>값</th><th>사용처</th></tr>
            </table>
          </div>
        </div>

        <!-- 인터랙션 탭 -->
        <div id="panel-interaction" class="spec-panel">
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
            <ul style="font-size:12px;color:#d4d4d8;padding-left:16px;line-height:1.8;">
              <!-- 에러 처리, API 연결 포인트, 접근성 등 -->
            </ul>
          </div>
        </div>

        <!-- 디스크립션 탭 -->
        <div id="panel-desc" class="spec-panel">
          <div id="desc-list">
            <!-- renderDescList() 로 동적 생성 -->
          </div>
        </div>

        <!-- 코드 탭 -->
        <div id="panel-code" class="spec-panel">
          <pre id="code-pre"><code id="code-content"></code></pre>
        </div>

      </div>
    </div>

  </div>

  <script>
    // ── 화면별 독립 HTML ──
    // 각 화면의 공통 CSS(:root, body 스타일)을 포함한 완전한 HTML 문서
    const SCREENS = {
      'screen1': `<!DOCTYPE html><html lang="ko"><head><meta charset="UTF-8"><style>
        /* 공통 스타일 */
      </style></head><body>
        <!-- 화면 1 HTML 내용 -->
      </body></html>`,

      'screen2': `<!DOCTYPE html><html lang="ko"><head><meta charset="UTF-8"><style>
        /* 공통 스타일 */
      </style></head><body>
        <!-- 화면 2 HTML 내용 -->
      </body></html>`,

      // 추가 화면...
    };

    // ── 화면별 디스크립션 주석 ──
    // x, y: 목업 미리보기 영역 기준 % 좌표 (0~100)
    const ANNOTATIONS = {
      'screen1': [
        { n: 1, x: 50, y: 10, desc: '예: 상단 헤더 — 서비스명 및 글로벌 네비게이션' },
        { n: 2, x: 20, y: 40, desc: '예: 사이드바 메뉴 — 현재 활성 항목 표시' },
      ],
      'screen2': [
        { n: 1, x: 50, y: 20, desc: '예: 콘텐츠 영역 — 본문 렌더링' },
      ],
    };

    let _currentScreen = Object.keys(SCREENS)[0];

    function renderPins(screenId) {
      const overlay = document.getElementById('annOverlay');
      overlay.innerHTML = '';
      (ANNOTATIONS[screenId] || []).forEach(a => {
        const pin = document.createElement('div');
        pin.className = 'ann-pin';
        pin.textContent = a.n;
        pin.style.left = a.x + '%';
        pin.style.top = a.y + '%';
        pin.addEventListener('click', () => highlightDesc(a.n));
        overlay.appendChild(pin);
      });
    }

    function renderDescList(screenId) {
      const list = document.getElementById('desc-list');
      const anns = ANNOTATIONS[screenId] || [];
      if (!anns.length) {
        list.innerHTML = '<p style="color:#71717a;font-size:12px;padding:8px 0">이 화면에 디스크립션 주석이 없습니다.</p>';
        return;
      }
      list.innerHTML = anns.map(a => `
        <div class="desc-item" data-n="${a.n}" onclick="highlightDesc(${a.n})">
          <div class="desc-num">${a.n}</div>
          <div class="desc-text">${a.desc}</div>
        </div>`).join('');
    }

    function highlightDesc(n) {
      showTab('desc', document.querySelector('[data-tab="desc"]'));
      document.querySelectorAll('.desc-item').forEach(el => {
        const match = Number(el.dataset.n) === n;
        el.classList.toggle('active', match);
        if (match) el.scrollIntoView({ behavior: 'smooth', block: 'center' });
      });
    }

    function showScreen(id, btn) {
      document.querySelectorAll('.screen-btn').forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      _currentScreen = id;
      document.getElementById('mockupFrame').srcdoc = SCREENS[id] || '';
      renderPins(id);
      renderDescList(id);
      document.getElementById('code-content').textContent = SCREENS[id] || '';
    }

    function showTab(name, el) {
      document.querySelectorAll('.spec-panel').forEach(p => p.classList.remove('active'));
      document.querySelectorAll('.spec-tab').forEach(t => t.classList.remove('active'));
      document.getElementById('panel-' + name).classList.add('active');
      if (el) el.classList.add('active');
    }

    // ── 초기화 ──
    const firstScreen = Object.keys(SCREENS)[0];
    document.getElementById('mockupFrame').srcdoc = SCREENS[firstScreen] || '';
    document.getElementById('code-content').textContent = SCREENS[firstScreen] || '';
    renderPins(firstScreen);
    renderDescList(firstScreen);
  </script>
</body>
</html>
```

---

## 출력 규칙

- `SCREENS` 객체: Phase 3 목업의 각 화면을 공통 CSS를 포함한 독립 HTML 문서로 분리하여 저장
- `ANNOTATIONS` 객체: 화면별 주요 UI 요소 3~7개, x/y는 미리보기 영역 기준 % (핀이 해당 요소를 가리키도록)
- 스펙 패널 내 모든 표는 Phase 3 코드를 파싱한 실제 데이터로 채움 (빈 표 금지)
- 디자인 시스템 자료가 있을 경우 `:root` 변수를 SCREENS HTML에 포함하고 토큰 탭에도 반영
- 다크 테마 기반 리포트 UI, 외부 CDN 없이 단일 HTML 파일로 완결
- 마지막 줄 출력: `→ /qa 로 최종 검수를 진행하거나 개발팀에 전달할 수 있습니다.`
