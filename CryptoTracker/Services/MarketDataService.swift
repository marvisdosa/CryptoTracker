//
//  MarketDataService.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 12/01/2024.
//

import Foundation
import Combine


class MarketDataService {
    @Published var marketData: MarketDataModel? = nil
    var marketSubscription: AnyCancellable?
    
    init(){
        getData()
    }
    
     func getData(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        marketSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: {[weak self] returnedData in
                self?.marketData = returnedData.data
                self?.marketSubscription?.cancel()
            })
    }
    
}
