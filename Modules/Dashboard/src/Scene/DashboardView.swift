//
//  DashboardView.swift
//  Dashboard
//
//  Created by Leo on 2/10/21.
//

import SwiftUI
import CleanBreezeDomain
public struct DashboardView<Presenter>: View where Presenter: AbstractDashboardPresenter {
    @ObservedObject var presenter: Presenter
    init(presenter: Presenter) {
        self.presenter = presenter
    }
    public var body: some View {
        ZStack {
            contentView()
            .padding(20)
            AqiGraphView(dismiss: $presenter.showChart, aqis: $presenter.graphAqis)
                .opacity($presenter.showChart.wrappedValue ? 1 : 0)
        }
            .onAppear(perform: presenter.setup)
    }
    
    func contentView() -> some View {
            VStack {
                Text("Air Quaility Index")
                .font(.title)
                List {
                    ForEach(presenter.allAqis, id: \.cityName) { item in
                        Button(action: {
                            presenter.showChart(forItem: item)
                        }){
                            CityRowView(viewModel: item)}
                        .padding()
                        .background(item.fontColor)
                        
                        .cornerRadius(10)
                        .listRowBackground(Color.clear)
                    }.shadow(radius: 5)
                }
            }
    }
}


struct CityRowView: View {
    var viewModel: AbstractAqiViewModel
    var body: some View {
        HStack {
            Text(viewModel.cityName)
            Spacer()
            Text(viewModel.aqi)
                .foregroundColor(Color.white)
                .bold()
                
                .shadow(radius: 3)
                .animation(.easeIn)
            Spacer()
            Text(viewModel.timeDescriptiion ?? "")
            
        }
    }
}
