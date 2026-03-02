# AGENTS.md

## 기본 원칙
- 모든 응답은 한국어로 작성한다.
- 라우팅은 `GameManager.route`를 통해서만 수행한다.
- 화면 루트 스크립트는 가능한 한 얇게 유지한다.

## 라우팅 패턴
- `RouteManager` 위치: `res://core/systems/RouteManager/RouteManager.gd`
- `GameManager`는 `RouteManager`를 자식으로 초기화하고 `route: RouteManager` 타입을 유지한다.
- 화면 이동 호출은 아래 체인을 표준으로 사용한다.
  - `GameManager.route.go.loading()`
  - `GameManager.route.go.lobby()`
  - `GameManager.route.go.main()`
  - `GameManager.route.go.settings()`

## 로딩 화면 패턴
- `loading.tscn` 루트에는 스크립트를 붙이지 않는다.
- 로딩 화면 전용 UI 로직은 `res://app/screens/loading/nodes/` 아래 스크립트로 분리한다.
- 재사용 계획이 없는 UI 컴포넌트는 `features`가 아닌 해당 화면 하위 폴더에 둔다.

## 파일 배치 패턴
- 관련 스크립트와 `.gd.uid`는 같은 기능 폴더 안에 함께 둔다.
- 루트 레벨 및 상위 공용 폴더에 화면 전용 스크립트를 흩뿌리지 않는다.
