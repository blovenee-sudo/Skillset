---
id: s11
name: 리포트 생성
slash: /generate-report
desc: 이전 분석 결과를 HTML 리포트 파일로 변환
category: 공통
---

이전 분석 결과 전체를 아래 HTML 구조로 변환해 코드블록으로 출력하세요.

변환 규칙:
1. `<style>`·`<script>` 블록은 한 글자도 수정하지 않습니다.
2. 이전 분석의 **모든 섹션과 내용을 빠짐없이** 포함합니다. 요약·생략하지 않습니다.
3. 분석 결과의 섹션마다 `.section-card`를 하나씩 추가합니다. 섹션 수는 분석 결과를 따릅니다.
4. 각 콘텐츠 유형에 맞는 요소를 선택합니다:
   - 핵심 요약 4개 내외 → `.summary-grid > .summary-item`
   - 항목별 제목+본문 → `.spec-item`
   - 표 형식 데이터 → `.styled-table`
   - 체크리스트·확인 사항 → `.checklist-item` + `.check-icon`
   - 번호 인사이트 목록 → `.insight-item`
   - 서술형 텍스트·목록 → `<p>` 또는 `<ul><li>`
5. 헤더의 프로젝트명·스킬명·날짜·카테고리는 이전 분석 맥락에서 추출합니다.

---

```html
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>[프로젝트명] 분석 리포트</title>
  <style>
  *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}

  /* Light Mode — 기본값 */
  :root{
    --bg:#f8fafc;--card:#ffffff;--card2:#f1f5f9;
    --border:#e2e8f0;--border2:#e8edf4;
    --text:#111827;--text2:#374151;--muted:#9ca3af;
    --accent:#4f46e5;--accent2:#6366f1;--spec-body:#4b5563;
  }
  /* Dark Mode */
  html.dark{
    --bg:#0f1117;--card:#1a1d2e;--card2:#12151f;
    --border:#2d2f3e;--border2:#23263a;
    --text:#e2e8f0;--text2:#cbd5e1;--muted:#475569;
    --accent:#6366f1;--accent2:#818cf8;--spec-body:#94a3b8;
  }

  body{font-family:-apple-system,BlinkMacSystemFont,'Segoe UI','Noto Sans KR',sans-serif;background:var(--bg);color:var(--text);line-height:1.65;padding:48px 20px 64px;transition:background .2s,color .2s}
  .report-wrapper{max-width:860px;margin:0 auto}

  /* Theme Toggle */
  .theme-toggle{position:fixed;top:16px;right:20px;background:var(--card);border:1px solid var(--border);border-radius:20px;padding:6px 14px;font-size:12px;font-weight:600;color:var(--text2);cursor:pointer;z-index:100;transition:background .2s,border-color .2s}
  .theme-toggle:hover{border-color:var(--accent2);color:var(--accent2)}

  /* Header Card */
  .report-header{background:var(--card);border:1px solid var(--border);border-radius:14px;padding:32px 36px;margin-bottom:20px;display:flex;justify-content:space-between;align-items:flex-start;gap:16px;transition:background .2s,border-color .2s}
  .logo{font-size:10px;font-weight:800;letter-spacing:2.5px;color:var(--accent);text-transform:uppercase;margin-bottom:10px}
  .report-header h1{font-size:26px;font-weight:700;color:var(--text);line-height:1.3;margin-bottom:6px}
  .subtitle{font-size:13px;color:var(--muted)}
  .header-right{text-align:right;flex-shrink:0}
  .badge{display:inline-block;padding:5px 13px;border-radius:20px;font-size:10px;font-weight:800;letter-spacing:1px;text-transform:uppercase}
  .badge-analysis{background:rgba(99,102,241,.1);color:var(--accent2);border:1px solid rgba(99,102,241,.25)}
  .badge-planning{background:rgba(16,185,129,.1);color:#059669;border:1px solid rgba(16,185,129,.2)}
  .badge-common{background:rgba(245,158,11,.1);color:#d97706;border:1px solid rgba(245,158,11,.2)}
  html.dark .badge-planning{color:#34d399}html.dark .badge-common{color:#fbbf24}
  .report-date{font-size:12px;color:var(--muted);margin-top:8px}

  /* Section Card */
  .section-card{background:var(--card);border:1px solid var(--border);border-radius:14px;padding:28px 32px;margin-bottom:16px;transition:background .2s,border-color .2s}
  .section-title{font-size:14px;font-weight:700;color:var(--accent2);margin-bottom:20px;padding-bottom:14px;border-bottom:1px solid var(--border)}

  /* Summary Grid */
  .summary-grid{display:grid;grid-template-columns:1fr 1fr;gap:10px}
  @media(max-width:540px){.summary-grid{grid-template-columns:1fr}}
  .summary-item{background:var(--card2);border:1px solid var(--border);border-radius:10px;padding:14px 16px;transition:background .2s}
  .summary-label{font-size:10px;font-weight:700;color:var(--muted);text-transform:uppercase;letter-spacing:.8px;margin-bottom:5px}
  .summary-value{font-size:13px;color:var(--text2)}

  /* Spec Items */
  .spec-item{padding:16px 0;border-bottom:1px solid var(--border2)}
  .spec-item:last-child{border-bottom:none;padding-bottom:0}
  .spec-item-title{font-size:14px;font-weight:700;color:var(--text);margin-bottom:8px}
  .spec-item-body{font-size:13px;color:var(--spec-body);line-height:1.75}
  .tag{display:inline-block;padding:2px 8px;border-radius:4px;font-size:11px;font-weight:600;margin:2px 4px 2px 0}
  .tag-estimate{background:rgba(245,158,11,.1);color:#d97706;border:1px solid rgba(245,158,11,.2)}
  html.dark .tag-estimate{color:#fbbf24}

  /* Styled Table */
  .styled-table{width:100%;border-collapse:collapse;font-size:13px}
  .styled-table th{background:var(--card2);color:var(--muted);font-weight:700;padding:10px 14px;text-align:left;font-size:10px;text-transform:uppercase;letter-spacing:.8px}
  .styled-table th:first-child{border-radius:6px 0 0 6px}.styled-table th:last-child{border-radius:0 6px 6px 0}
  .styled-table td{padding:13px 14px;color:var(--text2);border-top:1px solid var(--border2);vertical-align:top}
  .styled-table tr:hover td{background:rgba(128,128,128,.04)}

  /* Checklist Layout */
  .checklist-item{display:flex;align-items:flex-start;gap:12px;padding:12px 0;border-bottom:1px solid var(--border2);font-size:13px;color:var(--text2);line-height:1.6}
  .checklist-item:last-child{border-bottom:none;padding-bottom:0}
  .check-icon{flex-shrink:0;font-size:15px;margin-top:1px}
  .status-pass{color:#10b981}.status-warn{color:#f59e0b}.status-fail{color:#ef4444}.status-open{color:var(--accent2)}

  /* Insight Items */
  .insight-item{display:flex;gap:14px;padding:14px 0;border-bottom:1px solid var(--border2);align-items:flex-start}
  .insight-item:last-child{border-bottom:none}
  .insight-num{width:26px;height:26px;border-radius:50%;background:rgba(99,102,241,.12);color:var(--accent2);font-size:12px;font-weight:700;display:flex;align-items:center;justify-content:center;flex-shrink:0}
  .insight-body{font-size:13px;color:var(--text2);line-height:1.7}
  .insight-body strong{color:var(--text);display:block;margin-bottom:3px}

  /* Save Bar */
  .save-bar{display:flex;justify-content:center;align-items:center;gap:10px;padding:36px 0 4px}
  .save-select{background:var(--card);color:var(--text);border:1px solid var(--border);border-radius:8px;padding:11px 36px 11px 14px;font-size:13px;font-weight:600;cursor:pointer;appearance:none;background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%236366f1' stroke-width='2'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");background-repeat:no-repeat;background-position:right 10px center;background-size:16px}
  .save-select:focus{outline:none;border-color:var(--accent2)}
  .btn-save{background:var(--accent);color:#fff;border:none;border-radius:8px;padding:11px 28px;font-size:14px;font-weight:700;cursor:pointer}
  .btn-save:hover{opacity:.88}

  @media print{.theme-toggle,.save-bar{display:none!important}body{background:#fff!important;padding:0}.section-card,.report-header{border:1px solid #ddd!important;background:#fff!important}}
  </style>
</head>
<body>
<button class="theme-toggle" id="themeToggle" onclick="toggleTheme()">🌙 다크 모드</button>
<div class="report-wrapper">

  <!-- ① HEADER: 이전 분석 맥락에서 추출해 채우기
       badge 클래스: badge-analysis / badge-planning / badge-common -->
  <div class="report-header">
    <div class="header-left">
      <div class="logo">AX Skillset</div>
      <h1>[프로젝트명 또는 분석 주제]</h1>
      <div class="subtitle">[사용 스킬명 / 분석 유형 한 줄]</div>
    </div>
    <div class="header-right">
      <span class="badge badge-analysis">[Analysis]</span>
      <div class="report-date">[YYYY-MM-DD]</div>
    </div>
  </div>

  <!--
  ② 이전 분석의 각 섹션 → .section-card 하나씩 작성.
     섹션 제목·순서는 분석 결과 그대로 따릅니다. 내용을 요약하거나 생략하지 않습니다.

     ■ 사용 가능한 레이아웃 요소 (섹션 성격에 맞게 선택):

     [핵심 요약 — 4개 내외 카드]
     <div class="summary-grid">
       <div class="summary-item"><div class="summary-label">레이블</div><div class="summary-value">값</div></div>
     </div>

     [항목별 제목+본문]
     <div class="spec-item">
       <div class="spec-item-title">항목명</div>
       <div class="spec-item-body">상세 내용 <span class="tag tag-estimate">[추정]</span></div>
     </div>

     [표 형식]
     <table class="styled-table"><thead><tr><th>#</th><th>항목</th><th>내용</th></tr></thead>
     <tbody><tr><td>1</td><td>항목</td><td>내용</td></tr></tbody></table>

     [체크리스트]
     <div class="checklist-item"><span class="check-icon status-open">🔲</span><span><strong>항목:</strong> 내용</span></div>
     <!-- status-pass ✅ / status-warn ⚠️ / status-fail ❌ / status-open 🔲 -->

     [번호 인사이트]
     <div class="insight-item"><div class="insight-num">1</div>
     <div class="insight-body"><strong>제목</strong>내용</div></div>

     [서술·목록]
     <p style="font-size:13px;color:var(--text2);line-height:1.75">내용</p>
     <ul style="font-size:13px;color:var(--text2);line-height:2;padding-left:20px"><li>항목</li></ul>
  -->

  <!-- 아래 .section-card를 분석 섹션 수만큼 반복 작성 -->
  <div class="section-card">
    <div class="section-title">[N]. [섹션 제목]</div>
    <!-- 위 레이아웃 요소 중 적합한 것 사용 -->
  </div>

  <!-- SAVE BAR: 수정 금지 -->
  <div class="save-bar">
    <select id="saveFormat" class="save-select">
      <option value="html">💾 HTML 저장</option>
      <option value="print">🖨️ 인쇄</option>
      <option value="pdf">📄 PDF 저장</option>
      <option value="md">📝 MD 저장</option>
    </select>
    <button class="btn-save" onclick="saveReport()">저장</button>
  </div>
</div>

<script>
/* Theme Toggle — 수정 금지 */
const btn=document.getElementById('themeToggle');
const saved=localStorage.getItem('ax-report-theme');
if(saved==='dark'){document.documentElement.classList.add('dark');btn.textContent='☀️ 라이트 모드';}
function toggleTheme(){
  const isDark=document.documentElement.classList.toggle('dark');
  btn.textContent=isDark?'☀️ 라이트 모드':'🌙 다크 모드';
  localStorage.setItem('ax-report-theme',isDark?'dark':'light');
}

/* Save / Export — 수정 금지 */
function saveReport(){
  const f=document.getElementById('saveFormat').value;
  const title=document.querySelector('.report-header h1')?.textContent?.trim()||'리포트';
  const slug=title.replace(/[\s·\/]+/g,'_');
  if(f==='html'){
    const html='<!DOCTYPE html>\n'+document.documentElement.outerHTML;
    const blob=new Blob([html],{type:'text/html;charset=utf-8'});
    const a=document.createElement('a');a.href=URL.createObjectURL(blob);a.download=`${slug}.html`;
    document.body.appendChild(a);a.click();document.body.removeChild(a);URL.revokeObjectURL(a.href);
    return;
  }
  if(f==='print'||f==='pdf'){window.print();return;}
  const lines=[];
  const subtitle=document.querySelector('.subtitle')?.textContent?.trim()||'';
  const badge=document.querySelector('.badge')?.textContent?.trim()||'';
  const date=document.querySelector('.report-date')?.textContent?.trim()||'';
  lines.push(`# ${title}`);
  if(subtitle)lines.push(`> ${subtitle}`);
  lines.push('');
  if(badge)lines.push(`**카테고리**: ${badge}`);
  if(date)lines.push(`**날짜**: ${date}`);
  lines.push('','---','');
  document.querySelectorAll('.section-card').forEach(card=>{
    const t=card.querySelector('.section-title')?.textContent?.trim();
    if(t)lines.push(`## ${t}`,'');
    card.querySelectorAll('.summary-item').forEach(s=>{
      const l=s.querySelector('.summary-label')?.textContent?.trim();
      const v=s.querySelector('.summary-value')?.textContent?.trim();
      if(l&&v)lines.push(`- **${l}**: ${v}`);
    });
    card.querySelectorAll('.spec-item').forEach(s=>{
      const st=s.querySelector('.spec-item-title')?.textContent?.trim();
      const sb=s.querySelector('.spec-item-body')?.innerText?.trim();
      if(st)lines.push('',`### ${st}`);
      if(sb)lines.push(sb);
    });
    const table=card.querySelector('.styled-table');
    if(table){
      const ths=[...table.querySelectorAll('th')].map(h=>h.textContent.trim());
      if(ths.length){
        lines.push('',`| ${ths.join(' | ')} |`,`| ${ths.map(()=>'---').join(' | ')} |`);
        table.querySelectorAll('tbody tr').forEach(tr=>{
          const tds=[...tr.querySelectorAll('td')].map(d=>d.innerText.trim().replace(/\n+/g,' '));
          lines.push(`| ${tds.join(' | ')} |`);
        });
      }
    }
    card.querySelectorAll('.checklist-item').forEach(c=>{
      const icon=c.querySelector('.check-icon')?.textContent?.trim()||'';
      const span=c.querySelector('span:not(.check-icon)');
      const text=(span?.innerText||c.innerText).trim();
      lines.push(`- ${icon} ${text}`);
    });
    card.querySelectorAll('.insight-item').forEach((ins,i)=>{
      const body=ins.querySelector('.insight-body');
      if(body){const s=body.querySelector('strong')?.textContent?.trim()||'';lines.push(`${i+1}. **${s}** ${body.innerText.replace(s,'').trim()}`,'');}
    });
    lines.push('');
  });
  const md=lines.join('\n').replace(/\n{3,}/g,'\n\n');
  const blob=new Blob([md],{type:'text/markdown;charset=utf-8'});
  const a=document.createElement('a');a.href=URL.createObjectURL(blob);a.download=`${slug}.md`;
  document.body.appendChild(a);a.click();document.body.removeChild(a);URL.revokeObjectURL(a.href);
}
</script>
</body>
</html>
```
