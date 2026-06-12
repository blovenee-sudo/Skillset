---
id: s7
name: 회의록 · 액션아이템
slash: /meeting-notes
desc: 미팅 후 정리 자동화
---

회의 메모/전사본을 아래 형식으로 정리하세요.

- 결정사항
- 액션아이템(담당, 기한, 완료조건)
- 열린 이슈 / 다음 논의 안건

원문:

---
<!-- HTML 리포트 출력 -->
결과 출력 후, 동일 내용을 담은 완성된 HTML 파일을 코드블록으로 출력하세요.
- 배경 #0f1117 · 카드 #1a1d2e · 포인트 #6366f1 · 텍스트 #e2e8f0
- 상단 헤더: 스킬명 · 날짜 · 카테고리 배지
- 섹션별 카드, 표는 skill_report_template.html 디자인 패턴 참고
- 하단: &lt;button onclick="window.print()"&gt;🖨️ 인쇄 / PDF 저장&lt;/button&gt;
- 외부 라이브러리 없는 단독 실행 HTML (CSS 인라인)
