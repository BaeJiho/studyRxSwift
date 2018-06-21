//: Playground - noun: a place where people can play

import UIKit
import Foundation

//protocol Times {
//  func times(_ times: Int) -> Times
//}
//
//protocol Shakeable: class {
//
//}
//extension Shakeable where Self: UIView {
//  func shake() {
//    let animation = CABasicAnimation(keyPath: "position")
//    animation.duration = 0.05
//    animation.repeatCount = 5
//    animation.autoreverses = true
//    animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4.0, y: self.center.y))
//    animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4.0, y: self.center.y))
//    layer.add(animation, forKey: "position")
//  }
//}
//
//class ShakeableButton: UIButton, Shakeable {
//
//}
//
//protocol Dimmable: class {
//
//}
//
//extension Dimmable where Self: UIView {
//  func dim() {
//    self.alpha = 0.5
//  }
//}
//
//extension UIButton: Dimmable {
//
//}
//
//class ViewController: UIViewController {
//  let shakeButton = ShakeableButton(type: .system)
//  let normalButton = UIButton(type: .system)
//
//  override func loadView() {
//    let view = UIView()
//    view.backgroundColor = .white
//    self.view = view
//    shakeButton.setTitle("shake this button", for: .normal)
//    shakeButton.frame = CGRect(x: 70, y: 200, width: 200, height: 20)
//    shakeButton.addTarget(self, action: #selector(shakeButtonTap), for: .touchUpInside)
//    view.addSubview(shakeButton)
//    normalButton.setTitle("normal button", for: .normal)
//    normalButton.frame = CGRect(x: 70, y: 220, width: 220, height: 20)
//    normalButton.addTarget(self, action: #selector(normalButtonTap), for: .touchUpInside)
//    view.addSubview(normalButton)
//
//  }
//
//  @objc func shakeButtonTap(sender: Any) {
//    shakeButton.shake()
//    shakeButton.dim()
//  }
//
//  @objc func normalButtonTap(sender: Any) {
//    normalButton.dim()
//  }
//}
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

let array = [0,1,2,3,4,5,6,7]

array.map { (item: Int) -> String in
  "\(item * 10)"
}

array.map { (item: Int) -> Bool in
  item % 2 == 0
}

array.filter { (item: Int) -> Bool in
  item % 2 == 0
}

let stringArray = ["good","http://google.com","http://agit.io","some words"]
let hosts = stringArray.flatMap { (string: String) -> String? in
  return URL(string: string)?.host
}





let string = "ab2v9bc13j5jf4jv21"
let numberArray = (try? NSRegularExpression(pattern: "[0-9]+")
  .matches(in: string,
           range: NSRange(string.startIndex..., in: string))
  .flatMap { Range($0.range, in: string) }//
  .map { String(string[$0]) }) ?? []
let r = numberArray// 홀수 구분 없이 패턴에 맞는 문자열 배열들의 모음 문자열 == String, 이 문자열들의 배열
  .flatMap{ (number: String) -> Int? in
    return Int(number)// 정수형이 되면서
  }.filter { (value: Int) -> Bool in
    return value % 2 != 0// 짝수인 애들의
  }.map { $0 * $0 }// 자승을 리턴하는데
  .reduce(0, +)// 0 부터 시작하는데 같이 들어간 오퍼레이터를 적용한 반복문
print(r)




