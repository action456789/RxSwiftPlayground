//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import RxSwift
import RxCocoa

extension Notification.Name {
    public struct User {
        public static let Login = Notification.Name(rawValue: "com.notification.name.task.login")
        public static let Logout = Notification.Name(rawValue: "com.notification.name.task.logout")
    }
}

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        NotificationCenter.default.rx
            .notification(Notification.Name.User.Login)
            .subscribe(onNext: { (notification) in
                print("User Login Event")
            })
            .disposed(by: disposeBag)
    }
}

let vc = ViewController()
PlaygroundPage.current.liveView = vc

NotificationCenter.default.post(name: Notification.Name.User.Login, object: nil)


//: [Next](@next)
