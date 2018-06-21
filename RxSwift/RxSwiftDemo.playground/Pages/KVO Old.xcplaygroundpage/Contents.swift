//: [Previous](@previous)

import Foundation

import UIKit
import PlaygroundSupport
import RxSwift
import RxCocoa

import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// 进行KVO的Swift的类，需要在声明的时候增加 @objcMembers 关键字，否则会报错
@objcMembers class OCUser: NSObject {
    // 被观察的属性需要用dynamic修饰
    dynamic var name: String
    
    init(name: String) {
        self.name = name
    }
}

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
//    var user: OCUser!
    var user: OCUser = OCUser(name: "李四")
    
    private var observerContext = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setupBtn()

        user.addObserver(self, forKeyPath: #keyPath(OCUser.name), options: [.new, .initial], context: &observerContext)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &observerContext {
            let newValue = change?[.newKey] as? String
            print("do something with newValue")
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    deinit {
        user.removeObserver(self, forKeyPath: #keyPath(OCUser.name))
    }
    
    private func setupBtn() {
        let btn = UIButton(type: .contactAdd)
        view.addSubview(btn)
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 44)
        
        btn.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.user.name = "哈哈哈哈哈"
            })
            .disposed(by: disposeBag)
    }
}

let vc = ViewController()
PlaygroundPage.current.liveView = vc

//: [Next](@next)
