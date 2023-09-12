//
//  RxSwift+Extensions.swift
//  MovieFlix
//
//  Created by Doni on 13/03/23.
//

import RxSwift

extension ReplaySubject {
    public static func create() -> ReplaySubject<Element> {
        return ReplaySubject<Element>.create(bufferSize: 1)
    }
}

extension Observable {
    
    public func subscribeOnMainDisposed(by disposeBag: DisposeBag, onNext: ((Observable.Element) -> Void)? = nil) {
        subscribe(on: ConcurrentDispatchQueueScheduler(queue: .global(qos: .background)))
        .observe(on: ConcurrentMainScheduler.instance)
        .subscribe(onNext: onNext)
        .disposed(by: disposeBag)
    }
    
    public func subscribeOnMainDisposed(by disposeBag: DisposeBag, onNext: ((Observable.Element) -> Void)? = nil, onError: ((Error) -> Void)? = nil) {
        subscribe(on: ConcurrentDispatchQueueScheduler(queue: .global(qos: .background)))
        .observe(on: ConcurrentMainScheduler.instance)
        .subscribe(onNext: onNext, onError: onError)
        .disposed(by: disposeBag)
    }
}
