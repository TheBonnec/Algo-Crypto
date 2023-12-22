//
//  CelluleEntrees.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 20/12/2023.
//

import SwiftUI
import CIUAisen


struct CelluleEntrees<Contenu: View>: View {
    
    var contenu: Contenu
    var actionSauvegarder: () -> Void
    var actionReinitialiser: () -> Void
    
    
    init(@ViewBuilder contenu: () -> Contenu, actionSauvegarder: @escaping () -> Void, actionReinitialiser: @escaping () -> Void) {
        self.contenu = contenu()
        self.actionSauvegarder = actionSauvegarder
        self.actionReinitialiser = actionReinitialiser
    }
    
    
    
    var body: some View {
        Cellule(largeurMax: .infinity) {
            contenu
            
            HStack(spacing: 16) {
                Bouton(type: .secondaire, label: "SaveAndReset".localized()) {
                    actionSauvegarder()
                }
                
                Bouton(type: .destructeurSecondaire, label: "Reset".localized()) {
                    actionReinitialiser()
                }
            }
        }
    }
}





#Preview {
    CelluleEntrees {
        Text("Hello")
    } actionSauvegarder: {
        print()
    } actionReinitialiser: {
        print()
    }
    .padding()
}
