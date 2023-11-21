//
//  ExtendedEuclidAlgoPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 14/11/2023.
//

import SwiftUI
import SwiftData


struct ExtendedEuclidAlgoPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [ExtendedEuclidAlgo]
    @State var newExtendedEuclidAlgo = ExtendedEuclidAlgoVM()
    var savesVM: [ExtendedEuclidAlgoVM]
    
    
    init() {
        self.savesVM = []
        for save in self.saves {
            let newSaveVM = ExtendedEuclidAlgoVM(model: save)
            self.savesVM.append(newSaveVM)
        }
    }
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<ExtendedEuclidAlgoVM>(
            pageTitle: "Extended Euclidean Algorithm", 
            saves: savesVM,
            newCalculation: newExtendedEuclidAlgo,
            numberFields: AnyView(numberFields),
            customSolutionCells: [SolutionCell(content: AnyView(customSolutionCell))],
            minimumSavedItemCellSize: 150
        )
    }
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            NumberField(label: "a", placeholder: "0", input: $newExtendedEuclidAlgo.a)
            NumberField(label: "b", placeholder: "0", input: $newExtendedEuclidAlgo.b)
        }
    }
    
    
    var customSolutionCell: some View {
        Text("u\t\(newExtendedEuclidAlgo.result.u)\nv\t\(newExtendedEuclidAlgo.result.v)\nr\t\(newExtendedEuclidAlgo.result.r ?? 0)\nq\t\(newExtendedEuclidAlgo.result.q ?? 0)")
            .font(.title)
            .fontWeight(.bold)
    }
}




#Preview {
    ExtendedEuclidAlgoPage()
}
