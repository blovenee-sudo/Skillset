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
