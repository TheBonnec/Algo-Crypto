//
//  PageNavigator.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 30/10/2023.
//

import SwiftUI


struct PageNavigator<Content: View>: View {
    
    var title: String
    var buttonTitle: String
    var backAction: () -> Void
    @ViewBuilder var view: Content
    
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Button(action: {
                        backAction()
                    }, label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text(buttonTitle)
                        }
                        .foregroundStyle(Color.cyan)
                    })
                    
                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                
                Spacer()
            }
            .padding()
            
            view
        }
    }
}




#Preview {
    PageNavigator(title: "Titre", buttonTitle: "Page Précédente") {
        print("Hello")
    } view: {
        Text("Hello")
    }

}
