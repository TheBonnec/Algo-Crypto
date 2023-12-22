//
//  InverseInZVM.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 21/11/2023.
//

import Foundation
import SwiftData
import SwiftUI
import Combine


class InverseInZVM: ObservableObject, CalculationVMProtocol {
    
    /* ----- Propriétés ----- */
    
    var id = UUID()
    
    @Published var a: Int?
    @Published var n: Int?
    private var model: InverseInZ?
    var inverse: Int {
        calculate()
    }
    
    
    
    /* ----- Inits ----- */
    
    required init() {
        self.a = nil
        self.n = nil
        self.model = nil
    }
    
    init(a: Int?, n: Int?) {
        self.a = a
        self.n = n
        self.model = nil
    }
    
    init(model: InverseInZ) {
        self.a = model.a
        self.n = model.n
        self.model = model
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func calculate() -> Int {
        if model != nil { return model!.inverse }
        guard inputValidity() else { return -1 }
        guard self.a! < self.n! else { return -1 }
        
        let extendedEA = ExtendedEuclidAlgoVM(a: a, b: n)
        
        guard extendedEA.result.r == 1 else { return -1 }
        return (extendedEA.result.u + n!) % n!
    }
    
    
    func inputValidity() -> Bool {
        guard a != nil && n != nil else { return false }
        guard a! >= 0 && n! > 0 else { return false }
        return true
    }
    
    
    func resetInputs() {
        self.a = nil
        self.n = nil
        self.model = nil
    }
    
    
    func saveModel(context: ModelContext) -> Bool {
        guard inputValidity() else { return false }
        if model == nil {
            model = InverseInZ(a: a,n: n, inverse: inverse)
        } else {
            model!.setEvery(a: a,n: n, inverse: inverse)
        }
        context.insert(model!)
        return true
    }
    
    func deleteModel(context: ModelContext) {
        guard self.model != nil else { return }
        guard inputValidity() else { return }
        context.delete(self.model!)
    }
    
    
    func displayLabel() -> String {
        return "\("InverseOf".localized()) \(a ?? 0) \("in".localized()) $\\frac{\\mathbb{Z}}{\(n ?? 0)\\mathbb{Z}}$"
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "InputError".localized() }
        
        if inverse == -1 {
            return "No inverse for \(a!)"
        } else if inverse == -2 {
            return "No inverse for $a \\geq n$"
        }
        return "\(inverse)"
    }
}
