//
//  ElGamalEncryptionPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 22/12/2023.
//

import SwiftUI
import CIUAisen
import SwiftData
import LaTeXSwiftUI


struct ElGamalEncryptionPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [ElGamalEncryption]
    @StateObject var newElGamalEncryption = ElGamalEncryptionVM()
    var oppositeKeyMods: [ElementDeSelecteur]
    @State var oppositeKeyMod: ElementDeSelecteur
    
    
    
    /* ----- Init ----- */
    
    init() {
        self.oppositeKeyMods = [ElementDeSelecteur(clé: "Chiffrer"), ElementDeSelecteur(clé: "Déchiffrer")]
        self._oppositeKeyMod = State(initialValue: self.oppositeKeyMods[0])
    }
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        TypicalPage(title: Pages().oppositeKeyElGamal.clé, newCalculation: newElGamalEncryption, saves: saves, minimumSavesCellSize: 250) {
            inputs
        } results: {
            CelluleResultat(
                description: newElGamalEncryption.displayLabel(),
                résultat: newElGamalEncryption.displayResult()
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
        Group {
            switch newElGamalEncryption.mode {
            case .encrypt: encryptInputs
            case .decrypt: decryptInputs
            }
        }
        .onChange(of: oppositeKeyMod) { _, _ in
            switch oppositeKeyMod.clé {
            case "Chiffrer": self.newElGamalEncryption.mode = .encrypt
            case "Déchiffrer": self.newElGamalEncryption.mode = .decrypt
            default: self.newElGamalEncryption.mode = .encrypt
            }
        }
    }
    
    
    var encryptInputs: some View {
        VStack(spacing: 16) {
            HStack {
                LaTeX("message : le nombre à encoder\n$n$ : Le nombre inscrit dans $Inv(\\frac{\\mathbb{Z}}{n\\mathbb{Z}})$, ou dans $\\mathbb{F}_n^*$\n$g$ : le générateur\n$k$ : nombre donné dans l'éxercice\n$e$ : clef publique du destinataire")
                    .foregroundStyle(Color.texteSecondaire)
                Spacer()
            }
            .padding(.bottom, 24)
            
            
            SelecteurDeroulant(options: oppositeKeyMods, selection: $oppositeKeyMod)
            
            HStack(spacing: 16) {
                ChampDeTexte(label: "message", entréeNumérale: $newElGamalEncryption.message)
                ChampDeTexte(label: "n", entréeNumérale: $newElGamalEncryption.n)
                ChampDeTexte(label: "g", entréeNumérale: $newElGamalEncryption.g)
                ChampDeTexte(label: "k", entréeNumérale: $newElGamalEncryption.k)
                ChampDeTexte(label: "e", entréeNumérale: $newElGamalEncryption.e)
            }
        }
    }
    
    
    var decryptInputs: some View {
        VStack(spacing: 16) {
            HStack {
                LaTeX("message : le nombre à encoder (donné sous forme (r,y), où y est le message)\n$n$ : Le nombre inscrit dans $Inv(\\frac{\\mathbb{Z}}{n\\mathbb{Z}})$, ou dans $\\mathbb{F}_n^*$\n$g$ : le générateur\n$r$ : nombre donné dans l'éxercice (sous forme (r,y) normalement)\n$d$ : clef privée du récepteur")
                    .foregroundStyle(Color.texteSecondaire)
                Spacer()
            }
            .padding(.bottom, 24)
            
            
            SelecteurDeroulant(options: oppositeKeyMods, selection: $oppositeKeyMod)
            
            HStack(spacing: 16) {
                ChampDeTexte(label: "message", entréeNumérale: $newElGamalEncryption.message)
                ChampDeTexte(label: "n", entréeNumérale: $newElGamalEncryption.n)
                ChampDeTexte(label: "g", entréeNumérale: $newElGamalEncryption.g)
                ChampDeTexte(label: "r", entréeNumérale: $newElGamalEncryption.r)
                ChampDeTexte(label: "d", entréeNumérale: $newElGamalEncryption.d)
            }
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func displaySavedLabel(save: ElGamalEncryption) -> String {
        switch save.mode {
        case .encrypt: return "Le message \(save.message ?? 0) avec n = \(save.n ?? 0), g = \(save.g ?? 0), k = \(save.k ?? 0) et e = \(save.e ?? 0) est chiffré en"
        case .decrypt: return "Le message \(save.message ?? 0) avec n = \(save.n ?? 0), g = \(save.g ?? 0), r = \(save.r ?? 0) et d = \(save.d ?? 0) est chiffré en"
        }
    }
    
    func displaySavedResult(save: ElGamalEncryption) -> String {
        switch save.mode {
        case .encrypt:
            return "(r = \(save.result[0]), message chiffré = \(save.result[1]))"
        case .decrypt:
            if save.result[0] == -1 {
                return "Aucun déchiffrage possible"
            }
            return "\(save.result[0])"
        }
    }
}





#Preview {
    ElGamalEncryptionPage()
}
