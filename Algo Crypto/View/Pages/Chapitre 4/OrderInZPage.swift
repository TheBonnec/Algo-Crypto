//
//  OrderInZPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 22/12/2023.
//

import SwiftUI
import CIUAisen
import SwiftData
import LaTeXSwiftUI


struct OrderInZPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [OrderInZ]
    @StateObject var newOrder = OrderInZVM()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        TypicalPage(title: Pages().orderInZ.clé, newCalculation: newOrder, saves: saves, minimumSavesCellSize: 300) {
            HStack(spacing: 16) {
                ChampDeTexte(label: "k", entréeNumérale: $newOrder.k)
                ChampDeTexte(label: "n", entréeNumérale: $newOrder.n)
            }
        } results: {
            CelluleResultat(
                description: newOrder.displayLabel(),
                résultat: newOrder.displayResult()
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
    
    func displaySavedLabel(save: OrderInZ) -> String {
        return "L'ordre de \(save.k ?? 0) dans $Inv(\\frac{\\mathbb{Z}}{\(save.n ?? 0)\\mathbb{Z}})$ est"
    }
    
    func displaySavedResult(save: OrderInZ) -> String {
        if save.result == -2 {
            return "\(save.k ?? 0) n'est pas inversible, donc n'a pas d'ordre"
        } else if save.result == -3 {
            return "Une erreur est survenue"
        }
        return "\(save.result)"
    }
}





#Preview {
    OrderInZPage()
}
