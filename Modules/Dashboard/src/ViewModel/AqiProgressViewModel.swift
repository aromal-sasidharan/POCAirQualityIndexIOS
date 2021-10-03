//
//  AqiProgressViewModel.swift
//  Dashboard
//
//  Created by Leo on 4/10/21.
//

import Foundation
import SwiftUI
import CleanBreezeDomain
public protocol AbstractAqiProgressViewModel: AbstractAqiViewModel {
    var progress: AbstractProgressViewModel {get set}
    var dateDescription: String? {get set}
}


struct AqiProgressViewModel: AbstractAqiProgressViewModel {
    
    var cityName: String
    
    var aqi: String
    
    var fontColor: Color
    
    var aqiCategory: String
    
    var timeDescriptiion: String?
    
    var dateDescription: String?
    
    var entity: AbstractAqiEntity
    
    var progress: AbstractProgressViewModel
}
