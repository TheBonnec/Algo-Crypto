//
//  PhiPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 26/11/2023.
//

import SwiftUI
import CIUAisen
import SwiftData
import LaTeXSwiftUI



struct PhiPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [Phi]
    @StateObject var newPhi = PhiVM()
    var phiMods: [ElementDeSelecteur]
    @State var phiMod: ElementDeSelecteur
    
    
    
    /* ----- Inits ----- */
    
    init() {
        self.phiMods = [ElementDeSelecteur(clé: "Calculer avec n"), ElementDeSelecteur(clé: "Calculer avec p et q"), ElementDeSelecteur(clé: "Calculer φ(φ(n))")]
        self._phiMod = State(initialValue: self.phiMods[0])
    }
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        TypicalPage(title: Pages().phi.clé, newCalculation: newPhi, saves: saves, minimumSavesCellSize: 250) {
            inputs
        } results: {
            CelluleResultat(
                description: newPhi.displayLabel(),
                résultat: newPhi.displayResult()
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
            SelecteurDeroulant(options: phiMods, selection: $phiMod)
            
            HStack(spacing: 16) {
                switch newPhi.mode {
                case .n:
                    ChampDeTexte(label: "n", entréeNumérale: $newPhi.n)
                case .pq:
                    ChampDeTexte(label: "p", entréeNumérale: $newPhi.p)
                    ChampDeTexte(label: "q", entréeNumérale: $newPhi.q)
                case .phiPhi:
                    ChampDeTexte(label: "n", entréeNumérale: $newPhi.n)
                }
            }
        }
        .onChange(of: phiMod) { _, _ in
            switch phiMod.clé {
            case "Calculer avec n": self.newPhi.mode = .n
            case "Calculer avec p et q": self.newPhi.mode = .pq
            case "Calculer φ(φ(n))": self.newPhi.mode = .phiPhi
            default: self.newPhi.mode = .n
            }
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func displaySavedLabel(save: Phi) -> String {
        switch save.mode {
        case .n: return "$\\phi(\(save.n ?? 0))$"
        case .pq: return "$\\phi(\(save.p ?? 0) \\times \(save.q ?? 0))$"
        case .phiPhi: return "$\\phi(\\phi(\(save.n ?? 0)))$"
        }
    }
    
    func displaySavedResult(save: Phi) -> String {
        return "\(save.result)"
    }
}





#Preview {
    PhiPage()
}
