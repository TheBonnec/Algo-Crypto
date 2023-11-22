//
//  CongruencePage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI
import SwiftData


struct CongruencePage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [Congruence]
    @StateObject var newCongruence = CongruenceVM()
    var savesVM: [CongruenceVM] {
        updateSavesVM()
    }
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<CongruenceVM>(
            pageTitle: Pages().congruence.pageName,
            saves: savesVM,
            newCalculation: newCongruence,
            numberFields: AnyView(numberFields),
            minimumSavedItemCellSize: 250
        )
    }
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            NumberField(label: "a", placeholder: "0", input: $newCongruence.a)
            NumberField(label: "p", placeholder: "1", input: $newCongruence.p)
            NumberField(label: "b", placeholder: "0", input: $newCongruence.b)
            NumberField(label: "q", placeholder: "1", input: $newCongruence.q)
            NumberField(label: "n", placeholder: "0", input: $newCongruence.n)
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func updateSavesVM() -> [CongruenceVM] {
        var s: [CongruenceVM] = []
        for save in self.saves {
            let newSaveVM = CongruenceVM(model: save)
            s.append(newSaveVM)
        }
        return s
    }
}





#Preview {
    CongruencePage()
}
