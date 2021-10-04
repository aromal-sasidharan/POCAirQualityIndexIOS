//
//  AqiGraphView.swift
//  Dashboard
//
//  Created by Leo on 3/10/21.
//

import SwiftUI

struct AqiGraphView: View {
    @Binding var dismiss:Bool
    @Binding var aqis:[AbstractAqiProgressViewModel]
    var heightConstanst: CGFloat = 0.40
    var body: some View {
            ZStack {
                VStack{
                    Spacer()
                }
                VStack {
                    Spacer()
                VStack {
                    ZStack{
                        HStack {
                            Spacer()
                            Text("\(aqis.first?.cityName ?? "")")
                                .font(.title)
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Button(action: {
                                dismiss = false
                            }){
                                Text("close")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                                .padding(10)
                                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.white))
                            }
                        }.padding(.trailing,10)
                    }
                    .frame(height: 100)
                    .background(aqis.first?.fontColor ?? .clear)
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(aqis, id: \.entity.updatedOn) { item in
                                VStack {
                                    ProgressView(data: item.progress)
                                    .frame(width: 150.0, height: 150.0)
                                                        .padding(40.0)
                                    Text(item.dateDescription ?? "")
                                        .font(.subheadline)
                                        .bold()
                                    Text(item.timeDescriptiion ?? "")
                                        .font(.subheadline)
                                        .bold()
                                }
                            }
                        }
                    }.frame(height: 330)
                    .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                 
                } .background(Color.white)
                .cornerRadius(20)
                .padding()
                Spacer()
                
                
               
            }.background(Color.gray.opacity(0.5))
        }
    }
}

public protocol AbstractProgressViewModel {
    var progress: Double {get set}
    var color: Color {get}
    var value: String {get set}
}
struct ProgressView: View {
    var data: AbstractProgressViewModel
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(data.color)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(data.progress/100.0))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(data.color)
                .rotationEffect(Angle(degrees: 270.0))
//                .animation(.easeOut)
                
            VStack {
                Text(String(format: "%.2f %%", data.progress))
                    .font(.subheadline)
                    .bold()
                Text(data.value)
            }
            
        }
    }
}
