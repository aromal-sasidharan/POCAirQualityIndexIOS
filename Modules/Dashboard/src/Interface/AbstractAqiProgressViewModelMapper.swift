//
//  AbstractAqiProgressViewModelMapper.swift
//  Dashboard
//
//  Created by Leo on 4/10/21.
//

import Foundation
import CleanBreezeDomain
protocol AbstractAqiProgressViewModelMapper {
    func map(entity: AbstractAqiEntity) -> AbstractAqiProgressViewModel?
    func mapAll(_ items: [AbstractAqiEntity]) -> [AbstractAqiProgressViewModel]
}
