//
//  AbstractAqiViewModelMapper.swift
//  Dashboard
//
//  Created by Leo on 3/10/21.
//

import Foundation
import CleanBreezeDomain

protocol AbstractAqiViewModelMapper {
    func map(entity: AbstractAqiEntity, startTime:  Date?) -> AbstractAqiViewModel?
    func mapAll(_ items: [AbstractAqiEntity], startTime:  Date?) -> [AbstractAqiViewModel]
}
