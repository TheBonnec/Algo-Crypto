//
//  RSAPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 26/11/2023.
//

import SwiftUI
import CIUAisen
import SwiftData
import LaTeXSwiftUI



struct RSAPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [RSA]
    @StateObject var newRSA = RSAVM()
    var rsaMods: [ElementDeSelecteur]
    @State var rsaMod: ElementDeSelecteur
    
    
    
    /* ----- Init ----- */
    
    init() {
        self.rsaMods = [ElementDeSelecteur(clé: "Bonne clé"), ElementDeSelecteur(clé: "Clé opposée")]
        self._rsaMod = State(initialValue: self.rsaMods[0])
    }
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        TypicalPage(title: Pages().rsa.clé, newCalculation: newRSA, saves: saves, minimumSavesCellSize: 250) {
            inputs
        } results: {
            CelluleResultat(
                description: newRSA.displayLabel(),
                résultat: newRSA.displayResult()
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
        VStack(spacing: 0) {
            switch newRSA.mode {
            case .correctKey: inputsCorrectKey
            case .oppositeKey: inputsOppositeKey
            }
        }
        .onChange(of: rsaMod) { _, _ in
            switch rsaMod.clé {
            case "Bonne clé": self.newRSA.mode = .correctKey
            case "Clé opposée": self.newRSA.mode = .oppositeKey
            default: self.newRSA.mode = .correctKey
            }
        }
    }
    
    
    var inputsCorrectKey: some View {
        VStack(spacing: 16) {
            HStack {
                // Informations
                VStack(alignment: .leading, spacing: 8) {
                    Text("Mode Bonne Clef")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    LaTeX("Pour calculer $d_A$ : entrer $e_A$ dans 'Clef d'origine' puis $\\phi(n)$\nPour calculer $e_A$ : entrer $d_A$ dans 'Clef d'origine' puis $\\phi(n)$")
                        .foregroundStyle(Color.texteSecondaire)
                }
                Spacer()
            }
            .padding(.bottom, 24)
            
            
            SelecteurDeroulant(options: rsaMods, selection: $rsaMod)
            
            HStack(spacing: 16) {
                ChampDeTexte(label: "message", entréeNumérale: $newRSA.message)
                ChampDeTexte(label: "bonne clef", entréeNumérale: $newRSA.correctKey)
                ChampDeTexte(label: "n", entréeNumérale: $newRSA.n)
            }
        }
    }
    
    
    var inputsOppositeKey: some View {
        VStack(spacing: 16) {
            HStack {
                // Informations
                VStack(alignment: .leading, spacing: 8) {
                    Text("Mode Clef Opposée")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    LaTeX("Ce mode est utile si vous ne connaissez pas $e_A$ pour encrypter, ou $d_A$ pour décrypter.\nPour encrypter le message, entrez $d_A$ dans le champs 'clef opposée'.\nPour déchiffrer le message, entrez $e_A$ dans le champs 'clef opposée'.")
                        .foregroundStyle(Color.texteSecondaire)
                }
                Spacer()
            }
            .padding(.bottom, 24)
            
            
            SelecteurDeroulant(options: rsaMods, selection: $rsaMod)
            
            HStack(spacing: 16) {
                ChampDeTexte(label: "message", entréeNumérale: $newRSA.message)
                ChampDeTexte(label: "clef opposée", entréeNumérale: $newRSA.oppositeKey)
                ChampDeTexte(label: "n", entréeNumérale: $newRSA.n)
            }
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func displaySavedLabel(save: RSA) -> String {
        switch save.mode {
        case .correctKey: return "Le message \(save.message ?? 0) encrypté / décrypté avec la clé \(save.correctKey ?? 0) est"
        case .oppositeKey: return "Le message \(save.message ?? 0) encrypté / décrypté avec la clé opposée \(save.correctKey ?? 0) est"
        }
    }
    
    func displaySavedResult(save: RSA) -> String {
        return "\(save.result)"
    }
}





#Preview {
    RSAPage()
}
