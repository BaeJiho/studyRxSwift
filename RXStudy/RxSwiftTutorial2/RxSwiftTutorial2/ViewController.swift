//
//  ViewController.swift
//  RxSwiftTutorial2
//
//  Created by 배지호 on 2018. 6. 20..
//  Copyright © 2018년 baejiho. All rights reserved.
//

import UIKit
import ChameleonFramework
import RxSwift
import RxCocoa

class ViewController: UIViewController {

  var circleView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  func setup() {
    circleView = UIView(frame: CGRect(origin: view.center, size: CGSize(width: 100, height: 100)))
    circleView.layer.cornerRadius = circleView.frame.width / 2.0
    circleView.center = view.center
    circleView.backgroundColor = .blue
    view.addSubview(circleView)
    
    let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(circleMoved(_:)))
    circleView.addGestureRecognizer(gestureRecognizer)
  }
  
  @objc func circleMoved(_ recognizer: UIPanGestureRecognizer) {
    let location = recognizer.location(in: view)
    UIView.animate(withDuration: 0.1) {
      self.circleView.center = location
    }
  }
}

