//
//  CBError.swift
//  CleanBreezeDomain
//
//  Created by Leo on 2/10/21.
//

import Foundation

//CleanBreeze Errors
public enum CBError: Error {
    case noDataFound
    case parsingError
    case networkError(error: Error)
}
