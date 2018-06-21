//
//  CircleViewModel.swift
//  RxSwiftTutorial2
//
//  Created by 배지호 on 2018. 6. 20..
//  Copyright © 2018년 baejiho. All rights reserved.
//
import ChameleonFramework
import Foundation
import RxSwift
import RxCocoa

class CircleViewModel {
  var centerVariable = Variable<CGPoint>(.zero)
  var backgroundColorObservable: Observable<UIColor>
  
  init() {
    setup()
  }
  
  func setup() {
    backgroundColorObservable = centerVariable.asObservable()
      .map { center in
        guard let center = center else { return UIColor.flatten(.black)()}
        
        let red: CGFloat = ((center.x + center.y) % 255.0) / 255.0
        let green: CGFloat = 0.0
        let blue: CGFloat = 0.0
        
        return UIColor.flatten(UIColor(red: red, green: green, blue: blue, alpha: 1.0))()
    }
  }
  
}
