//
//  CyclicGroupPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 22/12/2023.
//

import SwiftUI
import CIUAisen
import SwiftData
import LaTeXSwiftUI


struct CyclicGroupPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [CyclicGroup]
    @StateObject var newCyclicGroup = CyclicGroupVM()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        TypicalPage(title: Pages().cyclicGroup.clé, newCalculation: newCyclicGroup, saves: saves, minimumSavesCellSize: 300) {
            HStack(spacing: 16) {
                ChampDeTexte(label: "n", entréeNumérale: $newCyclicGroup.n)
            }
        } results: {
            CelluleResultat(
                description: newCyclicGroup.displayLabel(),
                résultat: newCyclicGroup.displayResult()
            )
        } savesSection: {
            ForEach(saves) { save in
                Cellule(alignement: .center, largeurMax: .infinity) {
                    LaTeX(displaySavedLabel(save: save))
                        .foregroundStyle(Color.texteSecondaire)
                    
                    Text(displaySavedResult(save: save))
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func displaySavedLabel(save: CyclicGroup) -> String {
        return "Le groupe $Inv(\\frac{\\mathbb{Z}}{\(save.n ?? 0)\\mathbb{Z}})$ est"
    }
    
    func displaySavedResult(save: CyclicGroup) -> String {
        if save.result {
            return "Cyclique"
        }
        return "Non Cyclique"
    }
}





#Preview {
    CyclicGroupPage()
}
