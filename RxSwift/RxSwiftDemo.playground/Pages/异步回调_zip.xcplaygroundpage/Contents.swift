//: [Previous](@previous)

import Foundation

import Foundation
import RxSwift
import RxCocoa

import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

enum Api {
    static func teacher(teacherId: Int) -> Observable<String> {
        let subject = PublishSubject<String>()
        DispatchQueue.global().async {
            sleep(1)
            subject.onNext("teacher: \(teacherId)")
        }
        return subject
    }
    
    static func teacherComments(teacherId: Int) -> Observable<String> {
        let subject = PublishSubject<String>()
        DispatchQueue.global().async {
            sleep(5)
            subject.onNext("teacherComments: \(100)")
        }
        return subject
    }
}

example("等待多个并发任务完成后处理结果") {
    let disposeBag = DisposeBag()
    
    Observable
        .zip([Api.teacher(teacherId: 001), Api.teacherComments(teacherId: 001)])
        .subscribe(onNext: { (dataArray) in
            print("获取老师信息成功: \(dataArray[0])")
            print("获取老师评论成功: \(dataArray[1]) 条")
        }, onError: { (error) in
            print("获取老师信息或评论失败: \(error)")
        })
//        .disposed(by: disposeBag)
}

