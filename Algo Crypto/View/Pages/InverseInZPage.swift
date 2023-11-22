//
//  InverseInZPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI
import SwiftData


struct InverseInZPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [InverseInZ]
    @StateObject var newInverse = InverseInZVM()
    var savesVM: [InverseInZVM] {
        updateSavesVM()
    }
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<InverseInZVM>(
            pageTitle: Pages().inverseInZ.pageName,
            saves: savesVM,
            newCalculation: newInverse,
            numberFields: AnyView(numberFields),
            minimumSavedItemCellSize: 250
        )
    }
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            NumberField(label: "a", placeholder: "0", input: $newInverse.a)
            NumberField(label: "n", placeholder: "1", input: $newInverse.n)
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func updateSavesVM() -> [InverseInZVM] {
        var s: [InverseInZVM] = []
        for save in self.saves {
            let newSaveVM = InverseInZVM(model: save)
            s.append(newSaveVM)
        }
        return s
    }
}





#Preview {
    InverseInZPage()
}
