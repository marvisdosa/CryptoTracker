//
//  NetworkingManager.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 08/01/2024.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unkown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url) :
                return " 🔥 Bad Response from URL \(url)"
            case .unkown :
                return " ⚠️ Unknown Error occured"
            }
        }
    }
    
    //We don't have to initialise this func thats why its static
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponose(outPut: $0, url: url)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponose(outPut: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {

        guard let response = outPut.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return outPut.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Publishers.Decode<AnyPublisher<Data, Error>, [CoinModel], JSONDecoder>.Failure>){
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
