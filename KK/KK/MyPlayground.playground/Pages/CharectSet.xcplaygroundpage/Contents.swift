//: ["Go to Next Page"](@next)

import Foundation

test("CharacterSet") {
    let input = "asdfasd你好吗f"
    let set = CharacterSet.init(charactersIn: "~`!@#$%^&*()+=-/;:\"\'{}[]<>^?, ")
    let range = input.rangeOfCharacter(from: set)
    print(range)
}

//: ["Go to Previous Page"](@previous)
