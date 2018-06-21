//: [Previous](@previous)

import Foundation
import RxSwift
import RxCocoa

import PlaygroundSupport

// 异步回调，设置Playground不结束
PlaygroundPage.current.needsIndefiniteExecution = true

enum HTTPError: Error {
    case invalidURL(String)
    case invalidParameter(String, Any)
    case invalidJSON(String)
}

class HTTPAPI {
    static let API = "https://eonet.sci.gsfc.nasa.gov/api/v2.1"
    static let categoriesEndpoint = "/categories"
    static let eventsEndpoint = "/events"
    
    static func request(endpoint: String, query: [String: Any] = [:]) -> Observable<[String: Any]> {
        do {
            // 将参数打入 url 中
            guard let url = URL(string: API)?.appendingPathComponent(endpoint),
                var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                    throw HTTPError.invalidURL(endpoint)
            }
            
            components.queryItems = try query.compactMap { (key, value) in
                guard let v = value as? CustomStringConvertible else {
                    throw HTTPError.invalidParameter(key, value)
                }
                return URLQueryItem(name: key, value: v.description)
            }
            
            guard let finalURL = components.url else {
                throw HTTPError.invalidURL(endpoint)
            }
            
            let request = URLRequest(url: finalURL)
            
            // 开始网络请求
            return URLSession.shared.rx
                .response(request: request) // return Observable<(HTTPURLResponse, Data)>
                .map { _, data -> [String: Any] in
                    guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                        let result = jsonObject as? [String: Any] else {
                            throw HTTPError.invalidJSON(finalURL.absoluteString)
                    }
                    print(result)
                    return result
            }
        } catch {
            return Observable.empty() // 创建一个空的Observable， 它含有 0 个事件元素，只发出 .completed 事件
        }
    }
    
    // 请求 https://eonet.sci.gsfc.nasa.gov/api/v2.1/categories 的数据
    static var categories: Observable<[[String: Any]]> = {
        return
            HTTPAPI
                .request(endpoint: HTTPAPI.categoriesEndpoint)
                .map({ data in
                    let categories = data["categories"] as? [[String: Any]] ?? []
                    return categories
                })
                .share(replay: 1)
    }()
    
    static func events(forLast days: Int, closed: Bool) -> Observable<[[String: Any]]> {
        let para: [String: Any] = ["days": NSNumber(value: days),
                                   "status": (closed ? "closed" : "open")]
        return
            HTTPAPI
                .request(endpoint: eventsEndpoint, query:para)
                .map { json in
                    guard let raw = json["events"] as? [[String: Any]] else {
                        throw HTTPError.invalidJSON(eventsEndpoint)
                    }
                    print(json)
                    return raw
                }
    }
}



example("HTTP异步回调") {
//    HTTPAPI
//        .events(forLast: 360, closed: false)
//        .subscribe(onNext: { (data) in
//            print(data)
//        })
//        .dispose()
}

//: [Next](@next)
