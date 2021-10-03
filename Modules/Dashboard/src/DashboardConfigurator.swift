//
//  DashboardConfigurator.swift
//  Dashboard
//
//  Created by Leo on 2/10/21.
//

import Foundation
import Networking



public class DashboardConfigurator {
    
    public static func configureDashBoardScene() -> DashboardView<DashboardPresenter>{
        let wsClient: AbstractWebSocketClient = WebSocketClient(url: URL(string: "ws://city-ws.herokuapp.com")!, listenMode: .listenAfter(seconds: 10))
        let interactor: AbstractDashboardInteractor = DashboardInteractor(wsClient: wsClient, graphUpdateTimeInterval: 30)
        let presenter = DashboardPresenter(interactor: interactor,
                                           allCityMapper: AqiViewModelMapper(),
                                           graphAqiMapper: AqiGraphViewModelMapper())
        let view = DashboardView(presenter: presenter)
        return view
    }
    
}
