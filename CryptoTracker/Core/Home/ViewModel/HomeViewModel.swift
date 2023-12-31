//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 28/12/2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    private var cancellablees = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$allCoins
            .sink {[ weak self ] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellablees)
    }
}
