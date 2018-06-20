//: Playground - noun: a place where people can play

import UIKit

let array = [0, 1, 2, 3, 4, 5, 6]

test("集合遍历 forEach") {
    //使用switch遍历
    array.forEach {
        switch $0 {
        case let x where x > 3:   //where相当于判断条件
            print(x)
        default:
            print("默认值")
        }
    }
}

test("集合遍历 for in") {
    for value in array where value > 2 {
        print(value)   //输出3 4 5 6
    }
    
    for (index, value) in array.enumerated() where index > 2 && value > 3 {
        print("下标:\(index), 值：\(value)")
    }
}


enum SomeError: Error {
    case error1(Int)
    case error2(String)
}

func methodError() throws {
    throw SomeError.error1(3)
}

test("在补充异常的do/catch里使用") {
    do {
        try methodError()
    } catch SomeError.error1(let param) where param > 2 { // 捕获异常时判断参数
        print("判断参数的异常: \(param)")
    } catch {
        print("默认异常处理")
    }
}



protocol SomeProtocolA {
    func someProtocolMethodA()
}

class A: SomeProtocolA {
    let a = 1
    
    func someProtocolMethodA() {
        print(a)
    }
}

class B {
    let b = 2
}

// 针对类 A 扩展协议
// 基类A继承了SomeProtocol协议才能添加扩展
// 说人话：如果类A实现了 SomeProtocol 协议，那么可以进行扩展
extension SomeProtocolA where Self: A {
    func showParamA() {
        print(self.a)
    }
}

// 针对类 B 扩展协议
// 反例，不符合where条件
extension SomeProtocolA where Self: B {
    func someProtocolMethodA() {
        print("someMethodProtocolA")
    }
}

test("协议使用where情形一：针对某个类扩展协议（只有基类实现了当前协议才能添加扩展）") {
    // 换个说法， 多个类实现了同一个协议，该语法根据类名分别为这些类添加扩展， 注意是分别(以类名区分)！！！
    
    let objA = A()
    let objB = B()  // 类B没实现SomeProtocol， 所有没有协议方法
    objA.showParamA()  //输出1
}


protocol SomeProtocolB {
    func someProtocolMethodB()
}

// 针对协议 A 扩展协议 B
extension SomeProtocolB where Self: SomeProtocolA {
    func someProtocolMethodB() {
        print("SomeProtocolB")
    }
}

class C: SomeProtocolA & SomeProtocolB {
    func someProtocolMethodA() {
        print(#function)
    }
    
    func someProtocolMethodB() {
        print(#function)
    }
}

test("协议使用where:情形二：只有基类同时遵守了另外一个协议才能添加扩展") {
    let objC = C()
    objC.someProtocolMethodA()
}
