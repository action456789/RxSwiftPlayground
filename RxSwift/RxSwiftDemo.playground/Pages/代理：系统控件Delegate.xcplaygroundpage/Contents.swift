//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import RxSwift
import RxCocoa

class VC: UIViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.bounds.size.width
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 100, width: width, height: 200))
        scrollView.contentSize = CGSize(width: width, height: 2000)
        scrollView.showsVerticalScrollIndicator = true
        scrollView.backgroundColor = UIColor.cyan
        view.addSubview(scrollView)
        
        scrollView.rx
            .contentOffset
            .subscribe(onNext: { (contentOffset) in
                print(contentOffset)
            })
            .disposed(by: disposeBag)
        
    }
}

let vc = VC()
PlaygroundPage.current.liveView = vc
