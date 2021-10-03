//
//  DashboardInteractor.swift
//  Dashboard
//
//  Created by Leo on 2/10/21.
//

import Foundation
import Networking
import CleanBreezeDomain
import CleanBreezeUtility
import Combine
public class DashboardInteractor: AbstractDashboardInteractor {
    
    var wsClient: AbstractWebSocketClient
    var aqiSubject: CurrentValueSubject<[String: [AqiEntity]],Never> = .init([:])
    var graphUpdateTimeInterval: TimeInterval
    init(wsClient: AbstractWebSocketClient,
         graphUpdateTimeInterval: TimeInterval
        ) {
        self.wsClient = wsClient
        self.graphUpdateTimeInterval = graphUpdateTimeInterval
    }
    public func loadAqiFor(city: String) -> AnyPublisher<[AbstractAqiEntity], Never> {
        
        let dateSorter:((AbstractAqiEntity, AbstractAqiEntity) -> Bool) = { (lhs, rhs) in
            guard let date1 = lhs.updatedOn, let date2 = rhs.updatedOn else {
                return false
            }
            return date1.compare(date2) == .orderedDescending
        }
       
        let timer = Deferred { Just(Date()) }
            .append(Timer.publish(every: graphUpdateTimeInterval, on: .current, in: .common).autoconnect())
        return Publishers.CombineLatest(aqiSubject, timer)
            .map({$0.0})
            .map({cities in cities[city]?.sorted(by: dateSorter) ?? []})
            .eraseToAnyPublisher()
            
    }
    public func loadAqi() -> AnyPublisher<[AbstractAqiEntity], Never> {
        return AnyPublisher.create { [weak self] (observer: AnyObserver<[AbstractAqiEntity], Never>) in
            
            self?.wsClient.connect()
            self?.wsClient.onReceive{ [weak self] (result: CBResult<[AqiEntity]>) in
                if let data = result.success {
                    let updatedAqi = data.reduce(self?.aqiSubject.value ?? [:]) { aqi, item in
                        var item = item
                        var aqi = aqi
                        item.updatedOn = Date.init()
                        if aqi[item.city] == nil {
                            aqi[item.city] = [item]
                            
                        } else if var items = aqi[item.city] {
                            items.append(item)
                            aqi[item.city] = items
                        }
                        
                        return aqi
                    }
                    self?.aqiSubject.send(updatedAqi)
                    let values = updatedAqi.values.reduce([AqiEntity]()) { data, items in
                        var data = data
                        if let first = items.last {
                            data.append(first)
                        }
                        return data
                    }.sorted(by: {$0.city < $1.city})
                    observer.onNext(values)
                    
                }
                if let error = result.failure {
                    print("error", error)
                }
            }
            return Disposable {
                self?.wsClient.disconnect()
            }
        }
    }
    
}
