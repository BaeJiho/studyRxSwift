//
//  ViewController.swift
//  ObservableTest
//
//  Created by 배지호 on 2018. 7. 4..
//  Copyright © 2018년 baejiho. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let stringSequence = Observable.just("this is string yo")
    let oddSequence = Observable.from([1, 3, 5, 7, 9])
    let dictSequence = Observable.from([1:"Rx",2:"Swift"])
    
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
    
    var behaviorSubject = BehaviorSubject(value: "initial Value")
    behaviorSubject.subscribe(subscrib)
    behaviorSubject.onNext("first Value")
    
//    stringSequence.subscribe { (event: Event) in
//      switch event {
//      case let .next(element):
//        print("\(element)")
//      case let .error(error):
//        print("\(error.localizedDescription)")
//      case .completed:
//        print("completed")
//      }
//    }.disposed(by: disposeBag)
    
    Observable<Int>.create { (observer) -> Disposable in
      //observable이 이벤트로 방출할 Emit을 생성
      observer.on(Event.next(1))
      observer.on(Event.next(2))
      observer.on(Event.next(3))
      observer.onCompleted()
      return Disposables.create()
    }
    //      .subscribe(subscrib).disposed(by: disposeBag)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

