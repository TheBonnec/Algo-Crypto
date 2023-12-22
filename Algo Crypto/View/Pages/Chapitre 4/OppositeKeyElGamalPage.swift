//
//  OppositeKeyElGamalPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 22/12/2023.
//

import SwiftUI
import CIUAisen
import SwiftData
import LaTeXSwiftUI


struct OppositeKeyElGamalPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [OppositeKeyElGamal]
    @StateObject var newOppositeKey = OppositeKeyElGamalVM()
    var oppositeKeyMods: [ElementDeSelecteur]
    @State var oppositeKeyMod: ElementDeSelecteur
    
    
    
    /* ----- Init ----- */
    
    init() {
        self.oppositeKeyMods = [ElementDeSelecteur(clé: "Calculer eA"), ElementDeSelecteur(clé: "Calculer dA")]
        self._oppositeKeyMod = State(initialValue: self.oppositeKeyMods[0])
    }
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        TypicalPage(title: Pages().oppositeKeyElGamal.clé, newCalculation: newOppositeKey, saves: saves, minimumSavesCellSize: 250) {
            inputs
        } results: {
            warnings
            
            CelluleResultat(
                description: newOppositeKey.displayLabel(),
                résultat: newOppositeKey.displayResult()
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
    
    
    var inputs: some View {
        VStack(spacing: 16) {
            HStack {
                LaTeX("$n$: Le nombre inscrit dans $Inv(\\frac{\\mathbb{Z}}{n\\mathbb{Z}})$, ou dans $\\mathbb{F}_n^*$\n$g$: le générateur")
                    .foregroundStyle(Color.texteSecondaire)
                Spacer()
            }
            .padding(.bottom, 24)
            
            
            SelecteurDeroulant(options: oppositeKeyMods, selection: $oppositeKeyMod)
            
            switch newOppositeKey.mode {
            case .eA:
                HStack(spacing: 16) {
                    ChampDeTexte(label: "n", entréeNumérale: $newOppositeKey.n)
                    ChampDeTexte(label: "g", entréeNumérale: $newOppositeKey.g)
                    ChampDeTexte(label: "dA", entréeNumérale: $newOppositeKey.dA)
                }
            case .dA:
                HStack(spacing: 16) {
                    ChampDeTexte(label: "n", entréeNumérale: $newOppositeKey.n)
                    ChampDeTexte(label: "g", entréeNumérale: $newOppositeKey.g)
                    ChampDeTexte(label: "eA", entréeNumérale: $newOppositeKey.eA)
                }
            }
        }
        .onChange(of: oppositeKeyMod) { _, _ in
            switch oppositeKeyMod.clé {
            case "Calculer eA": self.newOppositeKey.mode = .eA
            case "Calculer dA": self.newOppositeKey.mode = .dA
            default: self.newOppositeKey.mode = .eA
            }
        }
    }
    
    
    var warnings: some View {
        Group {
            let isSolutionExisting = newOppositeKey.isSolutionExisting()
            if !isSolutionExisting {
                CelluleRouge {
                    Text("AVERTISSEMENT")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.teinteAvertissement)
                    
                    LaTeX("Il semblerait que $e$ et $d$ ne soient pas compatible entre eux.")
                        .foregroundStyle(Color.teinteAvertissement)
                }
            }
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func displaySavedLabel(save: OppositeKeyElGamal) -> String {
        switch save.mode {
        case .eA: return "La clef eA pour n = \(save.n ?? 0), g = \(save.g ?? 0) et dA = \(save.dA ?? 0) est"
        case .dA: return "La clef dA pour n = \(save.n ?? 0), g = \(save.g ?? 0) et eA = \(save.eA ?? 0) est"
        }
    }
    
    func displaySavedResult(save: OppositeKeyElGamal) -> String {
        if save.result == -2 {
            return "Aucun résultat trouvé"
        }
        return "\(save.result)"
    }
}

#Preview {
    OppositeKeyElGamalPage()
}
