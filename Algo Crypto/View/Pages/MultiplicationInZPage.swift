//
//  MultiplicationInZPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI

struct MultiplicationInZPage: View {
    
    /* ----- Propriétés ----- */
    
    @State var newMultiplication = MultiplicationInZ()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<MultiplicationInZ>(
            pageTitle: "Multiplication in Z/nZ",
            newCalculation: $newMultiplication,
            numberFields: AnyView(numberFields),
            minimumSavedItemCellSize: 150
        )
    }
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            NumberField(label: "a", placeholder: "0", input: $newMultiplication.a) {
                newMultiplication.calculate()
            }
            NumberField(label: "b", placeholder: "0", input: $newMultiplication.b) {
                newMultiplication.calculate()
            }
            NumberField(label: "n", placeholder: "1", input: $newMultiplication.n) {
                newMultiplication.calculate()
            }
        }
    }
}





#Preview {
    MultiplicationInZPage()
}
