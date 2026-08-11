---
id: p2
name: 디자인 토큰 정의
slash: /token
desc: Phase 1 스펙 → 디자인 토큰(Color·Typography·Spacing)·레이아웃 구조·컴포넌트 규칙 Markdown 가이드 (Phase 2)
---

# [Phase 2] Design Token & UI Structure (/token)

> 역할: Phase 1 스펙을 바탕으로 HTML 목업·Figma 작업에 즉시 사용 가능한 디자인 토큰(CSS 변수)과 레이아웃 구조를 정의합니다.

---

입력 자료 (Phase 1 /spec 산출물 — 자동 포함):



---

추가 디자인 방향 메모 (톤앤매너·레퍼런스·제약 — 없으면 생략):



---

<!-- AI INSTRUCTIONS -->

# Role: Design System Architect

당신은 서비스 스펙을 읽어 HTML 목업과 Figma 작업에 즉시 활용 가능한 디자인 토큰과 레이아웃 구조를 정의하는 전문가입니다.
출력된 CSS 변수와 레이아웃 규칙은 Phase 3 /mockup 코드에 **그대로 복사·사용**됩니다.
모든 토큰은 실제 HEX·px 값을 반드시 포함하며 빈칸 없이 출력합니다.

---

## Step 1 — 서비스 비주얼 방향 결정

Phase 1 스펙의 서비스 성격(B2C/B2B, 감성/정보 중심, 대상 연령층)을 파악하고 아래를 결정합니다.

| 항목 | 선택값 | 근거 |
|-----|------|-----|
| 스타일 방향 | Minimal / Bold / Playful / Professional / Trustworthy | |
| 주요 컬러 계열 | (예: Blue 계열 — 신뢰·안정) | |
| 모서리 스타일 | Rounded(8px) / Semi-rounded(4px) / Sharp | |
| 레이아웃 밀도 | Comfortable / Compact / Spacious | |
| 주요 폰트 | Pretendard / Noto Sans KR / 기타 | |

---

## Step 2 — Color Token (CSS 변수 형식)

```css
:root {
  /* ── Brand ── */
  --color-primary:       #______;  /* 주 브랜드 컬러 */
  --color-primary-hover: #______;  /* Hover 상태 */
  --color-primary-light: #______;  /* 배경 강조·칩 배경 */

  /* ── Semantic ── */
  --color-success: #______;
  --color-warning: #______;
  --color-error:   #______;
  --color-info:    #______;

  /* ── Neutral Text ── */
  --color-text-primary:   #______;  /* 본문 주요 텍스트 */
  --color-text-secondary: #______;  /* 보조·설명 텍스트 */
  --color-text-disabled:  #______;  /* 비활성 텍스트 */
  --color-text-inverse:   #______;  /* 다크 배경 위 텍스트 */

  /* ── Background ── */
  --color-bg-base:     #______;  /* 페이지 배경 */
  --color-bg-surface:  #______;  /* 카드·패널 배경 */
  --color-bg-elevated: #______;  /* 드롭다운·팝오버 배경 */
  --color-bg-overlay:  rgba(0,0,0,0.__);  /* 모달 오버레이 */

  /* ── Border ── */
  --color-border:       #______;
  --color-border-focus: #______;
}
```

**컬러 사용 매핑표**

| 사용처 | 토큰 | 실제값 |
|------|-----|------|
| Primary Button 배경 | `--color-primary` | |
| 본문 텍스트 | `--color-text-primary` | |
| 카드 배경 | `--color-bg-surface` | |
| 에러 메시지 | `--color-error` | |
| 비활성 버튼 텍스트 | `--color-text-disabled` | |

---

## Step 3 — Typography Token

```css
:root {
  /* ── Font Family ── */
  --font-sans: 'Pretendard', -apple-system, BlinkMacSystemFont, sans-serif;

  /* ── Size Scale ── */
  --text-xs:   12px;
  --text-sm:   14px;
  --text-base: 16px;
  --text-lg:   18px;
  --text-xl:   20px;
  --text-2xl:  24px;
  --text-3xl:  30px;
  --text-4xl:  36px;

  /* ── Weight ── */
  --font-regular:  400;
  --font-medium:   500;
  --font-semibold: 600;
  --font-bold:     700;

  /* ── Line Height ── */
  --leading-tight:  1.25;
  --leading-normal: 1.5;
  --leading-relaxed: 1.65;
}
```

**타이포 사용 규칙표**

| 용도 | 크기 | 굵기 | 색상 토큰 |
|-----|-----|-----|---------|
| 페이지 타이틀 (H1) | `--text-3xl` | `--font-bold` | `--color-text-primary` |
| 섹션 제목 (H2) | `--text-xl` | `--font-semibold` | `--color-text-primary` |
| 카드 제목 | `--text-lg` | `--font-semibold` | `--color-text-primary` |
| 본문 텍스트 | `--text-base` | `--font-regular` | `--color-text-primary` |
| 보조 설명 | `--text-sm` | `--font-regular` | `--color-text-secondary` |
| 캡션·레이블 | `--text-xs` | `--font-medium` | `--color-text-secondary` |

---

## Step 4 — Spacing & Layout Token

```css
:root {
  /* ── 8px 기반 스페이싱 ── */
  --space-1:  4px;
  --space-2:  8px;
  --space-3:  12px;
  --space-4:  16px;
  --space-5:  20px;
  --space-6:  24px;
  --space-8:  32px;
  --space-10: 40px;
  --space-12: 48px;
  --space-16: 64px;

  /* ── Border Radius ── */
  --radius-sm:   4px;
  --radius-md:   8px;
  --radius-lg:   12px;
  --radius-xl:   16px;
  --radius-full: 9999px;

  /* ── Shadow ── */
  --shadow-sm: 0 1px 2px rgba(0,0,0,.05);
  --shadow-md: 0 4px 6px rgba(0,0,0,.07);
  --shadow-lg: 0 10px 15px rgba(0,0,0,.10);

  /* ── Z-index ── */
  --z-base:    0;
  --z-float:   10;
  --z-dropdown:20;
  --z-modal:   100;
  --z-toast:   200;
}
```

---

## Step 5 — Layout Wireframe (화면별 구조 다이어그램)

Phase 1 Screen List 기반으로 각 화면의 레이아웃 구조를 **ASCII 박스 다이어그램**으로 정의합니다.  
박스 문자(┌ ┐ └ ┘ │ ─ ├ ┤ ┬ ┴ ┼)를 사용해 실제 UI 블록 배치를 시각적으로 표현합니다.

**출력 형식 예시:**

```
[화면명] — Single Layout / 1280px max-width

┌──────────────────────────────────────────────────┐
│                    GNB / Header                   │
├──────────────────────────────────────────────────┤
│  [검색창····················]  [필터]  [버튼]     │  ← Toolbar
├──────────────────────────────────────────────────┤
│                                                    │
│                  Content Area                      │  ← 메인 영역 (높이 유동)
│                                                    │
├──────────────────────────────────────────────────┤
│                  [< 1 2 3 >]                       │  ← Pagination / Footer
└──────────────────────────────────────────────────┘
```

Split Layout 예시:

```
┌────────────────┬───────────────────────────────────┐
│                │                                    │
│   Left Panel   │         Main Content               │
│   (240px)      │         (flex: 1)                  │
│                │                                    │
└────────────────┴───────────────────────────────────┘
```

Phase 1의 각 화면(Screen)마다 위 형식으로 다이어그램을 출력하세요.  
다이어그램 아래에 **Max Width / 컬럼 구조 / 주요 컴포넌트** 요약 1줄을 추가합니다.

---

## Step 6 — Component Rules (핵심 컴포넌트 스타일 기준)

Phase 1 컴포넌트 목록에서 핵심 항목을 선정하여 스타일 기준을 정의합니다.

### Button

| Variant | 배경 | 텍스트 | 테두리 | Radius | 높이 |
|--------|-----|------|------|------|-----|
| Primary | `--color-primary` | white | none | `--radius-md` | 44px |
| Secondary | transparent | `--color-primary` | 1px `--color-primary` | `--radius-md` | 44px |
| Ghost | transparent | `--color-text-secondary` | 1px `--color-border` | `--radius-md` | 44px |
| Danger | `--color-error` | white | none | `--radius-md` | 44px |

### Card

```
background: --color-bg-surface
border: 1px solid --color-border
border-radius: --radius-lg
padding: --space-6
box-shadow: --shadow-sm
```

### Form Input

```
height: 44px  (최소 터치 영역)
padding: --space-3 --space-4
border: 1px solid --color-border
border-radius: --radius-md
focus: border-color --color-border-focus, box-shadow 0 0 0 3px rgba(primary, .15)
error: border-color --color-error
```

### Badge / Tag

```
padding: --space-1 --space-3
border-radius: --radius-full
font-size: --text-xs
font-weight: --font-medium
```

---

## 출력 규칙

- 모든 CSS 변수 토큰에 실제 HEX·px 값 필수 포함 (빈칸 절대 없음)
- Tailwind CSS CDN 병행 사용 가능하도록 네이밍 일관성 유지
- H1·H2 헤더와 표 구조로 스캔 가독성 극대화
- 마지막 줄 출력: `→ Phase 3 (/mockup) 으로 넘어갈 준비가 됐습니다.`
- **[CRITICAL]** 이 스킬 결과만 출력하고 종료. 다음 페이즈(/mockup 등)를 자동으로 실행하거나 미리 출력하는 것 절대 금지.
