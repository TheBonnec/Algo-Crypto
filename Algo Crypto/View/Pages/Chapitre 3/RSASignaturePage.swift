//
//  RSASignaturePage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 26/11/2023.
//

import SwiftUI
import CIUAisen
import SwiftData
import LaTeXSwiftUI



struct RSASignaturePage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [RSASignature]
    @StateObject var newRSASignature = RSASignatureVM()
    var rsaSignatureMods: [ElementDeSelecteur]
    @State var rsaSignatureMod: ElementDeSelecteur
    
    
    
    /* ----- Init ----- */
    
    init() {
        self.rsaSignatureMods = [ElementDeSelecteur(clé: "Encrypter"), ElementDeSelecteur(clé: "Decrypter")]
        self._rsaSignatureMod = State(initialValue: self.rsaSignatureMods[0])
    }
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        TypicalPage(title: Pages().rsaSignature.clé, newCalculation: newRSASignature, saves: saves, minimumSavesCellSize: 250) {
            inputs
        } results: {
            CelluleResultat(
                description: newRSASignature.displayLabel(),
                résultat: newRSASignature.displayResult()
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
                LaTeX("Pour calculer $d_A$ : entrer $e_A$ dans 'Clef d'origine' puis $\\phi(n)$\nPour calculer $e_A$ : entrer $d_A$ dans 'Clef d'origine' puis $\\phi(n)$")
                    .foregroundStyle(Color.texteSecondaire)
                Spacer()
            }
            .padding(.bottom, 24)
            
            
            switch newRSASignature.mode {
            case .encrypt: inputsEncrypt
            case .decrypt: inputsDecrypt
            }
        }
        .onChange(of: rsaSignatureMod) { _, _ in
            switch rsaSignatureMod.clé {
            case "Encrypter": self.newRSASignature.mode = .encrypt
            case "Decrypter": self.newRSASignature.mode = .decrypt
            default: self.newRSASignature.mode = .encrypt
            }
        }
    }
    
    
    var inputsEncrypt: some View {
        HStack(spacing: 16) {
            ChampDeTexte(label: "signature", entréeNumérale: $newRSASignature.signature)
            ChampDeTexte(label: "dA", entréeNumérale: $newRSASignature.dA)
            ChampDeTexte(label: "eB", entréeNumérale: $newRSASignature.eB)
            ChampDeTexte(label: "nA", entréeNumérale: $newRSASignature.nA)
            ChampDeTexte(label: "nB", entréeNumérale: $newRSASignature.nB)
        }
    }
    
    
    var inputsDecrypt: some View {
        HStack(spacing: 16) {
            ChampDeTexte(label: "signature", entréeNumérale: $newRSASignature.signature)
            ChampDeTexte(label: "dB", entréeNumérale: $newRSASignature.dB)
            ChampDeTexte(label: "eA", entréeNumérale: $newRSASignature.eA)
            ChampDeTexte(label: "nA", entréeNumérale: $newRSASignature.nA)
            ChampDeTexte(label: "nB", entréeNumérale: $newRSASignature.nB)
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func displaySavedLabel(save: RSASignature) -> String {
        switch save.mode {
        case .encrypt: return "La signature \(save.signature ?? 0) encryptée est"
        case .decrypt: return "La signature \(save.signature ?? 0) décryptée est"
        }
    }
    
    func displaySavedResult(save: RSASignature) -> String {
        return "\(save.result)"
    }
}





#Preview {
    RSASignaturePage()
}
