//
//  CleanBreezeApp.swift
//  Shared
//
//  Created by Leo on 30/9/21.
//

import SwiftUI
import Dashboard
@main
struct CleanBreezeApp: App {
    var body: some Scene {
        WindowGroup {
            DashboardConfigurator.configureDashBoardScene()
        }
    }
}
