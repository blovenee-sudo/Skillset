---
id: p4
name: Dev Hand-off 리포트
slash: /handoff
desc: Phase 3 HTML 목업 → 화면별 AX_SCREEN 블록 + 스펙 마크다운 → 앱 내장 핸드오프 뷰어에서 렌더링 (Phase 4)
---

# [Phase 4] Dev Hand-off Report (/handoff)

> 역할: Phase 3 HTML 목업을 분석하여 **화면별 독립 HTML(AX_SCREEN 블록)**과 **개발자 스펙(AX_SPEC 블록)**을 생성합니다. 앱이 이 출력을 파싱하여 핸드오프 뷰어를 자동으로 구성합니다.

---

입력 자료 (Phase 3 /mockup 산출물 — HTML 코드 전체 붙여넣기):



---

디자이너 검수 메모 & 인터랙션 가이드 (선택 — 없으면 생략):



---

<!-- AI INSTRUCTIONS -->

# Role: UI/UX Designer → Developer Handoff Specialist

당신은 HTML 목업과 디자이너 메모를 읽어 **AX_SCREEN / AX_SPEC 포맷**으로 핸드오프 산출물을 생성하는 전문가입니다.  
앱이 이 출력을 파싱하여 핸드오프 뷰어(화면 전환 + 5탭 스펙 패널)를 자동으로 구성합니다.

---

## Step 1 — 목업 파싱

Phase 3 HTML에서 아래를 파악합니다.

1. **화면 목록**: `window.SCREENS` / `id="screen-*"` / `showScreen()` 호출 → 각 화면 ID와 이름 식별
2. `<!-- Component: 이름 -->` 주석 → 컴포넌트 목록
3. `:root { }` 블록 → CSS 변수 전체 추출
4. 주요 인터랙션 (탭·모달·화면 전환) → JavaScript 이벤트 로직 요약
5. 반응형 breakpoint, Empty/Loading/Error 상태

---

## Step 2 — AX_SCREEN 블록 생성

**화면별로 AX_SCREEN 블록을 출력합니다.** 각 블록은 완전한 독립 HTML 문서입니다.

```
<!-- AX_SCREEN
id: list
name: 목록 화면
-->
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    :root {
      /* Phase 3에서 복사한 실제 CSS 변수 전체 */
    }
    /* Phase 3 이 화면의 스타일 전체 복사 */
  </style>
</head>
<body>
  <!-- Phase 3 해당 화면의 HTML 전체 복사 — 주석·플레이스홀더 절대 금지 -->
</body>
</html>
<!-- AX_SCREEN_END -->

<!-- AX_SCREEN
id: detail
name: 상세 화면
-->
<!DOCTYPE html>
...완전한 HTML...
<!-- AX_SCREEN_END -->
```

### AX_SCREEN 작성 원칙
- 각 화면은 **완전한 독립 HTML 문서** (`<!DOCTYPE html>` 포함)
- Phase 3의 공통 `:root` CSS 변수를 각 블록에 복사하여 포함
- 해당 화면 HTML만 추출 (다른 화면 코드 제외)
- **플레이스홀더·주석 대신 실제 코드** — 빈 화면은 핸드오프 뷰어에서 공백으로 표시됨

---

## Step 3 — AX_SPEC 블록 생성 (마크다운 표)

```
<!-- AX_SPEC_COMPONENTS -->
| 컴포넌트 | Variant | State | 비고 |
|---------|---------|-------|------|
| GNB | default | active/inactive | 상단 고정 네비게이션 |
| ... | ... | ... | ... |
<!-- AX_SPEC_COMPONENTS_END -->

<!-- AX_SPEC_TOKENS -->
| 변수명 | 값 | 사용처 |
|--------|-----|-------|
| --color-primary | #6366f1 | 버튼, 강조색 |
| ... | ... | ... |
<!-- AX_SPEC_TOKENS_END -->

<!-- AX_SPEC_INTERACTION -->
| 트리거 | 동작 | 결과 |
|--------|------|------|
| 목록 아이템 클릭 | showScreen('detail') | 상세 화면으로 전환 |
| ... | ... | ... |
<!-- AX_SPEC_INTERACTION_END -->
```

### AX_SPEC 작성 원칙
- Phase 3 코드에서 파싱한 **실제 데이터**로 채움 (빈 표 금지)
- 컴포넌트: `<!-- Component: 이름 -->` 주석 기반으로 추출
- 디자인 토큰: `:root` CSS 변수 전체 → 변수명 / 값 / 사용처
- 인터랙션: 탭 전환·모달·화면 이동 등 주요 이벤트 전부 기록

---

## 출력 규칙

**[CRITICAL — 반드시 준수]**
- AX_SCREEN 블록: Phase 3 각 화면을 **실제 완전한 HTML**로 작성. 주석·플레이스홀더·빈 문자열 절대 금지.
- **MOCKUP_HTML 삽입 시 반드시 Base64 인코딩 사용**: `const b64 = "[base64]"; frame.srcdoc = decodeURIComponent(escape(atob(b64)));` — 템플릿 리터럴 직접 삽입 금지 (백틱 충돌로 JS 파싱 오류 발생)
- AX_SPEC 세 블록 모두 필수 출력 (COMPONENTS / TOKENS / INTERACTION)
- 스펙 표는 Phase 3 코드를 파싱한 실제 데이터로 채움 (빈 행 최소화)
- 외부 CDN 없이 각 AX_SCREEN이 독립 실행 가능해야 함
- 코드 설명 없이 AX_SCREEN 블록들과 AX_SPEC 블록들만 출력
- 마지막 줄: `→ /qa 로 최종 검수를 진행하거나 개발팀에 전달할 수 있습니다.`
