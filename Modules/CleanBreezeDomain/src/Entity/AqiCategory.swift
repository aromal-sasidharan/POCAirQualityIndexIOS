//
//  AqiCategory.swift
//  CleanBreezeDomain
//
//  Created by Leo on 3/10/21.
//

import Foundation
import SwiftUI
public enum AqiCategory {
    case good // rgb(85,168,80)
    case satisfactory // rgb(163,200,83)
    case moderate // rgb(255,248,51)
    case poor // rgb(242,156,51)
    case verypoor // rgb(233,63,51)
    case severe // rgb(175,45,37)
    case none
    
    public var description: String {
        let data:[AqiCategory: String] = [
            .good : "Good",
            .moderate : "Moderate",
            .satisfactory : "Satisfactory",
            .poor : "Poor",
            .severe: "Severe",
            .verypoor: "Very Poor",
        ]
       return data[self] ?? "Unknown"
    }
    public var color: Color {
        let data:[AqiCategory: Color] = [
            .good : Color.init(.sRGB,
                               red: 85/255,
                               green: 168/255,
                               blue: 80/255,
                               opacity: 1),
            .satisfactory : Color.init(.sRGB,
                                       red: 163/255,
                                       green: 200/255,
                                       blue: 83/255,
                                       opacity: 1),
            .moderate : Color.init(.sRGB,
                                   red: 255/255,
                                   green: 248/255,
                                   blue: 51/255,
                                   opacity: 1),
            .poor : Color.init(.sRGB,
                               red: 242/255,
                               green: 156/255,
                               blue: 51/255,
                               opacity: 1),
            .severe: Color.init(.sRGB,
                                red: 175/255,
                                green: 45/255,
                                blue: 37/255,
                                opacity: 1),
            .verypoor: Color.init(.sRGB,
                                  red: 233/255,
                                  green: 63/255,
                                  blue: 51/255,
                                  opacity: 1),
        ]
        return data[self] ?? AqiCategory.good.color
    }

    public static func categoryFor(aqi: Double) -> AqiCategory{
        switch aqi {
        case 0..<51:
            return .good
        case 51..<101:
            return .satisfactory
        case 101..<201:
            return .moderate
        case 201..<301:
            return .poor
        case 301..<401:
            return .verypoor
        case 401..<501:
            return .severe
        default:
            return .none
        }
    }
}
