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

extension Position {
  
}

class ViewController: UIViewController {
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
  
  
  var shownCities: [String] = []
  let allCities: [String] = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Praga"]
  let disposeBag = DisposeBag() // 뷰가 할당 해제될 때 놓아줄 수 있는 일회용품의 가방
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print(API.getDetail(id: 32).url)
    print(API.getList.url)
    print(3.double)
    print(3.times(5))
    tableView.dataSource = self
    searchBar
      .rx.text // RxCocoa의 Observable 속성
      .orEmpty // 옵셔널이 아니도록 만드는것
      .debounce(0.5, scheduler: MainScheduler.instance) // 0.5초 기다립니다.
      .distinctUntilChanged() // 새로운 값이 이전의 값과 같은지 확인합니다.
      .filter {!$0.isEmpty} // 새로운 값이 정말 새롭다면, 비어있지 않은 쿼리를 위해 필터링합니다.
      .subscribe(onNext: { [unowned self] query in // 이 부분 덕분에 모든 새로운 값에 대한 알림을 받을 수 있습니다.
        self.shownCities = self.allCities.filter {$0.hasPrefix(query)} // 도시를 찾기 위한 "API 요청" 작업을 합니다.
        self.tableView.reloadData() // 테이블 뷰를 다시 불러옴
      })
      .addDisposableTo(disposeBag)
  }
}


extension Int {
  var double: Int {
    return self * 2
  }
  func times(_ time: Int) -> Int {
    return self * time
  }
}

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
