//: [Previous](@previous)

import RxSwift

example("Observable") {
    Observable
        .of("🐔", "🍎", "🌰", "🍑", "✈️", "小明", "小黑", "小白")
        .filter { $0.hasPrefix("小")}
        .map { return "名字: " + $0 }
        .subscribe(onNext: { (s) in
            print(s)
        })
        .dispose()
}

