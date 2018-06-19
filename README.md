# RXSwift


- 테스트하기 어려운 Notification 대신에, 신호(Signal)를 사용할 수 있습니다. 많은 코드를 작성해야하는 delegate 대신에, 블록을 작성해서 switch 와 if를 삭제할 수 있습니다. RxSwift에서는 쉽게 조종할 수 있는 KVO, IBAction, 입력 필터, MVVM 그리고 더 많은 것이 포함되어 있습니다.

### - 정의
- 예) 스마트폰은 관찰이 가능(observable)합니다. 스마트폰은 페이스북 알림이나 메세지, 스냅챗 알림 등과 같이 신호(signal)를 방출합니다. 우리는 자연적으로 스마트폰을 구독(subscribe)하고 있고, 모든 알림을 홈 스크린에서 확인 할 수 있습니다. 이제 그 신호(signal)로 무엇을 할 지 정할 수 있습니다. 우리는 관찰자(observer)입니다.


## - Extension

- Funcion 이나 property를 확장
- Computed property 확장 가능
- Stored Property 확장 불가
- 모든곳에 사용 가능

---

- struct
- enum
- class
- protocol
- Int,String 등등 Primitive Type에서도 사용가능

---

- Override 불가

## - Extension Code
- Int 확장

```
extension Int {
	var double: Int {
		return self * 2
	}
	func times(_ time: Int) -> Int {
		return self * time
	}
}

// 실행
3.double
3.times(5)

// 결과
6
15
```
- enum

```
enum API {
	case getList
	case getDetail
}

extension API {
	var host: String {
		return "https://apiserver.com"
	}
	var path: String {
		switch self { // 이때 self는 API
			case .getList:
				return "/List"
			case .getDetail:
				return "/Detail"
		}
	}
	ver url: URL? {
		return URL(string: "\(self.host)\(self.path)")
	}
}

// 실행
API.getDetail.url

// 결과
https://apiserver.com/Detail

```

- struct

```
struct Position {
	var x: Float
	var y: Float
}

extension Position {
	func transform(withOther position: Position) -> Position {
		return Position(x: self.x _ position.x,
							y: self.y + position.y)
	}
}


```

## - Enumeration
- Switch와 함께 사용
- Associated value
- indirect

## - Enumeration 활용



