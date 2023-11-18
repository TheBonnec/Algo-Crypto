//
//  LinearEquationsPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI

struct LinearEquationInZPage: View {
    
    /* ----- Propriétés ----- */
    
    @State var newEquationSolver = LinearEquationInZ()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<LinearEquationInZ>(
            pageTitle: "Linear Equations Solver in Z/nZ",
            newCalculation: $newEquationSolver,
            numberFields: AnyView(numberFields)
        )
    }
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            NumberField(label: "a", placeholder: "0", input: $newEquationSolver.a) {
                newEquationSolver.calculate()
            }
            NumberField(label: "b", placeholder: "0", input: $newEquationSolver.b) {
                newEquationSolver.calculate()
            }
            NumberField(label: "n", placeholder: "0", input: $newEquationSolver.n) {
                newEquationSolver.calculate()
            }
        }
    }
}





#Preview {
    LinearEquationInZPage()
}
