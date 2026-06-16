---
id: report-instructions
name: HTML 리포트 생성 지침
---

결과를 화면에 출력한 뒤, 동일 내용을 기반으로 HTML 리포트 파일을 코드블록으로 출력하세요.

기준 템플릿: `skill_report_template.html` 디자인 기반으로 생성합니다.

---

## 필수 포함 요소 (절대 생략 불가)

### 1. Theme Toggle
우상단 고정 버튼 — 라이트/다크 전환:
```html
<button class="theme-toggle" id="themeToggle" onclick="toggleTheme()">🌙 다크 모드</button>
```

### 2. Light Mode (기본값)
`:root`에 라이트 모드 CSS 변수 적용 (기본값):
- `--bg:#f8fafc` `--card:#ffffff` `--card2:#f1f5f9`
- `--border:#e2e8f0` `--text:#111827` `--text2:#374151`
- `--muted:#9ca3af` `--accent:#4f46e5` `--accent2:#6366f1`

### 3. Dark Mode
`html.dark` 클래스 오버라이드:
- `--bg:#0f1117` `--card:#1a1d2e` `--card2:#12151f`
- `--border:#2d2f3e` `--text:#e2e8f0` `--text2:#cbd5e1`
- `--muted:#475569` `--accent:#6366f1` `--accent2:#818cf8`

### 4. localStorage 테마 저장
키: `ax-report-theme` (`'light'` 또는 `'dark'`) — 페이지 로드 시 복원, 없으면 라이트 모드:
```js
const saved = localStorage.getItem('ax-report-theme');
if (saved === 'dark') { document.documentElement.classList.add('dark'); btn.textContent = '☀️ 라이트 모드'; }

function toggleTheme() {
  const isDark = document.documentElement.classList.toggle('dark');
  btn.textContent = isDark ? '☀️ 라이트 모드' : '🌙 다크 모드';
  localStorage.setItem('ax-report-theme', isDark ? 'dark' : 'light');
}
```

### 5. 저장 버튼 (인쇄 / PDF 저장 / MD 저장)
드롭박스 + 저장 버튼으로 구성:
```html
<div class="save-bar">
  <select id="saveFormat" class="save-select">
    <option value="print">🖨️ 인쇄</option>
    <option value="pdf">📄 PDF 저장</option>
    <option value="md">📝 MD 저장</option>
  </select>
  <button class="btn-save" onclick="saveReport()">저장</button>
</div>
```
- 인쇄: `window.print()`
- PDF 저장: `window.print()` (브라우저 인쇄 다이얼로그에서 PDF 선택)
- MD 저장: 리포트 DOM에서 텍스트 추출 → `.md` 파일 다운로드 (`Blob` + `<a download>`)
- `@media print`: 테마 버튼·저장 버튼 숨김, 흰 배경

### 6. Header Card
스킬명 / 분석일 / 카테고리 배지 포함:
```html
<div class="report-header">
  <div class="header-left">
    <div class="logo">AX Skillset</div>
    <h1>스킬명</h1>
    <div class="subtitle">서브타이틀</div>
  </div>
  <div class="header-right">
    <span class="badge badge-analysis">Analysis</span>  <!-- badge-planning / badge-common -->
    <div class="report-date">YYYY-MM-DD</div>
  </div>
</div>
```

### 7. Section Card
각 분석 섹션을 카드로 감쌈:
```html
<div class="section-card">
  <div class="section-title">📌 섹션 타이틀</div>
  <!-- 내용 -->
</div>
```

### 8. Summary Grid
핵심 요약 2열 그리드 — Header Card 바로 아래 첫 Section Card에 배치:
```html
<div class="summary-grid">
  <div class="summary-item">
    <div class="summary-label">레이블</div>
    <div class="summary-value">값</div>
  </div>
</div>
```

### 9. Styled Table
표 형식 데이터 (헤더 강조, 행 hover):
```html
<table class="styled-table">
  <thead><tr><th>#</th><th>항목</th><th>설명</th></tr></thead>
  <tbody><tr><td>1</td><td>데이터</td><td>값</td></tr></tbody>
</table>
```

### 10. Checklist Layout
✅⚠️❌🔲 아이콘으로 상태 구분:
```html
<div class="checklist-item">
  <span class="check-icon status-pass">✅</span>  <!-- status-warn / status-fail / status-open -->
  <span><strong>항목:</strong> 내용</span>
</div>
```

---

## 기술 조건

- 외부 라이브러리 없는 단독 실행 HTML
- `<!DOCTYPE html>` 포함 완전한 파일
- CSS 변수 기반 테마 토큰 사용 (`var(--bg)`, `var(--card)` 등)
- CSS는 `<style>` 태그 내부 인라인
- MD 저장 함수 포함 (`exportMarkdown()` + `saveReport()`)
- 모바일 대응 (`<meta name="viewport">` 포함)
