//
//  SearchBarView.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 09/01/2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
                
            TextField("Search by name or Symbol...", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .disableAutocorrection(true)
        }
        .overlay (
            Image(systemName: "xmark.circle.fill")
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .offset(x: 10)
                .opacity(searchText.isEmpty ? 0 : 100)
                .foregroundColor(Color.theme.accent)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                    searchText = ""
                }
            ,alignment: .trailing
            
        )
        .font(.headline)
        .padding()
        .background(
        RoundedRectangle(cornerRadius: 24)
            .fill(Color.theme.background)
            .shadow(color: Color.theme.accent.opacity(0.15), radius: 24, x: 0, y: 0)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
