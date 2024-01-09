//
//  CoinImageViewModel.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 08/01/2024.
//


import Foundation
import SwiftUI
import Combine

class CoinImageVM: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    
    private let coin: CoinModel
    private let coinDataService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDataService = CoinImageService(coin: coin)
        addsubscribers()
        self.isLoading = true
    }

    
    private func addsubscribers() {
        coinDataService.$image
            .sink { [ weak self ] _ in
                self?.isLoading = false
            } receiveValue: { [ weak self ] receivedImage in
                self?.image = receivedImage
            }
            .store(in: &cancellables)

    }
    
    
}
