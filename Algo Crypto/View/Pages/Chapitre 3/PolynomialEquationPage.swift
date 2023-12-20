//
//  PolynomialEquationPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 26/11/2023.
//

import SwiftUI
import SwiftData


struct PolynomialEquationPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [PolynomialEquation]
    @StateObject var newPolynomial = PolynomialEquationVM()
    var savesVM: [PolynomialEquationVM] {
        updateSavesVM()
    }
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<PolynomialEquationVM>(
            pageTitle: Pages().polynomialEquation.pageName,
            saves: savesVM,
            newCalculation: newPolynomial,
            numberFields: AnyView(numberFields),
            minimumSavedItemCellSize: 250
        )
    }
    
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            switch newPolynomial.mode {
            case .n:
                NumberField(label: "a", placeholder: "1", input: $newPolynomial.a)
                NumberField(label: "b", placeholder: "0", input: $newPolynomial.b)
                NumberField(label: "n", placeholder: "1", input: $newPolynomial.n)
                ACButton(label: "Calculer avec p et q", style: .tertiary) {
                    newPolynomial.mode = .pq
                }
            case .pq:
                NumberField(label: "a", placeholder: "1", input: $newPolynomial.a)
                NumberField(label: "b", placeholder: "0", input: $newPolynomial.b)
                NumberField(label: "p", placeholder: "1", input: $newPolynomial.p)
                NumberField(label: "q", placeholder: "1", input: $newPolynomial.q)
                ACButton(label: "Calculer avec n", style: .tertiary) {
                    newPolynomial.mode = .n
                }
            }
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func updateSavesVM() -> [PolynomialEquationVM] {
        var s: [PolynomialEquationVM] = []
        for save in self.saves {
            let newSaveVM = PolynomialEquationVM(model: save)
            s.append(newSaveVM)
        }
        return s
    }
}





#Preview {
    PolynomialEquationPage()
}
