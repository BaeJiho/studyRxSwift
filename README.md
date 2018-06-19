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
EX 1.

```
enum Chicken {
	case fried
	case soySourced
	case spiceSourced
	case firedWithoutBone
	case soySourcedWithoutBone
	case spiceSourcedWithoutBone
}

enum Source {
	case soy
	case spice
}

enum ChickenShort {
	case fried(bone: Bool)
	case sourced(source: Source, bone: Bool)
}
// 실행
ChickenShort.sourced(source: Source.spice, bone: false)
```

EX 2.

```
enum API {
	case getList
	case getDetail(id: Int)
}

extension API {
	var host: String {
		return "https://apiserver.com"
	}
	var path: String {
		switch self {
			case .getList:
				return "/List"
			case let .getDetail(id):
				return "/list/\(id)/detail"
		}
	}
	var url: URL? {
		return URL(string: "\(self.host)\(self.path)"
	}
}
// 실행
API.getDetail(id:10).url

// 결과
https://apiserver.com/list/10/detail
```

EX 3.

```
indirect enum BinaryTree {
	case leaf
	case node(left: BinaryTree, right: BinaryTree, data: Int)
}

let tree: BinaryTree = .node(
	left: .node(left: .node(left: .leaf, right: .leaf, data: 1),
				  right: .node(left: .leaf, right: .leaf, data: 3),
				  data: 2),
	right: .node(left: .node(left: .leaf, right: .leaf, data: 5),
				   right: .node(left: .leaf, right: .leaf, data: 7),
				   data: 6),
	data: 4)
```

EX 4.

```
extension BinaryTree {
	func hasData(_ data: Int) -> Bool {
		switch self {
			case .leaf:
				return false
			case let .node(_,_,nodeData) where data == nodeData:
				return true
			case let .node(left,_,nodeData) where data < nodeData:
				return left.hasData(data)
			case let .node(_,right,nodeData) where data > nodeData:
				return rigth.hasData(data)
			case .node:
				return false
		}
	}
}

// 실행
tree.hasData(6)
tree.hasData(10)

// 결과
true
false
```

## Generic

- 자바의 Generic과 유사
- struct, enum, class등에서 사용가능
- type constraint

```
indirect enum BinaryTree<T: Comparable & Equatable> {
	case leaf
	case node(left: BinaryTree<T>, right: BinaryTree<T>, data: T)
}

extension BinaryTree {
	func hasData(_ data: T) -> Bool {
		switch self {
			case .leaf:
				return false
			case let .node(_,_,nodeData) where data == nodeData:
				return true
			case let .node(left,_,nodeData) where data < nodeData:
				return letf.hasData(data)
			case let .node(_,right,nodeData) where data > nodeData:
				return right.haseData(data)
			case .node:
				return false
		}
	}
}

let tree: BinaryTree<Int> = .node(
	left: .node(left: .node(left: .leaf, right: .leaf, data: 1),
				  right: .node(left: .leaf, right: .leaf, data: 3),
				  data: 2),
	right: .node(left: .node(left: .leaf, right: .leaf, data: 5),
					right: .node(left: .leaf, right: .leaf, data: 7),
					data: 6),
	data: 4)

let stringTree: BinaryTree<String> = .node(left: .leaf, right: .leaf, data: "1")

// 실행
tree.hasData(6)
tree.hasData(19)

stringTree.hasData("1")
stringTree.hasData("3")

// 결과

true
false

true
false
```

## Protocol

- 자바의 interface와 유사
- extension을 통해 기능 구현 가능
- 하지만 자바의 Abstract와는 다름
- extension을 통해 struct, enum, class, primitive type에서 구현가능

## Associated Type

- Protocol의 Generic
- 사용법 

(1) 추론, (2) typealias, (3) 직접선언

## - Associated Type 활용
```
protocol BinaryTreeProtocol {
	associatedtype T: Equatable, Comparable
	func hasData(_ data: T) -> Bool
}

// Typealias 방법

class BinaryTree: BinaryTreeProtocol {
	typealias T = Int
	static let leaf: BinaryTree = BinaryTree(left: nil, right: nil, data: nil)
	var left: BinaryTree?
	var right: BinaryTree?
	var data: T?
	
	init(left: BinaryTree? = BinaryTree.leaf,
		 right: BinaryTree? = BinaryTree.leaf,
		 data: T?) {
		 self.left = left
		 self.right = right
		 self.data = data
	}
	
	func hasData(_ data: T) -> Bool {
		return true
	}
}

// 추론 방법

class BinaryTree: BinaryTreeProtocol {
	static let leaf: BinaryTree = BinaryTree(left: nil, right: nil, data: nil)
	var left: BinaryTree?
	var right: BinaryTree?
	var data: Int?
	init(left: BinaryTree? = BinaryTree.leaf,
		  right: BinaryTree? = BinaryTree.leaf.
		  data: Int?) {
		  self.left = left
		  self.right = right
		  self.data = data	  
	}
	func hasData(_ data: Int) -> Bool {
		return true
	}
}

// 직접 선언 방법

class BinaryTree: BinaryTreeProtocol {
	struct T: Equatable, Comparable {
		var data: Int
		static func ==(lhs: T, rhs: T) -> Bool {return lhs.data == rhs.data}
		
	}
}

```