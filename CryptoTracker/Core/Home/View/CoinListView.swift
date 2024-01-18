//
//  CoinListView.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 20/12/2023.
//

import SwiftUI

struct CoinListView: View {
    let coin: CoinModel
    var showPortfolioView:Bool = false
    
    var body: some View {
        HStack{
            
            leftItem
            Spacer()
            if showPortfolioView == true {
                centerItem
            } else {
                EmptyView()
            }
            rightItem
        }
        .padding(.vertical, 8)
        .font(.subheadline)
    }
}

struct CoinListView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CoinListView(coin: dev.coin, showPortfolioView: true)
                .previewLayout(.sizeThatFits)
            CoinListView(coin: dev.coin, showPortfolioView: false)
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
                .frame(width: 40, height: 40)
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
            Text(coin.currentPrice?.asCurrencyWith6Decimals() ?? "")
                .foregroundColor(Color.theme.accent)
                .fontWeight(.bold)
            
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "0%")
                .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
        }
        .frame(width: UIScreen.main.bounds.width / 3.5 , alignment: .trailing)
        
    }
    }
    
    
}
