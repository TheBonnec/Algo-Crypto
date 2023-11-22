//
//  ACButton.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 30/10/2023.
//

import Foundation
import SwiftUI



struct ACButton: View {
    
    var label: LocalizedStringKey
    var style: ButtonStyle
    var action: () -> Void
    
    let backgroundColor: Color
    let textColor: Color
    
    init(label: LocalizedStringKey, style: ButtonStyle = .primary, action: @escaping () -> Void) {
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
        case .primaryDestructive:
            self.backgroundColor = .pink
            self.textColor = .white
        case .secondaryDestructive:
            self.backgroundColor = Color(UIColor.secondarySystemBackground)
            self.textColor = .pink
        }
    }
    
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack{
                Text(label)
                    .fontWeight(.medium)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .foregroundColor(textColor)
            .background(Gradient(colors: [.white.opacity(0.17), .white.opacity(0)]))
            .background(backgroundColor)
            .cornerRadius(8)
            //.shadow(color: self.backgroundColor.opacity(0.24), radius: 2.5, x: 0, y: 1)
            .border(width: 0.5, edges: [.leading, .trailing], color: self.backgroundColor.opacity(0.12))
            .padding(.horizontal)
        })
    }
}




enum ButtonStyle {
    case primary, secondary, tertiary, primaryDestructive, secondaryDestructive
}



#Preview {
    ACButton(label: "Button", style: .primary) {
        print("Hello")
    }
}
