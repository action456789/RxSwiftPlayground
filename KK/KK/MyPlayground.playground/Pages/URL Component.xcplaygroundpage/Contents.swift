//: Playground - noun: a place where people can play

import UIKit

func test(_ name: String, block: ()->Void) {
    print("~~~~~~~~~~~~~~~~~Test 【\(name)】 start ~~~~~~~~~~~~~~~~~")
    block()
}

test("URLComponents") {
    guard let urlComponents = URLComponents.init(string: "http://mobile.hktsc.cc/services/list?appPage=serviceList&brandId=1") else {
        return
    }
    
    if let scheme = urlComponents.scheme {
        print("scheme: \(scheme)")
    }
    
    if let user = urlComponents.user {
        print("user: \(user)")
    }
    
    if let password = urlComponents.password {
        print("password: \(password)")
    }
    
    if let host = urlComponents.host {
        print("host: \(host)")
    }
    
    if let port = urlComponents.port {
        print("port: \(port)")
    }
    
    print("path: \(urlComponents.path)")
    
    if let query = urlComponents.query {
        print("query: \(query)")
    }
    
    if let queryItems = urlComponents.queryItems {
        print("queryItems: \(queryItems)")
        
        for (index, queryItem) in queryItems.enumerated() {
            print("第\(index)个queryItem name:\(queryItem.name)")
            if let value = queryItem.value {
                print("第\(index)个queryItem value:\(value)")
            }
        }
    }
    
}
