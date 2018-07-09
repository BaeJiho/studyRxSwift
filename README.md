# RXSwift


- 테스트하기 어려운 Notification 대신에, 신호(Signal)를 사용할 수 있습니다. 많은 코드를 작성해야하는 delegate 대신에, 블록을 작성해서 switch 와 if를 삭제할 수 있습니다. RxSwift에서는 쉽게 조종할 수 있는 KVO, IBAction, 입력 필터, MVVM 그리고 더 많은 것이 포함되어 있습니다.

### - 정의
- 예) 스마트폰은 관찰이 가능(observable)합니다. 스마트폰은 페이스북 알림이나 메세지, 스냅챗 알림 등과 같이 신호(signal)를 방출합니다. 우리는 자연적으로 스마트폰을 구독(subscribe)하고 있고, 모든 알림을 홈 스크린에서 확인 할 수 있습니다. 이제 그 신호(signal)로 무엇을 할 지 정할 수 있습니다. 우리는 관찰자(observer)입니다.
- RxSwift는 관찰 가능한 시퀀스와 함수 스타일 연산자를 사용하여 비동기 및 이벤트 기반 코드를 작성하고 스케줄러를 통해 매개 변수화 된 실행을 허용하는 라이브러리입니다.


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

##Observable

Observable이란 하나의 sequence라고 보면 되며, 3가지의 이벤트를 방출 할 수있다.
(관찰자가 수신 할 수 있다.)

- next
- error
- completed

##Operators

Observable Type과 Observable 클래스의 구현에는 훨씬 복잡한 논리를 구현하기 위해 함께 구성 할 수 있는 비동기 작업을 추상화하는 많은 메서드가 포함되어있음.</br>

##Schedulers

---

##Subject

Rx에서 Subject는 Observable과 Observer 둘 다 될 수 있는 특별한 형태. Subject는 Observables를 subscribe(구독) 할 수 있고 다시 emit(방출) 할 수 도 있다. 혹은 새로운 Observable을 emit 할 수 있다.

RxSwift에서 4가지 타입의 Subject가 있다.

- PublishSubject
- BehaviorSubject
- ReplaySubject
- Variable

###PublishSubject

onNext() 함수로 새로운 값을 추가할 수 있다.

```
let subscrib: (Event<String>) -> Void = {(event: Event) in
      switch event {
      case let .next(element):
        print("\(element)")
      case let .error(error):
        print("\(error.localizedDescription)")
      case .completed:
        print("completed")
      default:
        print("default")
      }
    }
    
    let disposeBag = DisposeBag()
    
    var publishSubject = PublishSubject<String>()
    publishSubject.subscribe(subscrib)
    publishSubject.onNext("test")


-------------------
print 부분
- test
- completed

```

###BehaviorSubject

BehaviorSubject는 PublishSubject와 거의 같지만 BehaviorSubject는 반드시 값으로 초기화를 해줘야 합니다. 즉 BehaviorSubject는 Observer에게 subscribe 하기 전 마지막 이벤트 혹은 초기값을 emit합니다.

```
var behaviorSubject = BehaviorSubject(value: "initial Value")
    behaviorSubject.subscribe(subscrib)
    behaviorSubject.onNext("first Value")
    behaviorSubject.onCompleted()
    
----------------
print 부분
- initial Value
- first Value
- completed
```


###ReplaySubject

ReplaySubject는 정해진 사이즈 만큼 가장 최근의 이벤트를 새로운 Subscriber에게 전달한다.


###Creating Observables

- Create

```
func myJust<E>(element: E) -> Observable<E> {
      return Observable.create { observer -> Disposable in
        observer.on(.next(element))
        observer.on(.completed)
        return Disposables.create()
      }
    }
    myJust(element: 10).subscribe(onNext: { n in
      print(n)
    })
    
---------------
print 부분
- 10
```

- Defer

defer는 observer가 subscribe 할 때까지 기다리며, subscribe하면 그때 Observable을 생성합니다. defer(미루다) subscribe 할 때 까지 Observable 생성을 미룹니다.

```
var count = 1
    
    let deferredSequence = Observable<String>.deferred {
      print("\(count)번째")
      count += 1
      
      return Observable.create({ (observer) -> Disposable in
        print("Emitting...")
        observer.onNext("여기")
        return Disposables.create()
      })
    }
    deferredSequence.subscribe(onNext: {print($0)}).disposed(by: disposeBag)
    deferredSequence.subscribe(onNext: {print($0)}).disposed(by: disposeBag)
    
---------------
print부분

- 1번째
- Emitting...
- 여기
- 2번째
- Emitting...
- 여기
```

- From
from은 자료구조화 된 데이터 타입들 Array, Dictionary들을 Observable로 만들 때 사용 할 수 있다.

```
let arrayType = ["첫번째","두번째","세번째","네번째","다섯번째","여섯번째"]
    
    Observable
      .from(arrayType)
      .subscribe(onNext: {print($0)})
      .disposed(by: disposeBag)
      
-------------------
print 부분

- 첫번째
- 두번째
- 세번째
- 네번째
- 다섯번째
- 여섯번째
```

- Of

Of는 같은 타입의 여러개의 element들을 observable로 만들 수 있다.
From과 거의 비슷하지만 다른점이 있다. From은 데이터 ㅓ타입과 자료구조들만 가능하고 Of는 같은 타입의 여러개를 Parameter로 받을 수 있다.

// func of(_ elements: E ...) // 구현부분

- Interval

Integer 를 정해진 time interval마다 Emit합니다.

- Just

가장 간단하게 Observable을 만들수 있다.</br>
한개나 여러개의 객체들을 Observable로 만들 수 있다.</br>

```
Observable
      .just(1)
      .subscribe(onNext:{print($0)})
      .disposed(by: disposeBag)
    
--------
- 1
- completed
```

- Range

정해진 Range에 따른 Integer를 방출합니다.

```
Observable
      .range(start: 1, count: 3)
      .subscribe(onNext:{print($0)})
      .disposed(by: disposeBag)

--------
print부분

- 1
- 2
- 3
- completed
```

- Generate

generate는 parameter로 C 타입 for문이 들어갈 수 있다.</br>
ex) for ( int i = 0; i < 3; i++) {} </br>

```
Observable
      .generate(initialState: 0, condition: {$0 < 3}, iterate: {$0 + 1})
      .subscribe(onNext:{print($0)})
      .disposed(by: disposeBag)
-------------
print 부분
- 1
- 2
- 3
- 
```

- doOn

doOn은 Observer가 구독하기 전에 핸들링 할 수 있습니다.

```

```
