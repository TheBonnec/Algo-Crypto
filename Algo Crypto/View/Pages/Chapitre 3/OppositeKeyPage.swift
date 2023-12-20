//
//  OppositeKeyPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 26/11/2023.
//

import SwiftUI
import SwiftData
import LaTeXSwiftUI


struct OppositeKeyPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [OppositeKey]
    @StateObject var newOppositeKey = OppositeKeyVM()
    var savesVM: [OppositeKeyVM] {
        updateSavesVM()
    }
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<OppositeKeyVM>(
            pageTitle: Pages().oppositeKey.pageName,
            saves: savesVM,
            newCalculation: newOppositeKey,
            numberFields: AnyView(numberFields),
            minimumSavedItemCellSize: 250
        )
    }
    
    
    
    var numberFields: some View {
        VStack {
            InformationCell(messageTitle: nil, content: "Pour calculer $d_A$ : entrer $e_A$ dans 'Clef d'origine' puis $\\phi(n)$\nPour calculer $e_A$ : entrer $d_A$ dans 'Clef d'origine' puis $\\phi(n)$")
            
            let isSolutionExisting = newOppositeKey.isSolutionExisting()
            if isSolutionExisting == -1 {
                InformationCell(messageTitle: "AVERTISSEMENT", content: "Les nombres entrés sont trop grands. $e \\times d ≡ 1[\\phi(n)]$ n'a pas pu être calculé. Il est possible que la clef calculé ne soit pas valide.", type: .warning)
            } else if isSolutionExisting != 1 {
                InformationCell(messageTitle: "AVERTISSEMENT", content: "$e \\times d$ n'est pas égal à $1[\\phi(n)]$.\nCela indique que $e$ ou $d$ n'est pas valide.", type: .warning)
            }
            
            HStack(spacing: 0) {
                NumberField(label: "Clef d'origine", placeholder: "1", input: $newOppositeKey.originalKey)
                NumberField(label: "φ(n)", placeholder: "1", input: $newOppositeKey.phi)
            }
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func updateSavesVM() -> [OppositeKeyVM] {
        var s: [OppositeKeyVM] = []
        for save in self.saves {
            let newSaveVM = OppositeKeyVM(model: save)
            s.append(newSaveVM)
        }
        return s
    }
}






#Preview {
    OppositeKeyPage()
}
