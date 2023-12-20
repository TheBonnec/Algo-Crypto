//
//  PrimeFactorsPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 25/11/2023.
//

import SwiftUI
import SwiftData


struct PrimeFactorsPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [PrimeFactors]
    @StateObject var newEuclidAlgo = PrimeFactorsVM()
    var savesVM: [PrimeFactorsVM] {
        updateSavesVM()
    }
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<PrimeFactorsVM>(
            pageTitle: Pages().primeFactors.pageName,
            saves: savesVM,
            newCalculation: newEuclidAlgo,
            numberFields: AnyView(numberFields),
            minimumSavedItemCellSize: 250
        )
    }
    
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            NumberField(label: "n", placeholder: "2", input: $newEuclidAlgo.n)
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func updateSavesVM() -> [PrimeFactorsVM] {
        var s: [PrimeFactorsVM] = []
        for save in self.saves {
            let newSaveVM = PrimeFactorsVM(model: save)
            s.append(newSaveVM)
        }
        return s
    }
}





#Preview {
    PrimeFactorsPage()
}
