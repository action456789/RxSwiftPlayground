//: [Previous](@previous)

import Foundation
import RxSwift
import RxCocoa

import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

enum HTTPError: Error {
    case invalidURL(String)
    case invalidParameter(String, Any)
    case invalidJSON(String)
    case invalidResponseData
}

struct Zhihu: Codable {
    let followersCount: Int
    let activateState, href: String
    let acceptSubmission, firstTime: Bool
    let nameCanEditUntil: Int
    let reason: String
    let banUntil: Int
    let slug, name, url, intro: String
    let topicsCanEditUntil: Int
    let activateAuthorRequested, commentPermission: String
    let following: Bool
    let postsCount: Int
    let canPost: Bool
}

extension Zhihu: CustomStringConvertible {
    var description: String {
        return "followersCount: " + "\(followersCount)"
    }
}

example("RxSwift进行网络请求") {
    let disposeBag = DisposeBag()
    
    Observable
        .from(["https://zhuanlan.zhihu.com/api/columns/mrpeak"])
        .map { string -> URL in
            return URL(string: string)!
        }
        .map { url -> URLRequest in
            return URLRequest(url: url)
        }
        .flatMap { request -> Observable<Data> in
            return URLSession.shared.rx.data(request: request)
        }
        .map({ (data) -> Zhihu? in
            let decoder = JSONDecoder()
            var zhihu: Zhihu?
            do {
                zhihu = try decoder.decode(Zhihu.self, from: data)
                return zhihu
            } catch {
                throw HTTPError.invalidResponseData
            }
        })
        .subscribe(onNext: { (data) in
            if let zhihu = data {
                print(zhihu)
            }
        }, onError: { (error) in
            print("Data Task Error: \(error)")
        })
        .disposed(by: disposeBag)
}

//: [Next](@next)
