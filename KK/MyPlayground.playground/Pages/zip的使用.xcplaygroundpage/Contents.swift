//: Playground - noun: a place where people can play

import UIKit

func test(_ name: String, block: ()->Void) {
    print("~~~~~~~~~~~~~~~~~Test 【\(name)】 start ~~~~~~~~~~~~~~~~~")
    block()
}

test("zip 1") {
    let a = [1, 2, 3, 4, 5]
    let b = ["a", "b", "c", "d"]
    let c = zip(a, b).map { $0 }
    print(c)
}

test("zip 2") {
    let names = ["Apple", "Pear"]
    let prices = [7, 6]
    let dict = Dictionary(uniqueKeysWithValues: zip(names, prices))
    
    let array = ["Apple", "Pear", "Pear", "Orange"]
    let dic = Dictionary(zip(array, repeatElement(1, count: array.count)), uniquingKeysWith: +)
    
    repeatElement(1, count: array.count)
    
    let pairsWithDuplicateKeys = [("a", 1), ("b", 2), ("a", 3), ("b", 4)]
    
    let firstValues = Dictionary(pairsWithDuplicateKeys,
                                 uniquingKeysWith: { (first, _) in first })
    
    // ["b": 2, "a": 1]
    
    let lastValues = Dictionary(pairsWithDuplicateKeys,
                                uniquingKeysWith: { (_, last) in last })
    
    let entrys = [35, 30, 18, 22, 20, 15].enumerated().map { (arg) -> String in
        return String(arg.offset) + ": " + String(arg.element)
    }
}






