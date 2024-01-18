//
//  CancellBtn.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 15/01/2024.
//

import SwiftUI

struct CancellBtn: View {
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        Button(action: {
        presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

struct CancellBtn_Previews: PreviewProvider {
    static var previews: some View {
        CancellBtn()
    }
}
