//
//  AqiViewModelMapper.swift
//  Dashboard
//
//  Created by Leo on 3/10/21.
//

import Foundation
import CleanBreezeDomain

class AqiViewModelMapper: AbstractAqiViewModelMapper {
    func map(entity: AbstractAqiEntity, startTime:  Date?) -> AbstractAqiViewModel? {
        let category = AqiCategory.categoryFor(aqi: entity.aqi)
        let aqiRounded = String(format: "%.2f", entity.aqi)
        var timeString: String? = nil
        if let startTime = startTime {
            timeString = elapsedTimeString(from: startTime, to: entity.updatedOn ?? Date.init())
        }
        let vm = AqiViewModel(cityName: entity.city,
                              aqi: aqiRounded,
                              fontColor: category.color,
                              aqiCategory: category.description,
                              timeDescriptiion: timeString,
                              entity: entity
        )
        return vm
    }
    func mapAll(_ items: [AbstractAqiEntity], startTime: Date?) -> [AbstractAqiViewModel] {
       
            return items.map({[weak self] in self?.map(entity: $0, startTime: startTime) ?? nil}).compactMap({$0})
        
    }
    
    public func elapsedTimeString(from: Date, to: Date) -> String {

        let distanceBetweenDates = from.timeIntervalSince(to)
        let minutes = distanceBetweenDates / 60
        switch minutes {
        case 0..<1:
            let seconds = minutes * 60
            let secondsString = (seconds > 1) ? "\(Int64(seconds)) secs ago" : "few secs ago"
            return secondsString
        case 1..<60:
            return "\(Int64(minutes)) mins ago"
        case 60..<(60 * 24):
            return "\(Int64(minutes / 60)) hour(s) ago"
        case (60 * 24)..<(60 * 24 * 7):
            return "\(Int64(minutes / (60 * 24))) week(s) ago"
        default:
            // somehow the date is ahead? so consider it now
            if minutes < 0 {
                return "few secs ago"
            }
            return "\(Int64(minutes / (60 * 24 * 7))) week(s) ago"
        }
       }
}
