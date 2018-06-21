//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let btn = UIButton(type: .contactAdd)
        view.addSubview(btn)
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 44)
        
        btn.rx.tap
            .subscribe(onNext: {
                print("button Tapped")
            })
            .disposed(by: disposeBag)
    }
}

let vc = ViewController()
PlaygroundPage.current.liveView = vc
