//
//  AbstractDashboardPresenter.swift
//  Dashboard
//
//  Created by Leo on 2/10/21.
//

import Foundation
import SwiftUI
import CleanBreezeDomain


public protocol AbstractDashboardPresenter: ObservableObject {
    var graphAqis:[AbstractAqiProgressViewModel] {get set}
    var showChart: Bool {get set}
    var allAqis: [AbstractAqiViewModel] {get set}
    func showChart(forItem: AbstractAqiViewModel)
    func setup()
}


