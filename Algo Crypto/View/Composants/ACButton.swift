//
//  ACButton.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 30/10/2023.
//

import Foundation
import SwiftUI



struct ACButton: View {
    
    var label: String
    var style: ButtonStyle
    var action: () -> Void
    
    let backgroundColor: Color
    let textColor: Color
    
    init(label: String, style: ButtonStyle = .primary, action: @escaping () -> Void) {
        self.label = label
        self.style = style
        self.action = action
        
        switch style {
        case .primary:
            self.backgroundColor = .cyan
            self.textColor = .white
        case .secondary:
            self.backgroundColor = Color(UIColor.secondarySystemBackground)
            self.textColor = .cyan
        case .tertiary:
            self.backgroundColor = Color(UIColor.systemBackground)
            self.textColor = .cyan
        case .destructive:
            self.backgroundColor = .pink
            self.textColor = .white
        }
    }
    
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack{
                Text(label)
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .foregroundColor(textColor)
            .background(backgroundColor)
            .cornerRadius(8)
            .padding(.horizontal)
        })
    }
}




enum ButtonStyle {
    case primary, secondary, tertiary, destructive
}



#Preview {
    ACButton(label: "Button", style: .primary) {
        print("Hello")
    }
}
