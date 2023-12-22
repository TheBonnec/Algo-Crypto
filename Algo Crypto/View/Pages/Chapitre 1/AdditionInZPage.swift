//
//  AdditionInZPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI
import CIUAisen
import SwiftData
import LaTeXSwiftUI


struct AdditionInZPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [AdditionInZ]
    @StateObject var newAddition = AdditionInZVM()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        TypicalPage(title: Pages().additionInZ.clé, newCalculation: newAddition, saves: saves, minimumSavesCellSize: 150) {
            HStack(spacing: 16) {
                ChampDeTexte(label: "a", entréeNumérale: $newAddition.a)
                ChampDeTexte(label: "b", entréeNumérale: $newAddition.b)
                ChampDeTexte(label: "n", entréeNumérale: $newAddition.n)
            }
        } results: {
            CelluleResultat(
                description: newAddition.displayLabel(),
                résultat: newAddition.displayResult()
            )
        } savesSection: {
            ForEach(saves) { save in
                Cellule(alignement: .center, largeurMax: .infinity) {
                    LaTeX(displaySavedLabel(save: save))
                        .foregroundStyle(Color.texteSecondaire)
                    
                    LaTeX(displaySavedResult(save: save))
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func displaySavedLabel(save: AdditionInZ) -> String {
        return "$\\bar{\(save.a ?? 0)} ⊕ \\bar{\(save.b ?? 0)}$"
    }
    
    func displaySavedResult(save: AdditionInZ) -> String {
        return "$\\bar{\(save.result)}$"
    }
}





#Preview {
    AdditionInZPage()
}
