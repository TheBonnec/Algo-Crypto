//
//  EuclidAlgoPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 12/11/2023.
//

import SwiftUI
import SwiftData


struct EuclidAlgoPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [EuclidAlgo]
    @StateObject var newEuclidAlgo = EuclidAlgoVM()
    var savesVM: [EuclidAlgoVM] {
        updateSavesVM()
    }
    
    /*
    init() {
        self._saves = Query()
        for save in self.saves {
            let newSaveVM = EuclidAlgoVM(model: save)
            self.savesVM.append(newSaveVM)
        }
    }
    */
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<EuclidAlgoVM>(
            pageTitle: "Euclidean Algorithm - GCD", 
            saves: savesVM,
            newCalculation: newEuclidAlgo,
            numberFields: AnyView(numberFields),
            minimumSavedItemCellSize: 150
        )
    }
    
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            NumberField(label: "a", placeholder: "0", input: $newEuclidAlgo.a)
            NumberField(label: "b", placeholder: "0", input: $newEuclidAlgo.b)
        }
    }
    
    
    
    func updateSavesVM() -> [EuclidAlgoVM] {
        var s: [EuclidAlgoVM] = []
        for save in self.saves {
            let newSaveVM = EuclidAlgoVM(model: save)
            s.append(newSaveVM)
        }
        return s
    }
}





#Preview {
    EuclidAlgoPage()
}
