//
//  AbstractDashboardInteractor.swift
//  Dashboard
//
//  Created by Leo on 2/10/21.
//

import Foundation
import CleanBreezeDomain
import Combine

public protocol AbstractDashboardInteractor {
    func loadAqi() -> AnyPublisher<[AbstractAqiEntity], Never>
    func loadAqiFor(city: String) -> AnyPublisher<[AbstractAqiEntity], Never>
}
