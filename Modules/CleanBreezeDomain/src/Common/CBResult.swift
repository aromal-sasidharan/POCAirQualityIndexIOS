//
//  CBResult.swift
//  CleanBreezeDomain
//
//  Created by Leo on 2/10/21.
//

import Foundation
public typealias CBResult<T> = Result<T, CBError>
public typealias CBResultCompletion<T> = ((CBResult<T>) -> Void)
// MARK: - Internal APIs

public extension CBResult {
    /// Returns the associated value if the result is a success, `nil` otherwise.
    var success: Success? {
        guard case .success(let value) = self else { return nil }
        return value
    }
    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    var failure: Failure? {
        guard case .failure(let error) = self else { return nil }
        return error
    }
    /// Initializes an `PNResult` from value or error. Returns `.failure` if the error is non-nil, `.success` otherwise.
    ///
    /// - Parameters:
    ///   - value: A value.
    ///   - error: An `Error`.
    init(value: Success, error: Failure?) {
        if let error = error {
            self = .failure(error)
        } else {
            self = .success(value)
        }
    }
}
