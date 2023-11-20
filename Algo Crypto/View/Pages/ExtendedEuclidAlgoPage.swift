//
//  ExtendedEuclidAlgoPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 14/11/2023.
//

import SwiftUI

struct ExtendedEuclidAlgoPage: View {
    
    /* ----- Propriétés ----- */
    
    @State var newExtendedEuclidAlgo = ExtendedEuclidAlgo()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<ExtendedEuclidAlgo>(
            pageTitle: "Extended Euclidean Algorithm",
            newCalculation: $newExtendedEuclidAlgo,
            numberFields: AnyView(numberFields),
            customSolutionCells: [SolutionCell(content: AnyView(customSolutionCell))],
            minimumSavedItemCellSize: 150
        )
    }
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            NumberField(label: "a", placeholder: "0", input: $newExtendedEuclidAlgo.a, onChangeAction: {
                newExtendedEuclidAlgo.calculate()
            })
            NumberField(label: "b", placeholder: "0", input: $newExtendedEuclidAlgo.b, onChangeAction: {
                newExtendedEuclidAlgo.calculate()
            })
        }
    }
    
    
    var customSolutionCell: some View {
        Text("u\t\(newExtendedEuclidAlgo.u)\nv\t\(newExtendedEuclidAlgo.v)\nr\t\(newExtendedEuclidAlgo.r ?? 0)\nq\t\(newExtendedEuclidAlgo.q ?? 0)")
            .font(.title)
            .fontWeight(.bold)
    }
}




#Preview {
    ExtendedEuclidAlgoPage()
}
