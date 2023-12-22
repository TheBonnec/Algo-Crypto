//
//  CongruencePage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI
import CIUAisen
import SwiftData
import LaTeXSwiftUI


struct CongruencePage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [Congruence]
    @StateObject var newCongruence = CongruenceVM()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        TypicalPage(title: Pages().congruence.clé, newCalculation: newCongruence, saves: saves, minimumSavesCellSize: 200) {
            HStack(spacing: 16) {
                ChampDeTexte(label: "a", entréeNumérale: $newCongruence.a)
                ChampDeTexte(label: "p", entréeNumérale: $newCongruence.p)
                ChampDeTexte(label: "b", entréeNumérale: $newCongruence.b)
                ChampDeTexte(label: "q", entréeNumérale: $newCongruence.q)
                ChampDeTexte(label: "n", entréeNumérale: $newCongruence.n)
            }
        } results: {
            CelluleResultat(
                description: newCongruence.displayLabel(),
                résultat: newCongruence.displayResult()
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
    
    func displaySavedLabel(save: Congruence) -> String {
        return "$\(save.a ?? 0)^{\(save.p ?? 0)} \\times x ≡ \(save.b ?? 0)^{\(save.q ?? 0)}[\(save.n ?? 0)]$"
    }
    
    func displaySavedResult(save: Congruence) -> String {
        if save.result == -444 {
            return "NoSolution".localized()
        }
        return "x = \(save.result)"
    }
}





#Preview {
    CongruencePage()
}
