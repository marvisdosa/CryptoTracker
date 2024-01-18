//
//  DetailView.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 18/01/2024.
//

import SwiftUI

struct DetailView: View {
    let coin:CoinModel
    
    var body: some View {
        Text(coin.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
