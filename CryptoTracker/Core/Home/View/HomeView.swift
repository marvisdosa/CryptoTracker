//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 18/12/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            //Background layer
            Color(.green)
                .ignoresSafeArea()
            
            //Content Layer
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
