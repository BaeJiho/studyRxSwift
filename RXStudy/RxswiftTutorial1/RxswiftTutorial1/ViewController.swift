//
//  ViewController.swift
//  RxswiftTutorial1
//
//  Created by 배지호 on 2018. 6. 18..
//  Copyright © 2018년 baejiho. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol Times {
  func times(_ times: Int) -> Times
}

protocol Shakeable: class {
  
}
extension Shakeable where Self: UIView {
  func shake() {
    let animation = CABasicAnimation(keyPath: "position")
    animation.duration = 0.05
    animation.repeatCount = 5
    animation.autoreverses = true
    animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4.0, y: self.center.y))
    animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4.0, y: self.center.y))
    layer.add(animation, forKey: "position")
  }
}

class ShakeableButton: UIButton, Shakeable {
  
}

protocol Dimmable: class {
  
}

extension Dimmable where Self: UIView {
  func dim() {
    self.alpha = 0.5
  }
}

extension UIButton: Dimmable {
  
}
protocol A {
  func a()
}

extension A {
  func a() {
    print("protocol A a()")
    b()
  }
  func b() {
    print("protocol A b()")
  }
}

class B: A {
  func b() {
    print("class B b()")
  }
  func main() {
    a()
    b()
  }
}

extension Int: Times {
  func times(_ times: Int) -> Times {
    return self * times
  }
}

extension String: Times {
  func times(_ times: Int) -> Times {
    return Array(0..<times)
      .map {_ in return self}
      .reduce("", +)
  }
}

extension Times {
  func printSomeThing() {
    print("self value is: \(self)")
  }
}

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
      return "/List\(id)/detail"
    }
  }
  var url: URL? {
    return URL(string: "\(self.host)\(self.path)")
  }
}

struct Position {
  var x: Float
  var y: Float
}

indirect enum BineryTree<T: Comparable & Equatable> {
  case leaf
  case node(left: BineryTree<T>, right: BineryTree<T>, data: T)
}

class ViewController: UIViewController {
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
  var shownCities: [String] = []
  let allCities: [String] = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Praga"]
  let disposeBag = DisposeBag() // 뷰가 할당 해제될 때 놓아줄 수 있는 일회용품의 가방
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let tree: BineryTree<Int> = .node(
    left: .node(left: .node(left: .leaf, right: .leaf, data: 1),
                right: .node(left: .leaf, right: .leaf, data: 3),
                data: 2),
    right: .node(left: .node(left: .leaf, right: .leaf, data: 5),
                 right: .node(left: .leaf, right: .leaf, data: 6),
                data: 6),
    data: 4)
    
    let stringTree: BineryTree<String> = .node(left: .leaf, right: .leaf, data: "1")
    
    let timesArray: [Times] = [27,1,2,3,"www,","Was it a cat i saw"]
    
    timesArray.forEach { (item: Times) in
      print(item.times(3))
    }
    
    
    print(tree.hasData(6))
    print(stringTree.hasData("1"))
    print(API.getDetail(id: 32).url)
    print(API.getList.url)
    print("Why so Serious?".times(3))
    print(3.times(3))
    print(3.printSomeThing())
    
    
    B().main()
    tableView.dataSource = self
    searchBar
      .rx.text // RxCocoa의 Observable 속성
      .orEmpty // 옵셔널이 아니도록 만드는것
      .debounce(0.3, scheduler: MainScheduler.instance) // 0.3초 이후의 이벤트만 아래가 실행 될 수 있게합니다.
      .distinctUntilChanged() // 새로운 값이 이전의 값과 같은지 확인합니다.
      .filter {!$0.isEmpty} // 새로운 값이 정말 새롭다면, 비어있지 않은 쿼리를 위해 필터링합니다.
      .subscribe(onNext: { [unowned self] query in // 이 부분 덕분에 모든 새로운 값에 대한 알림을 받을 수 있습니다.
        self.shownCities = self.allCities.filter {$0.hasPrefix(query)} // 도시를 찾기 위한 "API 요청" 작업을 합니다.
        self.tableView.reloadData() // 테이블 뷰를 다시 불러옴
      })
      .addDisposableTo(disposeBag)
  }
}
extension BineryTree {
  func hasData(_ data: T) -> Bool {
    switch self {
    case .leaf:
      return false
    case let .node(_,_,nodeData) where data == nodeData:
      return true
    case let .node(left,_,nodeData) where data < nodeData:
      return left.hasData(data)
    case let .node(_,right,nodeData) where data > nodeData:
      return right.hasData(data)
    case .node:
      return false
    }
  }
}

//extension Int {
//  var double: Int {
//    return self * 2
//  }
//  func times(_ time: Int) -> Int {
//    return self * time
//  }
//}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shownCities.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = shownCities[indexPath.row]
    return cell
  }
}

