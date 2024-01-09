//
//  EmptyView.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 20/12/2023.
//

import SwiftUI

struct EmptyView: View {
    @State var newbackgroundColor:backgroundColor = .green
    enum backgroundColor {
        case blue
        case pink
        case purple
        case green
        
        var color:Color {
            switch self {
            case .blue:
                return  Color.blue
            case .pink:
                return Color.pink
            case .purple:
                return Color.purple
            case .green:
                return Color.green
            }
        }
    }
    
    
    var body: some View {
        
        VStack(spacing: 24.0) {
            
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(newbackgroundColor == .blue ? Color.blue : Color.clear)
            HStack {
                    Button {
                        newbackgroundColor = .blue
                    } label: {
                        Text("Purple")
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Pink")
                    }
                    
                    
                    Button {
                        
                    } label: {
                        Text("Blue")
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Green")
                    }
                    
                }
        }
    }
    
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}


