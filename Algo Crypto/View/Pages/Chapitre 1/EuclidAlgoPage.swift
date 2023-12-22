//
//  EuclidAlgoPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 12/11/2023.
//

import SwiftUI
import SwiftData
import CIUAisen



struct EuclidAlgoPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [EuclidAlgo]
    @StateObject var newEuclidAlgo = EuclidAlgoVM()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        TypicalPage(title: Pages().euclidAlgo.clé, newCalculation: newEuclidAlgo, saves: saves, minimumSavesCellSize: 200) {
            HStack(spacing: 16) {
                ChampDeTexte(label: "a", entréeNumérale: $newEuclidAlgo.a)
                ChampDeTexte(label: "b", entréeNumérale: $newEuclidAlgo.b)
            }
        } results: {
            CelluleResultat(
                description: newEuclidAlgo.displayLabel(),
                résultat: newEuclidAlgo.displayResult()
            )
        } savesSection: {
            ForEach(saves) { save in
                Cellule(alignement: .center, largeurMax: .infinity) {
                    Text(displaySavedLabel(save: save))
                        .foregroundStyle(Color.texteSecondaire)
                    
                    Text(displaySavedResult(save: save))
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func displaySavedLabel(save: EuclidAlgo) -> String {
        return "\("gcd".localized())(\(save.a ?? 0), \(save.b ?? 0))"
    }
    
    func displaySavedResult(save: EuclidAlgo) -> String {
        return "\(save.r)"
    }
}





#Preview {
    EuclidAlgoPage()
}
