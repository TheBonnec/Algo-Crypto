//
//  LinearEquationInZPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI

struct LinearEquationInZPage: View {
    
    /* ----- Propriétés ----- */
    
    @State var newLinearEquation = LinearEquationInZ()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<LinearEquationInZ>(
            pageTitle: "Linear Equation in Z/nZ",
            newCalculation: $newLinearEquation,
            numberFields: AnyView(numberFields),
            minimumSavedItemCellSize: 400
        )
    }
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            NumberField(label: "a", placeholder: "0", input: $newLinearEquation.a) {
                newLinearEquation.calculate()
            }
            NumberField(label: "b", placeholder: "0", input: $newLinearEquation.b) {
                newLinearEquation.calculate()
            }
            NumberField(label: "n", placeholder: "0", input: $newLinearEquation.n) {
                newLinearEquation.calculate()
            }
        }
    }
}





#Preview {
    LinearEquationInZPage()
}
