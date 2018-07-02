//: Playground - noun: a place where people can play

import UIKit
import Foundation


//
//protocol A {
//  func a()
//}
//
//extension A {
//  func a() {
//    print("protocol A a()")
//    b()
//  }
//  func b() {
//    print("protocol A b()")
//  }
//}
//
//class B: A {
//  func main() {
//    a()
//    b()
//  }
//}
//B().main()

//protocol BinaryTreeProtocol {
//  associatedtype T: Equatable, Comparable
//  func hasData(_ data: T) -> Bool
//}
//
////Typealias방법
//class BinaryTree: BinaryTreeProtocol {
//  typealias T = Int
//  static let leaf: BinaryTree = BinaryTree(left: nil, right: nil, data: nil)
//  var left: BinaryTree?
//  var right: BinaryTree?
//  var data: T?
//
//  init(left: BinaryTree? = BinaryTree.leaf, right: BinaryTree? = BinaryTree.leaf, data: T?) {
//    self.left = left
//    self.right = right
//    self.data = data
//  }
//  func hasData(_ data: Int) -> Bool {
//    return true
//  }
//}

//Closure
//
//let double: (Int) -> Int = { value in
//  return value * 2
//}
//
//double(2)
//
//let multiply: (Int, Int) -> Int = { value1, value2 in
//  return value1 * value2
//}
//
//multiply(3, 9)
//
//let addition: (Int, Int) -> Int = { value1, value2 in
//  return value1 + value2
//}
//
//addition(2, 10)
//
//func printResultByMutableOperator(value1: Int, value2: Int, operator mutableOperator: (Int, Int) -> Int) {
//  print("result: \(mutableOperator(value1, value2))")
//}
//
//printResultByMutableOperator(value1: 3, value2: 5, operator: addition)
//printResultByMutableOperator(value1: 3, value2: 5, operator: multiply)
//printResultByMutableOperator(value1: 3, value2: 5) { (value1, value2) -> Int in
//  return (value1 + value2) * value2 / value1
//}
//
//let tuple: (Int, Int) = (3, 6)
//let (a, b) = tuple
//a
//b
//tuple.0
//tuple.1
//
//let namedTuple: (first: Int, second: Int) = (3, 6)
//
//namedTuple.first
//namedTuple.second
//
//func getBodyInfo(person: [String: Any]) -> (height: Int, weight: Int, isAlive: Bool) {
//  return (170, 70, true)
//}
//
//getBodyInfo(person: [:]).height
//
//let manyValues: (Int, Int, Int, Int) = (1,2,3,4)
//manyValues.2

//Map, FlatMap, Filter

//let array = [0,1,2,3,4,5,6,7]
//
//array.map { (item: Int) -> String in
//  "\(item * 10)"
//}
//
//array.map { (item: Int) -> Bool in
//  item % 2 == 0
//}
//
//array.filter { (item: Int) -> Bool in
//  item % 2 == 0
//}
//
//let stringArray = ["good","http://google.com","http://agit.io","some words"]
//let hosts = stringArray.flatMap { (string: String) -> String? in
//  return URL(string: string)?.host
//}

//
//
//
//
//let string = "ab2v9bc13j5jf4jv21"
//let numberArray = (try? NSRegularExpression(pattern: "[0-9]+")
//  .matches(in: string, range: NSRange(string.startIndex..., in: string))
//  .flatMap { Range($0.range, in: string) }//
//  .map { String(string[$0]) }) ?? [""]
//let r = numberArray// 홀수 구분 없이 패턴에 맞는 문자열 배열들의 모음 문자열 == String, 이 문자열들의 배열
//  .flatMap{ (number: String) -> Int? in
//    return Int(number)// 정수형이 되면서
//  }.filter { (value: Int) -> Bool in
//    return value % 2 != 0// 짝수인 애들의
//  }.map { $0 * $0 }// 자승을 리턴하는데
//  .reduce(0, +)// 0 부터 시작하는데 같이 들어간 오퍼레이터를 적용한 반복문
//print(r)

//
//let numbers: [Int] = [0,1,2,3,4]
//var doubledNumbers: [Int] = []
//var strings: [String] = []
//var filtered: [Int] = []
//
//for number in numbers {
//  doubledNumbers.append(number)
//  strings.append("\(number)")
//}
//
//print(doubledNumbers)
//print(strings)
//
//doubledNumbers = numbers.map({ (number: Int) -> Int in
//  return number
//})
//
//strings = numbers.map({ (number: Int) -> String in
//  return "\(number)"
//})
//
//filtered = numbers.filter({ (items: Int) -> Bool in
//  return items % 2 == 0
//})

//MARK: - Boxing
//public struct Some<Base> {
//  let base: Base
//  init(_ base: Base) {
//    self.base = base
//  }
//}
//protocol BoxCompatible {
//  associatedtype CompatibleType
//  var box: Some<CompatibleType> { get set}
//  static var box: Some<CompatibleType>.Type { get set }
//}
//
//extension BoxCompatible {
//  var box: Some<Self> {
//    get { return Some(self) }
//    set { }
//  }
//  static var box: Some<Self>.Type {
//    get { return Some<Self>.self }
//    set { }
//  }
//}
//
//class A {}
//extension A: BoxCompatible {}
//
//class B {}
//extension B: BoxCompatible {}
//
//extension Some where Base: A {
//  var description: String {
//    return "A.box.description"
//  }
//
//  static var className: String {
//    return "A"
//  }
//}
//
//extension Some where Base: B {
//  var someBoxingValue: Int {
//    return 10
//  }
//  static var classValue: Int {
//    return 20
//  }
//}
//
//let a = A()
//a.box.description
//A.box.className
//
//let b = B()
//b.box.someBoxingValue
//B.box.classValue
//
//class Test: BoxCompatible {
//  var value: Int
//
//  init(value: Int) {
//    self.value = value
//  }
//}
//
//extension Some where Base == Test {
//  var result: Int {
//    return base.value
//  }
//  func add(value: Int) {
//    base.value += value
//  }
//}
//
//let test = Test(value: 10)
//print(test.box.result)
//test.box.add(value: 10)
//print(test.box.result)

//Boxing
// 확장의 방법
// - 상속: 기능을 덧붙이는건 아님.
//        상위 클래스를 사용하고 있는 다른 모든것에 영향을 끼칠 수 가 없음
// - Extension: 기능을 덧붙임
// - Boxing: 기존의 기능, 프로퍼ㅓ티와 내가 확장하고자 하는것을 분리하는 확장
// RxSwift에서 매우 많이 사용한다.

public struct Some<Base> {
  let base: Base
  init(_ base: Base) {
    self.base = base
  }
}

protocol BoxCompatible {
  associatedtype Compatible
  var box: Some<Compatible> { get set }
  static var box: Some<Compatible>.Type { get set }
}

extension BoxCompatible {
  var box: Some<Self> {
    get { return Some(self) }
    set { }
  }
  static var box: Some<Self>.Type {
    get { return Some<Self>.self }
    set { }
  }
}

class Box: BoxCompatible {}

extension Some where Base == Box {
  var desciption: String {
    return "이렇게?ㅜㅜ"
  }
}

let a = Box()

a.box.desciption








