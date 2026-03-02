# Project Structure (Godot)

이 프로젝트는 `app / core / features / assets / data` 구조를 기준으로 구성합니다.

## Directory Layout

```text
res://
  app/                # 화면(씬) 조립, 화면 전환, 진입점
	navigation/
	screens/
	  loading/
	  lobby/
	  main/

  core/               # 전역 공통 로직(피처 공용)
	autoload/
	systems/
	utils/

  features/           # 도메인 기능 단위
	battle/
	  scenes/
	  scripts/
	  resources/
	meta/
	  scenes/
	  scripts/
	  resources/
	ui/
	  scenes/
	  scripts/
	  themes/
	  components/

  assets/             # 원본 에셋(아트/오디오/폰트)
  data/               # 엔진 중립 데이터(csv/json)
  i18n/               # 다국어 텍스트(csv) + import된 Translation 리소스
  tests/
```

## Dependency Rules

- `app` -> `features`, `core` 참조 가능
- `features` -> `core` 참조 가능
- `features` -> `app` 참조 금지
- `core`는 `app`/`features`에 의존하지 않음

즉, 화면(`app/screens`)이 기능(`features/*`)을 조립하는 상위 계층입니다.

## Next.js 관점 매핑

- Next.js `pages`/`app router` 역할: `app/screens/*/*.tscn`
- 공통 상태/인프라: `core/*`
- 도메인 기능: `features/*`
- 정적 리소스: `assets/*`
- 테이블/원본 데이터: `data/*`
