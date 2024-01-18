//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 28/12/2023.
//

import Foundation
import Combine


class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    var coinSubscription: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    
    
    init(){
        getAllCoins()
    }
    
     func getAllCoins(){
                        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
                         NetworkingManager.download(url: url)
                            .decode(type: [CoinModel].self, decoder: JSONDecoder())
                            .receive(on: DispatchQueue.main)
                            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: {returnedCoins in
                                self.allCoins = returnedCoins
                                    print(returnedCoins)
                            })
                            .store(in: &cancellables)
                    }
                
            }
