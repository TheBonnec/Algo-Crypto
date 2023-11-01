//
//  MainView.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 30/10/2023.
//

import SwiftUI
import SwiftData


struct MainViews: View {
    
    @Binding var page: Page
    
    
    var body: some View {
        PageVStack {
            
            Text("Algo Crypto")
                //.foregroundStyle(Color.white)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            ACButton(label: "Euclid Algorithm", style: .secondary) {
                self.page = .euclid
            }
            ACButton(label: "Extended Euclid Algorithm", style: .secondary) {
                self.page = .extendedEuclid
            }
            ACButton(label: "Modulo", style: .secondary) {
                self.page = .modulo
            }
            ACButton(label: "Congruence", style: .secondary) {
                self.page = .congruence
            }
        }
    }
}




#Preview {
    MainViews(page: .constant(.main))
}
