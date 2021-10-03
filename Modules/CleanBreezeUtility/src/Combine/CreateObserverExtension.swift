//
//  CreateObserverExtension.swift
//  CleanBreezeDomain
//
//  Created by Leo on 3/10/21.
//

import Foundation
import Combine

public struct AnyObserver<Output, Failure: Error> {
    public let onNext: ((Output) -> Void)
    public let onError: ((Failure) -> Void)
    public let onComplete: (() -> Void)
    public init(onNext: @escaping ((Output) -> Void),
         onError: @escaping ((Failure) -> Void),
         onComplete: @escaping (() -> Void)
         ) {
        self.onNext = onNext
        self.onError = onError
        self.onComplete = onComplete
    }
}

public struct Disposable {
    public init(dispose: @escaping (() -> Void) ) {
        self.dispose = dispose
    }
    public let dispose: () -> Void
}

public extension AnyPublisher {
    static func create(subscribe: @escaping (AnyObserver<Output, Failure>) -> Disposable) -> Self {
        let subject = PassthroughSubject<Output, Failure>()
        var disposable: Disposable?
        return subject
            .handleEvents(receiveSubscription: { subscription in
                disposable = subscribe(AnyObserver(
                    onNext: { output in subject.send(output) },
                    onError: { failure in subject.send(completion: .failure(failure)) },
                    onComplete: { subject.send(completion: .finished) }
                ))
            }, receiveCancel: { disposable?.dispose() })
            .eraseToAnyPublisher()
    }
}
