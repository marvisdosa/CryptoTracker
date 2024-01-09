//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 18/12/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject  var vm: HomeViewModel
    @State var showPortfolio:Bool = false
    
    var body: some View {          
            ZStack {
                //Background layer
                Color.theme.background
                    .ignoresSafeArea()
                

                //Content Layer
                ScrollView {
                    VStack{
                    SearchBarView(searchText: $vm.searchText)
                    coinRowHeader
                    allCoinListView
                    }
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading){
                            Text("Live Prices")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        ToolbarItem(placement: .navigationBarTrailing){
                            Button {
    //                            showPortfolio = true
                            } label: {
                                Image(systemName: !showPortfolio ? "person" : "chevron.left")
                                    .font(.title3)
                                    .fontWeight(.bold)
                            }
                        }
                }
                }
                
            }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(devcoin.vm)
    }
}


extension HomeView {
    private var allCoinListView: some View {
        List {
            ForEach(vm.allCoins) { x in
                CoinListView(coin: x, showPortfolioView: false)
                    .transition(.move(edge: .leading))
                    .listRowInsets(.init(top: 16, leading: 0, bottom: 16, trailing: 16))
            }
        }
        .listStyle(.plain)
    }
    
    private var coinRowHeader: some View {
        HStack {
            Text ("Coin")
            Spacer()
            if showPortfolio{
                Text ("Holdings")
            }
            Text ("Price")
                .frame(width: UIScreen.main.bounds.width / 3, alignment: .trailing)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(16)
    }

}
