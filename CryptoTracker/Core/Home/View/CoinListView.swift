//
//  CoinListView.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 20/12/2023.
//

import SwiftUI

struct CoinListView: View {
    var coin: CoinModel
    var showPortfolioView:Bool
    
    var body: some View {
        HStack{
            
            leftItem
            Spacer()
            if showPortfolioView {
                centerItem
            }
            rightItem
        }
        .font(.subheadline)
        
        
    }
}

struct CoinListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinListView(coin: devcoin.coin, showPortfolioView: true)
                .previewLayout(.sizeThatFits)
            CoinListView(coin: devcoin.coin, showPortfolioView: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}


extension CoinListView {
    private var leftItem: some View {
        HStack{
            Text("\(coin.rank)")
                .frame(minWidth: 30)
                .foregroundColor(Color.theme.secondaryText)
            CoinImageView(coin: coin)
                .frame(width: 48, height: 48)
            Text(coin.symbol.uppercased())
                .fontWeight(.semibold)
                .foregroundColor(Color.theme.accent)
        }
    }
    
    private var centerItem: some View {
        VStack(alignment: .trailing){
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
    }
    
    private var rightItem: some View {VStack(alignment:.trailing){
        VStack(alignment: .trailing){
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .foregroundColor(Color.theme.accent)
            
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "0%")
                .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
        }
        .frame(width: UIScreen.main.bounds.width / 3.5 , alignment: .trailing)
        
    }
    }
    
    
}
