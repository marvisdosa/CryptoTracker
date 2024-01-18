//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 13/01/2024.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText:String = ""
    @State private var showCheckmark:Bool = false

    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading) {
                    SearchBarView(searchText: $vm.searchText)
                    CoinLogoList
                    
                    if selectedCoin != nil {
                        portfolioViewSection
                    }
                }
                
            }
            .onChange(of: vm.searchText, perform: { newValue in
                if newValue == "" {
                    removeSelectedCoin()
                }
            })
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    CancellBtn()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                  trailingNavBarButton
                }
            })
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView().environmentObject(dev.vm)
    }
}


extension PortfolioView {
    private var CoinLogoList: some View {
        ScrollView(.horizontal , showsIndicators: false) {
            LazyHStack(spacing: 10){
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allVmCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding()
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                updateSelectedCoins(coin: coin)
                            }
                        }
                        .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
                        )
                }
            }
           
            .padding()
        }
    }
    
    private func updateSelectedCoins(coin: CoinModel) {
        selectedCoin = coin
        
        // check if selected coin is inside our portfolio array
        if let portfolioCoin = vm.portfolioCoins.first(where: {$0.id == coin.id}),
           let amount = portfolioCoin.currentHoldings
        {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    
    private var portfolioViewSection: some View {
        VStack{
            HStack{
                Text("Current Price of : \(selectedCoin?.symbol.uppercased() ?? "")")
                Spacer()
                Text(selectedCoin?.currentPrice?.asCurrencyWith6Decimals() ?? " ")
            }
            Divider()
            HStack{
                Text("Portolio Wallet : ")
                Spacer()
                TextField("ex 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack{
                Text("Current Value")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .padding()
    }
    
    private var trailingNavBarButton: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1 : 0)
                .bold()

            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
                    .font(.headline)
                    .bold()

            }
            .opacity((selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0)
        }
    }
    
    private func saveButtonPressed() {
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
                
        else { return }
        
        // save to Portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        // Update checkMark
        withAnimation {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        // Hide keyboard
        UIApplication.shared.endEditing()
        
        //Hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            withAnimation {
                showCheckmark  =  false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
}
