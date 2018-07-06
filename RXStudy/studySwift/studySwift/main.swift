//
//  main.swift
//  studySwift
//
//  Created by 배지호 on 2018. 6. 21..
//  Copyright © 2018년 baejiho. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

//먼저 문법에 대해서 알아보자
//struct
//struct는 값타입이기때문에 값이 복사가 된다.
//해당 struct 인스턴스를 생성했을때 값이 복사가 된다.

//struct A {
//  var name: String = "BaeJiHo"//가변 프로퍼티 (내부 값이 변경이 가능하다.)
//  let age: Int = 28           //불변 프로퍼티 (내부값이 정해져있기 때문에 변경이 불가능하다.)
//
//  static var address: String = "서울시 중랑구" //타입 프로퍼티 (인스턴스를 생성하지않아도 바로 접근해서 사용이 가능하다.)
//
//  func myName() {
//    print("my name is jiho")
//  }
//
//  static func myNameAndAge() {
//    print("my name is jiho And Age 28")
//  }
//}
//
//var B: A = A()

//print(B.name)
//print(B.age)
//print(B.myName())
//print(A.address)
//print(A.myNameAndAge())

//class
//class는 struct와 거의 동일하기 때문에 글로만 작성한다.
//class는 참조타입이기때문에 직접적인 주소값이 주어진다.
//해당 class의 인스턴스를 생성한뒤에 내부에 선언된 프로퍼티값을 변경했을 시 변경이 가능하다.


////클로저
//
//let sum: (Int, Int) -> Int = {(a:Int, b:Int) -> Int in
//  return a + b
//}
//let sumResult = sum(10, 99)
//print(sumResult)
//
////함수의 전달인자로서의 클로저
////- 클로저는 주로 함수의 전달인자로 많이 사용된다.
////- 함수 내부에서 원하는 코드블럭을 실행 할 수 있다.
//
//let add: (Int, Int) -> Int
//add = {(a:Int, b: Int) -> Int in
//  return a + b
//}
//let sumAdd = add(10,20)
//print(sumAdd)
//
//let substract: (Int, Int) -> Int
//substract = {(a: Int, b: Int) in
//  return a - b
//}
//
//let minor = substract(10,20)
//print(minor)
//
//func calculate(a: Int, b: Int, method: (Int, Int) -> Int) -> Int {
//  return method(a, b)
//}
//
//var calculated: Int
//
//calculated = calculate(a: 10, b: 20, method: add) // method의 타입은 (Int, Int) -> Int 이며,
//                                                  // 상단의 add의 타입도 동일하기에 add를 넣을 수 있고
//                                                  // add에서 연산 처리 완료
//
//print(calculated) // 30
//
//calculated = calculate(a: 20, b: 100, method: substract)
//print(calculated) // -80
//
////따로 클롲를 상수,변수에 넣어 전달하지 않고,
////함수를 호출할 때 클롲를 작성하여 전달할 수도 있다.
//
//calculated = calculate(a: 50, b: 20) { $0 * $1 } //a의 인자값이 left($0)로 들어가게 되고 b의 인자값이 right($1)로 들어가게 된다.
//
//print(calculated)

//Property

//struct Student {
//
//  //인스턴스 저장 프로퍼티
//  var name: String = ""
//  var `class`: String = "Swift"
//  var koreaAge: Int = 0
//
//
//  //인스턴스 연산 프로퍼티
//  var westernAge: Int {
//    get {
//      return koreaAge - 1
//    }
//    set {
//      koreaAge = newValue + 1
//    }
//  }

//타입 저장 프로퍼티
//  static var typeDescription: String = "학생"
/*
 //인스턴스 메서드
 func selfIntroduce() {
 print("저는 \(self.class)반 \(name)입니다.")
 }
 */

//읽기전용 인스턴스 연산 프로퍼티
//간단히 위의 selfIntroduce() 메서드를 대체할 수 있다.

//  var selfIntroducion: String {
//    get {
//      return "저는 \(self.class)반 \(name)입니다."
//    }
//  }
/*
 // 타입 메서드
 static func selfIntroduce() {
 print("학생타입입니다.")
 }
 */

// 읽기전용 타입 연산 프로퍼티
// 읽기전용에서는 get을 생략할 수 있습니다.

//  static var selfIntruectional: String {
//    return "학생타입입니다."
//  }
//}
//
//print(Student.selfIntruectional)
//var result: Student = Student()
//result.westernAge = 20
//print(result.westernAge)

//프로퍼티 응용

//struct Money {
//  var currencyRate: Double = 1100
//  var dollar: Double = 0
//  var won: Double {
//    get {
//      return dollar * currencyRate
//    }
//    set {
//      dollar = newValue / currencyRate
//    }
//  }
//}
//
//var myMoney = Money()
//
//myMoney.currencyRate = 1120
//myMoney.won = 30000
//
//print(myMoney.dollar)
//
//
//struct RealMoney {
//  var rate: Double = 1100.0 {
//    willSet {
//      print("\(newValue)")
//    }
//    didSet {
//      print("\(oldValue)")
//    }
//  }
//  var dollar: Double = 0 {
//    willSet {
//      print("\(newValue)")
//    }
//    didSet {
//      print("\(oldValue)")
//    }
//  }
//  var won: Double {
//    get {
//      return dollar * rate
//    }
//    set {
//      dollar = newValue / rate
//    }
//  }
//}
//
//var rMoney: RealMoney = RealMoney()
//print("바뀌기전rMoney.rate: \(rMoney.rate)")
//rMoney.rate = 1500
//print("바뀌고 나서\(rMoney.rate)")
//print(rMoney.dollar)
//rMoney.dollar = 200
//print(rMoney.dollar)
//print(rMoney.won)

//map, filter, flatmap, reduce

//let numbers: [Int] = [0,1,2,3,4]
//var strings: [String] = []
//var filtered: [Int] = []
//
//strings = numbers.map({ (items: Int) -> String in
//  let st = (items % 2 == 0)
//  return "\(st)"
//})
//let stringArray: [String] = ["good","http://google.com","http://agit.io","some words"]
//
//let hosts = stringArray.flatMap { (string: String) -> String? in
//  return URL(string: string)?.host
//}
//print(hosts)
//
//let sum = numbers.reduce(0) { (first: Int, second: Int) -> Int in
//  print("first: \(first)")
//  print("second: \(second)")
//  return first + second
//}
//print(sum)
//strings = numbers.map {$0,String}

//print(strings)
//
//filtered = numbers.filter({ (items: Int) -> Bool in
//  return items % 2 == 0
//})
//
//print(filtered)

//지그재그 코딩테스트
//let string = "ab2v9bc13j5jf4jv21"
//
//let numberArray = (try NSRegularExpression(pattern: "[0-9]+")
//  .matches(in: string, range: NSRange(string.startIndex..., in: string))
//  .flatMap { Range($0.range, in: string)}
//  .map { String(string[$0])}) ?? []
//print(numberArray)
//let r = numberArray
//  .flatMap { (number: String) -> Int? in
//    print("number: \(Int(number)!)")
//  return Int(number)
//  }
//  .filter { (value: Int) -> Bool in
//    print("value:\(Int(value))")
//    return value % 2 != 0
//  }
//  .map { $0 * $0 }
//  .reduce(0, +)
//
//print(r)

//
//public enum Event<Element> {
//  case next(Element)
//  case error(Error)
//  case completed
//}

protocol ObserverType {
  associatedtype E
  func on(_ event: Event<E>)
}

//Observable<Int>
//  .create { (observer) -> Disposable in
//    observer.on(Event.next(1))
//    observer.on(Event.next(2))
//    observer.on(Event.next(3))
//  return Disposables.create()
//  }.subscribe ({ (event: Event<Int>) in
//    switch event {
//    case let .next(element):
//      print("element: \(element)")
//    case let .error(error):
//      print("error: \(error.localizedDescription)")
//    case let .completed:
//      print("completed")
//    }
//}).dispose()

// Dispose
// 처분하다.
// dispose() 함수: 즉시 처분
// disposeBag: Disposable들을 모아놨다가 한번에 처분

// Observable 생성방법
// - just
// - from
// - of
// - empty
// - never
// - error
// - create
// - repeatElement
// - interval

// Observable 생성 -just
// Element 1개를 Emit 한다.
let disposseBag = DisposeBag()

Observable<Int>.just(1).subscribe { (event: Event) in
  switch event {
  case let .next(element):
    print("\(element)")
  case let .error(error):
    print("\(error.localizedDescription)")
  case .completed:
    print("completed")
  }
  }.disposed(by: disposseBag)

//Observable 생성 - subscribe
//Subscribe 미리 지정
let subscribe: (Event<Int>) -> Void = {(event: Event) in
  switch event {
  case let .next(element):
    print("\(element)")
  case let .error(error):
    print("\(error.localizedDescription)")
  case .completed:
    print("completed")
  }
}

//Observable 생성 - from
//Element를 Array로 보내고 하나씩 Emit한다.
let to = Observable.from([1,2,3,4,5])
  .subscribe(subscribe)
  .disposed(by: disposseBag)

print(to)
////Observable 생성 - of
////Emit할 Element 들을 함수 인자로 기입
//Observable.of(1,2,3,4,5)
//  .subscribe(subscribe)
//  .disposed(by: disposseBag)
//
////Observable 생성 - empty
////아무 Element를 보내지 않음. complete는 보냄
//Observable<Int>
//  .empty()
//  .subscribe(subscribe)
//  .disposed(by: disposseBag)
//
////Observable 생성 - never
////아무 Event를 보내지 않음
//Observable
//  .never()
//  .subscribe(subscribe)
//  .disposed(by: disposseBag)
//
////Observable 생성 - error
////Error Event를 1개 Emit 한다.
//Observable<Int>
//  .error(RxError.unknown)
//  .subscribe(subscribe)
//  .disposed(by: disposseBag)
//
////Observable 생성 - create
////Observer에 직접 Event를 Emit한다.
//Observable<Int>
//  .create { (anyObserver: AnyObserver<Int>) -> Disposable in
//    anyObserver.on(Event.next(1))
//    anyObserver.on(Event.next(2))
//    anyObserver.on(Event.next(3))
//    anyObserver.on(Event.next(4))
//    anyObserver.on(Event.next(5))
//    anyObserver.on(Event.completed)
//    return Disposables.create {
//      print("dispose")
//    }
//  }
//  .subscribe(subscribe)
//  .disposed(by: disposseBag)
//
////Observable 생성 -repeatElement
////지정된 element를 계속 Emit 한다.
//Observable<Int>
//  .repeatElement(3)
//  .take(10)
//  .subscribe(subscribe)
//  .disposed(by: disposseBag)
//
////Observable 생성 - interval
////지정된 시간에 한번씩 Event를 Emit
//Observable<Int>
//  .interval(0.5, scheduler: MainScheduler.instance)
//  .take(20).subscribe(subscribe)
//  .disposed(by: disposseBag)
//
//
//
//
//
//
//
//
//
