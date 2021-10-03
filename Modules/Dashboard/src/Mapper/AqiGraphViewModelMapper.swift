//
//  AqiGraphViewModelMapper.swift
//  Dashboard
//
//  Created by Leo on 4/10/21.
//

import Foundation
import CleanBreezeDomain
import SwiftUI
class AqiGraphViewModelMapper: AbstractAqiProgressViewModelMapper  {
    struct ProgressViewModel: AbstractProgressViewModel {
        var progress: Double
        
        var color: Color
        
        var value: String
    }
    var timeFormatter = DateFormatter()
    var dateFormatter = DateFormatter()
    init() {
        timeFormatter.dateFormat = "h:mm:ss a"
        timeFormatter.amSymbol = "AM"
        timeFormatter.pmSymbol = "PM"
        dateFormatter.dateFormat = "MMM d, yyyy"
    }
    func map(entity: AbstractAqiEntity) -> AbstractAqiProgressViewModel? {
        let category = AqiCategory.categoryFor(aqi: entity.aqi)
        let aqiRounded = String(format: "%.2f", entity.aqi)
        let timeDescription =  timeFormatter
        .string(from: entity.updatedOn ?? .init())
        let dateDescription = dateFormatter.string(from: entity.updatedOn ?? .init())
        let progress = ProgressViewModel(progress: (100 - (entity.aqi/500.0)*100.0),
                                         color: category.color,
                                         value: "AQI: \(aqiRounded)")
        let vm = AqiProgressViewModel(cityName: entity.city,
                              aqi: aqiRounded,
                              fontColor: category.color,
                              aqiCategory: category.description,
                              timeDescriptiion: timeDescription,
                              dateDescription: dateDescription,
                              entity: entity,
                              progress: progress
        )
        return vm
    }
    func mapAll(_ items: [AbstractAqiEntity]) -> [AbstractAqiProgressViewModel] {
       
            return items.map({[weak self] in self?.map(entity: $0) ?? nil}).compactMap({$0})
        
    }
}
