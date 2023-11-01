//
//  ModuloView.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 31/10/2023.
//

import SwiftUI

struct ModuloView: View {
    
    @State var newModulo = Modulo()
    @Binding var page: Page
    
    
    var body: some View {
        CalculationPage<Modulo, HStack>(
            pageTitle: "Modulo",
            page: $page,
            newCalculation: $newModulo,
            numberFields: {
                HStack(spacing: 0) {
                    NumberField(placeholder: "x", input: $newModulo.x) {
                        newModulo.calculate()
                    }
                    NumberField(placeholder: "a", input: $newModulo.a) {
                        newModulo.calculate()
                    }
                    NumberField(placeholder: "n", input: $newModulo.n) {
                        newModulo.calculate()
                    }
                }
        },
            solutionSections: [SolutionSectionsData(label: "\(newModulo.x ?? 0)^\(newModulo.a ?? 0)[\(newModulo.n ?? 0)]", solution: newModulo.result)])
    }
}




#Preview {
    ModuloView(page: .constant(.modulo))
}
