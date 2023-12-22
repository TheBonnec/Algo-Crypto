//
//  ModuloPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI
import CIUAisen
import SwiftData
import LaTeXSwiftUI



struct ModuloPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [Modulo]
    @StateObject var newModulo = ModuloVM()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        TypicalPage(title: Pages().modulo.clé, newCalculation: newModulo, saves: saves, minimumSavesCellSize: 200) {
            HStack(spacing: 16) {
                ChampDeTexte(label: "x", entréeNumérale: $newModulo.x)
                ChampDeTexte(label: "a", entréeNumérale: $newModulo.a)
                ChampDeTexte(label: "n", entréeNumérale: $newModulo.n)
            }
        } results: {
            CelluleResultat(
                description: newModulo.displayLabel(),
                résultat: newModulo.displayResult()
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
    
    func displaySavedLabel(save: Modulo) -> String {
        return "$\(save.x ?? 0)^{\(save.a ?? 0)}[\(save.n ?? 0)]$"
    }
    
    func displaySavedResult(save: Modulo) -> String {
        return "\(save.result)[\(save.n!)]"
    }
}





#Preview {
    ModuloPage()
}
