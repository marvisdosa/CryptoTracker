//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 18/12/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject  var vm: HomeViewModel
    @State var showPortfolio:Bool = false // animate right
    @State private var showPortfolioView:Bool = false // new sheet
    
    
    @State private var selectCoin: CoinModel? = nil
    @State private var showDetailView:Bool = false
    
    var body: some View {          
            ZStack {
                //Background layer
                Color.theme.background
                    .ignoresSafeArea()
                    .sheet(isPresented: $showPortfolioView) {
                        PortfolioView()
                            .environmentObject(vm)
                    }
                

                //Content Layer
                ScrollView {
                    VStack{
                    HomeStatsView(showPortfolio: $showPortfolio)
                    SearchBarView(searchText: $vm.searchText)
                    coinRowHeader
                        portFolioCoinList
                        allCoinListView
                        
                    }
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading){
                            Text(!showPortfolio ? "Live prices" : "Portfolio")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        ToolbarItem(placement: .navigationBarTrailing){
                             
                            HStack {
                                
                                Button {
                                    showPortfolioView.toggle()
                                } label: {
                                    Image(systemName: "plus")
                                        .opacity(!showPortfolio ? 0.0 : 1.0 )
                                        .font(.title3)
                                        .fontWeight(.bold)
                            }
                                
                                Button {
                                    showPortfolio.toggle()
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(dev.vm)
    }
}


extension HomeView {
    private var allCoinListView: some View {
        ScrollView {
            ForEach(vm.allVmCoins) { x in
                    CoinListView(coin: x, showPortfolioView: showPortfolio)
                        .transition(.move(edge: .leading))
                        .listRowInsets(.init(top: 40, leading: 0, bottom: 40, trailing: 16))
                        .onTapGesture {
                            segue(coin: x)
                        }
            }
            .padding(.horizontal)
        }
        .listStyle(.plain)
    }
    
    
    private var portFolioCoinList: some View {
        List{
            ForEach(vm.portfolioCoins) { x in
                CoinListView(coin: x, showPortfolioView: showPortfolio)
                    .transition(.move(edge: .trailing))
                    .listRowInsets(.init(top: 40, leading: 0, bottom: 40, trailing: 16))
                    .onTapGesture {
                        segue(coin: x)
                    }
            }
        }
        .listStyle(.plain)

    }
    
    private func segue(coin: CoinModel) {
        
    }
    
    private var coinRowHeader: some View {
        HStack {
            HStack {
                Text ("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOptions == .rank || vm.sortOptions == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(.degrees(vm.sortOptions == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default){
                    vm.sortOptions = vm.sortOptions == .rank ? .rankReversed : .rank
                }
              
            }
            Spacer()
            if showPortfolio{
                HStack {
                    Text ("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOptions == .holdings || vm.sortOptions == .rankReversed) ? 1.0 : 0.0)
                        .rotationEffect(.degrees(vm.sortOptions == .rank ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default){
                        vm.sortOptions = vm.sortOptions == .holdings ? .rankReversed : .holdings
                    }
                }
            }
            HStack {
                Text ("Price")
                    .opacity((vm.sortOptions == .price || vm.sortOptions == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(.degrees(vm.sortOptions == .rank ? 0 : 180))

            }
            .frame(width: UIScreen.main.bounds.width / 3 , alignment: .trailing)
            .onTapGesture {
                withAnimation(.default){
                    vm.sortOptions = vm.sortOptions == .price ? .rankReversed : .priceReversed
                }
            }
            Button {
                withAnimation(.default) {
                    vm.reloadData()
                }
            } label: {
                
                   Image(systemName: "goforward")
                        .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0 ), anchor: .center)

                
            }
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(16)
    }

}
