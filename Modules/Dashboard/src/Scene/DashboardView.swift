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
                Text("Air Quality Index")
                .font(.title)
                List {
                    ForEach(presenter.allAqis, id: \.cityName) { item in
                        Button(action: {
                            presenter.showChart(forItem: item)
                        }){
                            CityRowView(viewModel: item)
                            
                        }
                        .padding()
                        .background(item.fontColor)
                        
                        .cornerRadius(10)
                    }
                        .listRowBackground(Color.clear)
                    .listRowInsets(.none)
                    .shadow(radius: 5)
                   

                } .onAppear() {
                    UITableView.appearance().backgroundColor = UIColor.clear
                    UITableViewCell.appearance().backgroundColor = UIColor.clear
                }

            }
    }
}


struct CityRowView: View {
    var viewModel: AbstractAqiViewModel
    var body: some View {
        HStack {
            Text(viewModel.cityName)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            VStack {
                Text(viewModel.aqi)
                    .foregroundColor(Color.white)
                    
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .shadow(color: .black, radius: 10)
                    .animation(.easeIn)
                Text(viewModel.timeDescriptiion ?? "")
                .frame(maxWidth: .infinity, alignment: .trailing)
            }.frame(maxWidth:.infinity)
           
        }
    }
}
