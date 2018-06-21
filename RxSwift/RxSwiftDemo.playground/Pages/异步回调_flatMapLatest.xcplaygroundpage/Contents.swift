//: [Previous](@previous)

import Foundation
import Foundation
import RxSwift
import RxCocoa

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

enum HTTPError: Error {
    case passwordError
}

enum Api {
    static func token(username: String, password: String) -> Observable<String> {
        let subject = PublishSubject<String>()
        DispatchQueue.global().async {
            sleep(5)
            print("获取Token...")
            subject.onNext("token:\(username)")
        }
        return subject
    }
    
    static func userInfo(token: String) -> Observable<String> {
        let subject = PublishSubject<String>()
        DispatchQueue.global().async {
            sleep(1)
            print("开始获取用户信息...")
            if token == "token:kk" {
                subject.onNext("成功")
            } else {
                subject.onError(HTTPError.passwordError)
            }
        }
        return subject
    }
}

example("多个任务之间有依赖关系") {
    Api.token(username: "kk", password: "123456")
        .flatMapLatest(Api.userInfo)
        .subscribe(onNext: { message in
            print(message)
        }, onError: { error in
            print("获取用户信息失败: \(error)")
        })
//        .disposed(by: disposeBag)
}
