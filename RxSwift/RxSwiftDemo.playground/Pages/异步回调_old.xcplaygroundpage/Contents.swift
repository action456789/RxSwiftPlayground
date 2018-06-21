//: [Previous](@previous)

import Foundation
import RxSwift
import RxCocoa

import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

example("网络请求初始做法") {
    let url = URL(string: "https://zhuanlan.zhihu.com/api/columns/mrpeak")!
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
        let data = try? JSONSerialization.jsonObject(with: data!, options: [])
        if let root = data as? [String: Any] {
            print(root)
        }
    })
    task.resume()
}


