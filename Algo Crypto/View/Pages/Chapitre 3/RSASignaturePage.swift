//
//  RSASignaturePage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 26/11/2023.
//

import SwiftUI
import SwiftData


struct RSASignaturePage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [RSASignature]
    @StateObject var newRSASignature = RSASignatureVM()
    var savesVM: [RSASignatureVM] {
        updateSavesVM()
    }
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<RSASignatureVM>(
            pageTitle: Pages().rsaSignature.pageName,
            saves: savesVM,
            newCalculation: newRSASignature,
            numberFields: AnyView(numberFields),
            minimumSavedItemCellSize: 250
        )
    }
    
    
    
    var numberFields: some View {
        VStack(spacing: 0) {
            InformationCell(messageTitle: "AVERTISSEMENT", content: "A = personne émettrice la signature\nB = personne réceptrice de la signature.\n\nSi dans l'exercice, B est l'émettrice de la signature, alors dA devient dB, eA -> eB, et nA -> nB. ", type: .warning)
            
            switch newRSASignature.mode {
            case .encrypt: numberFieldsCorrectKey
            case .decrypt: numberFieldsOppositeKey
            }
        }
    }
    
    
    var numberFieldsCorrectKey: some View {
        HStack(spacing: 0) {
            NumberField(label: "signature", placeholder: "1", input: $newRSASignature.signature)
            NumberField(label: "dA", placeholder: "1", input: $newRSASignature.dA)
            NumberField(label: "eB", placeholder: "1", input: $newRSASignature.eB)
            NumberField(label: "nA", placeholder: "1", input: $newRSASignature.nA)
            NumberField(label: "nB", placeholder: "1", input: $newRSASignature.nB)
            ACButton(label: "Décrypter", style: .tertiary) {
                newRSASignature.mode = .decrypt
            }
        }
    }
    
    
    var numberFieldsOppositeKey: some View {
        HStack(spacing: 0) {
            NumberField(label: "signature", placeholder: "1", input: $newRSASignature.signature)
            NumberField(label: "dB", placeholder: "1", input: $newRSASignature.dB)
            NumberField(label: "eA", placeholder: "1", input: $newRSASignature.eA)
            NumberField(label: "nA", placeholder: "1", input: $newRSASignature.nA)
            NumberField(label: "nB", placeholder: "1", input: $newRSASignature.nB)
            ACButton(label: "Encrypter", style: .tertiary) {
                newRSASignature.mode = .encrypt
            }
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func updateSavesVM() -> [RSASignatureVM] {
        var s: [RSASignatureVM] = []
        for save in self.saves {
            let newSaveVM = RSASignatureVM(model: save)
            s.append(newSaveVM)
        }
        return s
    }
}

#Preview {
    RSASignaturePage()
}
