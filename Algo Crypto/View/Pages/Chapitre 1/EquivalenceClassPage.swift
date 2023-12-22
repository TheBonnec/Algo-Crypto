//
//  EquivalenceClassPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI
import CIUAisen
import SwiftData
import LaTeXSwiftUI



struct EquivalenceClassPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [EquivalenceClass]
    @StateObject var newEquivalence = EquivalenceClassVM()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        TypicalPage(title: Pages().equivalenceClass.clé, newCalculation: newEquivalence, saves: saves, minimumSavesCellSize: 300) {
            HStack(spacing: 16) {
                ChampDeTexte(label: "a", entréeNumérale: $newEquivalence.a)
                ChampDeTexte(label: "n", entréeNumérale: $newEquivalence.n)
            }
        } results: {
            CelluleResultat(
                description: newEquivalence.displayLabel(),
                résultat: newEquivalence.displayResult()
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
    
    func displaySavedLabel(save: EquivalenceClass) -> String {
        return "\("in".localized())  $\\frac{\\mathbb{Z}}{\(save.n ?? 0)\\mathbb{Z}}$"
    }
    
    func displaySavedResult(save: EquivalenceClass) -> String {
        if save.a! < save.n! {
            var equivalenceText = ""
            for e in save.equivalences {
                equivalenceText += "\(e), "
            }
            return "$\\bar{\(save.a!)} = [\(equivalenceText)...]$"
        }
        return "Pas de solution pour a > n"
    }
}





#Preview {
    EquivalenceClassPage()
}
