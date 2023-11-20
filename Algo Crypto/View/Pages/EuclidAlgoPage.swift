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
    
    @State var newEuclidAlgo = EuclidAlgo()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<EuclidAlgo>(
            pageTitle: "Euclidean Algorithm - GCD",
            newCalculation: $newEuclidAlgo,
            numberFields: AnyView(numberFields),
            minimumSavedItemCellSize: 150
        )
    }
    
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            NumberField(label: "a", placeholder: "0", input: $newEuclidAlgo.a) {
                self.newEuclidAlgo.calculate()
            }
            NumberField(label: "b", placeholder: "0", input: $newEuclidAlgo.b) {
                self.newEuclidAlgo.calculate()
            }
        }
    }
}





#Preview {
    EuclidAlgoPage()
}
