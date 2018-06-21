//: [Previous](@previous)

import Foundation

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

enum HTTPError: Error {
    case passwordError
}

enum Api {
    static func token(username: String,
                      password: String,
                      success: @escaping (String) -> Void ,
                      failure: ((Error) -> Void)?) {
        DispatchQueue.global().async {
            sleep(5)
            print("获取Token...")
            success("token:\(username)")
        }
    }
    
    static func userInfo(token: String,
                         success:@escaping (String) -> Void,
                         failure:@escaping (Error) -> Void) {
        DispatchQueue.global().async {
            sleep(1)
            if token == "token:kk" {
                print("开始获取用户信息...")
                success("成功")
            } else {
                failure(HTTPError.passwordError)
            }
        }
    }
}

example("多层嵌套回调") {
    Api.token(username: "kk", password: "123456", success: { (token) in
        Api.userInfo(token: token, success: { (msg) in
            print(msg)
        }, failure: { (error) in
            print("获取用户信息失败: \(error)")
        })
    }, failure: nil)
}
