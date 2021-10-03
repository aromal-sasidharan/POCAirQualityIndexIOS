//
//  DashboardPresenter.swift
//  CleanBreezeDomain
//
//  Created by Leo on 3/10/21.
//

import Foundation
import CleanBreezeDomain
import Combine

public class DashboardPresenter: AbstractDashboardPresenter {
    @Published public var allAqis: [AbstractAqiViewModel] = []
    @Published public var showChart: Bool = false
    @Published public var graphAqis:[AbstractAqiProgressViewModel] = []
    var allCityMapper: AbstractAqiViewModelMapper?
    var graphAqiMapper: AbstractAqiProgressViewModelMapper?
    var cancelable: AnyCancellable?
    var chartUpdateCancelable: AnyCancellable?
    var showChartCancelable: AnyCancellable?
    var startTIme: Date = Date.init()
    public func setup() {
        setupSubscribers()
        loadAqiData()
    }
    var interactor: AbstractDashboardInteractor?
    init(interactor: AbstractDashboardInteractor,
         allCityMapper: AbstractAqiViewModelMapper,
         graphAqiMapper: AbstractAqiProgressViewModelMapper
         ) {
        self.interactor = interactor
        self.allCityMapper = allCityMapper
        self.graphAqiMapper = graphAqiMapper
    }
    func setupSubscribers() {
        showChartCancelable?.cancel()
        showChartCancelable = $showChart.sink { [weak self]flag in
            if flag == false {
                self?.hideChart()
            }
        }
        
    }
    func loadAqiData() {
        cancelable?.cancel()
        cancelable = interactor?.loadAqi()
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.global(qos: .background))
            .map({ [weak self] (items:[AbstractAqiEntity]) -> [AbstractAqiViewModel] in
                return self?.allCityMapper?.mapAll(items,startTime: Date.init()) ?? []
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (models:[AbstractAqiViewModel]) in
                self?.allAqis.removeAll()
                self?.allAqis.append(contentsOf: models)
            })
    }
    
    public func showChart(forItem: AbstractAqiViewModel) {
        guard let vm = forItem as? AqiViewModel, let entity = vm.entity as? AqiEntity else {
            return
        }
        
        chartUpdateCancelable?.cancel()
        chartUpdateCancelable = interactor?.loadAqiFor(city: entity.city)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map({ [weak self] (items:[AbstractAqiEntity]) -> [AbstractAqiProgressViewModel] in
                return self?.graphAqiMapper?.mapAll(items) ?? []
            })
            .sink(receiveValue: { [weak self] values in
                self?.showChart = true
                self?.graphAqis = values
            })
        
    }
    public func hideChart() {
        graphAqis.removeAll()
        chartUpdateCancelable?.cancel()
    }
}
