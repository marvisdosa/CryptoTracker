//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 28/12/2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allVmCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var statistics: [StatisticsModel] = []
    @Published var isLoading:Bool = false
    @Published var sortOptions: Sortoption = .holdings
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let PortfolioDataService = PortFolioDataService()
    private var cancellablees = Set<AnyCancellable>()
    
    enum Sortoption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
      // updates allCoins
        //Listen / subscrube to @Published and carry out these actions
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOptions)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [ weak self ] returnedCoins in
                self?.allVmCoins = returnedCoins
            }
            .store(in: &cancellablees)
        
        //Update portfolio Coin
        $allVmCoins
            .combineLatest(PortfolioDataService.$savedEntities)
            .map{(coinModels, portfolioEntities) -> [CoinModel] in
                coinModels
                //check and return any coin that is the same with the entity coins
                    .compactMap { coin in
                        guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id}) else {
                            return nil
                        }
                        return coin.updateHoldings(amount: entity.amount)
                    }
            }
            .sink { [ weak self ] receivedValue in
                self?.portfolioCoins = receivedValue
            }
            .store(in: &cancellablees)
        
        //Updates Market Data
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self]returnedStats in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellablees)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getAllCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double){
        PortfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    private func filterAndSortCoins(text:String, returnedCoins: [CoinModel], sort: Sortoption) -> [CoinModel]  {
        var updatedCoins = filterCoins(text: text, returnedCoins: returnedCoins)
        sortCoins(sort: sort, returnedCoins: &updatedCoins)
    
        return updatedCoins
        
    }
    
    private func filterCoins(text:String, returnedCoins: [CoinModel]) -> [CoinModel]{
        guard !text.isEmpty else {
            return returnedCoins
        }
        
        let lowrCaseText = text.lowercased()
        let filterdCoins = returnedCoins.filter { allCoins in
            return allCoins.name.lowercased().contains(lowrCaseText) ||
            allCoins.symbol.lowercased().contains(lowrCaseText) ||
            allCoins.id.lowercased().contains(lowrCaseText)
        }
        
        return filterdCoins
    }
    
    private func sortCoins(sort: Sortoption , returnedCoins: inout [CoinModel]){
        switch sort {
        case .rank, .holdings :
             returnedCoins.sort(by: { $0.rank < $1.rank })
        case .rankReversed , .holdingsReversed:
              returnedCoins.sort(by: { $0.rank > $1.rank })
        case .price :
            returnedCoins.sort(by: { $0.currentPrice ?? 0 < $1.currentPrice ?? 0 })
        case .priceReversed :
             returnedCoins.sort(by: { $0.currentPrice ?? 0 > $1.currentPrice ?? 0 })
        }
        }
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticsModel]{
        var stats: [StatisticsModel] = []
        guard let data = marketDataModel else {
            return stats
        }
        let marketCap = StatisticsModel(title: "Market Cap", value: data.marketCap , percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticsModel(title: "24H Volume", value: "\(data.totalValue)")
        
        let portfolioValue =
            portfolioCoins
                .map({$0.currentHoldingsValue})
                .reduce(0, +)
          
        let previousValue =
            portfolioCoins
            .map { coin in
               let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage24H ?? 0 )  / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0.0, + )
        let percentageValue = ( (portfolioValue - previousValue) / previousValue) * 100
        
        
        let btcDominance = StatisticsModel(title: "BTC Dominance", value: data.btcDominance)
        let portfolio = StatisticsModel(
            title: "Portfolio Value",
            value: portfolioValue.asCurrencyWith2Decimals() ,
            percentageChange: 0)
        
        stats.append(contentsOf: [
        marketCap,
        volume,
        btcDominance,
        portfolio
        ])
        return stats
        
        
    }

