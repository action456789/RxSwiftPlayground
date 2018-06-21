//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import RxSwift
import RxCocoa

class ViewController1: UIViewController {
    let disposeBag = DisposeBag()
    
    // 代理
    private var _delegate = PublishSubject<String>()
    var delegate: Observable<String> {
        return _delegate.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let btn = UIButton(type: .contactAdd)
        view.addSubview(btn)
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 44)
        
        btn.rx.tap
            .subscribe(onNext: { [weak self] in
                if let `self` = self {
                    self._delegate.onNext("tap")
                }
            })
            .disposed(by: disposeBag)
    }
}

class ViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = ViewController1()
        view.addSubview(vc1.view)
        vc1.view.frame = view.bounds
        self.addChildViewController(vc1)
        
        
        vc1.delegate
            .share()
            .subscribe(onNext: {
                print("vc1代理事件：" + $0)
            })
            .disposed(by: vc1.disposeBag)
        
    }
}

let vc = ViewController2()
PlaygroundPage.current.liveView = vc



