//: Playground - noun: a place where people can play

import UIKit

protocol Recordable: CustomStringConvertible {
    var wins: Int {get}
    var losses: Int {get}
    func winningPercent() -> Double
}

protocol Tieable {
    var ties: Int {get set}
}

protocol Prizable {
    func isPrizable() -> Bool
}

// 扩展 Record 协议
extension Recordable {
    // 增加协议默认实现
    var description: String {
        return "Wins: \(wins), Losses: \(losses)"
    }
    
    // 增加计算属性
    var gamePlayed: Int {
        return wins + losses
    }
    
    // 增加方法
    func winningPercent() -> Double {
        return Double(wins) / Double(gamePlayed)
    }
}



// 同时扩展Record协议和Tieable协议（同时遵守了两个协议）
extension Recordable where Self: Tieable {
    var gamePlayed: Int {
        return wins + losses + ties
    }
    
    // 有平局的情况下，需要计算ties
    func winningPercent() -> Double {
        return Double(wins) / Double(gamePlayed)
    }
}


// 篮球
struct BasketballRecord: Recordable, Prizable {
    var wins: Int
    var losses: Int
    
    func isPrizable() -> Bool {
        return wins > 2
    }
}

// 棒球
struct BaseballRecord: Recordable {
    var wins: Int
    var losses: Int
    
    // 覆盖协议中的默认实现
    let gamePlayed: Int = 162
}

// 足球: 存在平局
struct FootballRecord: Recordable, Tieable {
    var wins: Int
    var losses: Int
    
    var ties: Int
}

let basketball = BaseballRecord(wins: 2, losses: 10)
let baseball = BasketballRecord(wins: 10, losses: 5)
let football = FootballRecord(wins: 1, losses: 1, ties: 1)

basketball.gamePlayed
baseball.gamePlayed

football.gamePlayed
football.winningPercent()

func award(one: Prizable & CustomStringConvertible) {
    if one.isPrizable() {
        print(one)
        print("Congratulation")
    }
}

award(one: baseball)

// 单个协议
func top<T: Recordable>(seq: [T]) -> T? {
    return seq.first
}

// 多个协议
func top<T: Recordable & Prizable>(seq: [T]) -> T? {
    return seq.first
}


@objc protocol Animal {
    @objc optional func fly()
}
