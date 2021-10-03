//
//  WebSocketWorker.swift
//  Networking
//
//  Created by Leo on 1/10/21.
//

import Foundation
import Combine
import CleanBreezeDomain
import CleanBreezeUtility

public enum WSTracking {
    case listenImmediatly
    case listenAfter(seconds: Double)
    case oneTime
}

public protocol AbstractWebSocketClient {
    func connect()
    func onReceive<T:Decodable>(onComplete: @escaping CBResultCompletion<T>)
    func disconnect()
}

public class WebSocketClient: AbstractWebSocketClient {
    private let session: URLSession
    var socket: URLSessionWebSocketTask?
    var url: URL
    var listenMode: WSTracking
    public init(url: URL,
                listenMode: WSTracking = .oneTime) {
        session = URLSession(configuration: .default)
        self.url = url
        self.listenMode = listenMode
    }
    
    public func onReceive<T:Decodable>(onComplete: @escaping CBResultCompletion<T>) {

      self.socket?.receive { [weak self] (result) in
        switch result {
        case .failure(let error):
            onComplete(.failure(.networkError(error: error)))
          return
        case .success(let message):

          switch message {
          case .data(let data):
            if let t:T = data.parse() {
                onComplete(.success(t))
            } else {
                onComplete(.failure(.parsingError))
            }
            
          break
          case .string(let str):
            guard let data = str.data(using: .utf8) else { return
                onComplete(.failure(.parsingError))
            }
            if let t:T = data.parse() {
                onComplete(.success(t))
            } else {
                onComplete(.failure(.parsingError))
            }
          break
          @unknown default:
            onComplete(.failure(.noDataFound))
            break
          }
        }
        switch self?.listenMode ?? .oneTime {
        case .listenImmediatly:
            DispatchQueue.global(qos: .background).async {
                self?.onReceive(onComplete: onComplete)
            }
            break
        case .listenAfter(seconds: let seconds):
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + seconds) {
                self?.onReceive(onComplete: onComplete)
            }
            break
        default:
            break
        }
        return
      }
    }
    
   
    
    public func connect() {
        self.socket?.cancel()
        self.socket = session.webSocketTask(with: url)
        self.socket?.resume()
    }
    
    public func disconnect() {
        self.socket?.cancel()
    }
}
