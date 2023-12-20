//
//  RSAPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 26/11/2023.
//

import SwiftUI
import SwiftData


struct RSAPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [RSA]
    @StateObject var newRSA = RSAVM()
    var savesVM: [RSAVM] {
        updateSavesVM()
    }
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<RSAVM>(
            pageTitle: Pages().rsa.pageName,
            saves: savesVM,
            newCalculation: newRSA,
            numberFields: AnyView(numberFields),
            minimumSavedItemCellSize: 250
        )
    }
    
    
    
    var numberFields: some View {
        VStack(spacing: 0) {
            switch newRSA.mode {
            case .correctKey: numberFieldsCorrectKey
            case .oppositeKey: numberFieldsOppositeKey
            }
        }
    }
    
    
    var numberFieldsCorrectKey: some View {
        VStack {
            InformationCell(messageTitle: "Mode Bonne Clef", content: "Pour encrypter le message, entrez $e_A$ dans le champs 'bonne clef'.\nPour déchiffrer le message, entrez $d_A$ dans le champs 'bonne clef'.")
            
            HStack(spacing: 0) {
                NumberField(label: "message", placeholder: "1", input: $newRSA.message)
                NumberField(label: "bonne clef", placeholder: "1", input: $newRSA.correctKey)
                NumberField(label: "n", placeholder: "1", input: $newRSA.n)
                ACButton(label: "Calculer avec la clé opposée", style: .tertiary) {
                    newRSA.mode = .oppositeKey
                }
            }
        }
    }
    
    
    var numberFieldsOppositeKey: some View {
        VStack {
            InformationCell(messageTitle: "Mode Clef Opposée", content: "Ce mode est utile si vous ne connaissez pas $e_A$ pour encrypter, ou $d_A$ pour décrypter.\nPour encrypter le message, entrez $d_A$ dans le champs 'clef opposée'.\nPour déchiffrer le message, entrez $e_A$ dans le champs 'clef opposée'.")
            
            HStack(spacing: 0) {
                NumberField(label: "message", placeholder: "1", input: $newRSA.message)
                NumberField(label: "clef opposée", placeholder: "1", input: $newRSA.oppositeKey)
                NumberField(label: "n", placeholder: "1", input: $newRSA.n)
                ACButton(label: "Calculer avec la bonne clé", style: .tertiary) {
                    newRSA.mode = .correctKey
                }
            }
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func updateSavesVM() -> [RSAVM] {
        var s: [RSAVM] = []
        for save in self.saves {
            let newSaveVM = RSAVM(model: save)
            s.append(newSaveVM)
        }
        return s
    }
}





#Preview {
    RSAPage()
}
