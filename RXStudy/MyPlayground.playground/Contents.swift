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
  func main() {
    a()
    b()
  }
}
B().main()
