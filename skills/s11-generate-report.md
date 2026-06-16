---
id: s11
name: 리포트 생성
slash: /generate-report
desc: 이전 분석 결과를 HTML 리포트 파일로 변환
category: 공통
---

이전 분석 결과 전체를 HTML 리포트로 변환합니다.

아래 GitHub 경로에서 HTML 템플릿 파일을 불러와 베이스 구조로 사용하세요:
`https://raw.githubusercontent.com/blovenee-sudo/Skillset/main/skills/skill_report_template.html`

변환 규칙:
1. `<style>`·`<script>` 블록은 수정하지 않습니다.
2. 이전 분석의 **모든 섹션·내용을 빠짐없이** 포함합니다. 요약·생략 금지.
3. 섹션마다 `.section-card` 하나씩. 콘텐츠 유형에 맞는 요소 선택:
   - 핵심 요약 → `.summary-grid > .summary-item`
   - 항목별 제목+본문 → `.spec-item` / 표 → `.styled-table`
   - 체크리스트 → `.checklist-item` / 인사이트 → `.insight-item`
4. 헤더(프로젝트명·스킬명·날짜·카테고리)는 분석 맥락에서 추출.

출력:
- 완성된 HTML을 코드블록으로 제공
- `~/Desktop/[프로젝트명]-report.html` 파일로 저장
