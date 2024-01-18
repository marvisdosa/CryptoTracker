//
//  HomeStatsView.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 12/01/2024.
//

import SwiftUI

struct HomeStatsView: View {
    @EnvironmentObject var vm: HomeViewModel
    @Binding var showPortfolio:Bool
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { statistics in
                StatisticsView(stat: statistics)
                    .frame(width: UIScreen.main.bounds.width / 3 )
                    .frame(alignment: .topLeading)
            }
        }
        .padding(.vertical)
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPortfolio: .constant(false))
            .environmentObject(dev.vm)
    }
}
