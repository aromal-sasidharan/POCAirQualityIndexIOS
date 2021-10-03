//
//  AqiViewModel.swift
//  CleanBreezeDomain
//
//  Created by Leo on 3/10/21.
//

import Foundation
import SwiftUI
import CleanBreezeDomain

public protocol AbstractAqiViewModel {
    var cityName: String {get set}
    var aqi: String {get set}
    var fontColor: Color {get set}
    var aqiCategory: String {get set}
    var timeDescriptiion: String? {get set}
    var entity: AbstractAqiEntity {get set}
}

struct AqiViewModel: AbstractAqiViewModel {
    var cityName: String
    var aqi: String
    var fontColor: Color
    var aqiCategory: String
    var timeDescriptiion: String?
    var entity: AbstractAqiEntity
    
}


