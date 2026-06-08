# AX 스킬셋 — 환경 경로 설정 (템플릿)

> **사용법**: 이 파일을 `ENV.md`로 복사한 뒤 실제 경로로 수정하세요.
> `ENV.md` 는 Git 커밋하지 않습니다 (`.gitignore` 처리됨).

```bash
cp ENV.example.md ENV.md
# 이후 ENV.md 에서 active 값과 경로를 수정
```

---

## active: personal

---

## personal — 개인 PC

| 항목 | 경로 |
|------|------|
| 프로그램 설치 | `/Users/[username]/Desktop/클로드코드/회사/Skillset` |
| 스킬 MD 파일 | `/Users/[username]/Desktop/클로드코드/회사/Skillset/skills` |
| 옵시디언 저장 | `/Users/[username]/Library/Mobile Documents/iCloud~md~obsidian/Documents/bonee/회사/목표설정` |

## work — 회사 PC

| 항목 | 경로 |
|------|------|
| 프로그램 설치 | `~/Desktop/Skillset` |
| 스킬 MD 파일 | `~/Desktop/Skillset/skills` |
| 옵시디언 저장 | `~/Library/CloudStorage/WORKS드라이브-[email]/내 드라이브/Skillset/Obsidian/목표설정` |

---

## 전환 방법

1. `ENV.md` 상단의 `active:` 값을 변경
   - 개인 PC: `active: personal`
   - 회사 PC: `active: work`
2. 저장 후 Claude Code 재시작
