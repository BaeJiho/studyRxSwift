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
    behaviorSubject.onCompleted()
    
    
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
    
    //    Observable<Int>.create { (observer) -> Disposable in
    //      //observable이 이벤트로 방출할 Emit을 생성
    //      observer.on(Event.next(1))
    //      observer.on(Event.next(2))
    //      observer.on(Event.next(3))
    //      observer.onCompleted()
    //      return Disposables.create()
    //    }
    //    //      .subscribe(subscrib).disposed(by: disposeBag)
    
    var replaySubject = ReplaySubject<String>.create(bufferSize: 1)
    replaySubject.onNext("이벤트 첫번째")
    replaySubject.onNext("이벤트 두번째")
    replaySubject.subscribe(subscrib)
    replaySubject.onNext("first event")
    replaySubject.onCompleted()
    
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
    
    let arrayType = ["첫번째","두번째","세번째","네번째","다섯번째","여섯번째"]
    
    Observable
      .from(arrayType)
      .subscribe(onNext: {print($0)})
      .disposed(by: disposeBag)
    
    Observable
      .just(1)
      .subscribe(onNext:{print($0)})
      .disposed(by: disposeBag)
    
    Observable
      .range(start: 1, count: 3)
      .subscribe(onNext:{print($0)})
      .disposed(by: disposeBag)
    
    Observable
      .generate(initialState: 0, condition: {$0 < 3}, iterate: {$0 + 1})
      .subscribe(onNext:{print($0)})
      .disposed(by: disposeBag)
    
//    Observable
//      .repeatElement("toto")
//      .subscribe(onNext: {print($0)})
//      .disposed(by: disposeBag)
    
    Observable
      .of("1","2","3","4","5","6")
      .do(onNext: { print("Intercepted:",$0)},
          onError: { print("error:",$0)},
          onCompleted: { print("Completed")})
      .subscribe(onNext: {print($0)})
      .disposed(by: disposeBag)
    
  }
}

