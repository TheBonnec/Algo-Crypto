//
//  EquivalenceClassPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI
import SwiftData


struct EquivalenceClassPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [EquivalenceClass]
    @StateObject var newEquivalence = EquivalenceClassVM()
    var savesVM: [EquivalenceClassVM] {
        updateSavesVM()
    }
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<EquivalenceClassVM>(
            pageTitle: Pages().equivalenceClass.pageName,
            saves: savesVM,
            newCalculation: newEquivalence,
            numberFields: AnyView(numberFields),
            minimumSavedItemCellSize: 400
        )
    }
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            NumberField(label: "a", placeholder: "0", input: $newEquivalence.a)
            NumberField(label: "n", placeholder: "0", input: $newEquivalence.n)
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func updateSavesVM() -> [EquivalenceClassVM] {
        var s: [EquivalenceClassVM] = []
        for save in self.saves {
            let newSaveVM = EquivalenceClassVM(model: save)
            s.append(newSaveVM)
        }
        return s
    }
}





#Preview {
    EquivalenceClassPage()
}
