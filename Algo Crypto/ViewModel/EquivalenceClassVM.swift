//
//  EquivalenceClassVM.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 21/11/2023.
//

import Foundation
import SwiftData
import SwiftUI
import Combine


class EquivalenceClassVM: ObservableObject, CalculationVMProtocol {
    
    /* ----- Propriétés ----- */
    
    var id = UUID()
    
    @Published var a: Int?
    @Published var n: Int?
    private var model: EquivalenceClass?
    var equivalences: [Int] {
        calculate()
    }
    
    
    
    /* ----- Inits ----- */
    
    required init() {
        self.a = nil
        self.n = nil
        self.model = nil
    }
    
    init(model: EquivalenceClass) {
        self.a = model.a
        self.n = model.n
        self.model = model
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func calculate() -> [Int] {
        if model != nil { return model!.equivalences }
        guard inputValidity() else { return [] }
        
        let limit = 4 * n!
        var eq: [Int] = []
        
        for i in 1..<limit {
            if i % n! == a! {
                eq.append(i)
            }
        }
        
        return eq
    }
    
    
    func inputValidity() -> Bool {
        guard a != nil && n != nil else { return false }
        guard a! > 0 && n! > 0 else { return false }
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
            model = EquivalenceClass(a: a, n: n, equivalences: equivalences)
        } else {
            model!.setEvery(a: a, n: n, equivalences: equivalences)
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
        return "\("in".localized())  $\\frac{\\mathbb{Z}}{\(n ?? 0)\\mathbb{Z}}$"
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "Input Error" }
        
        if a! < n! {
            var equivalenceText = ""
            for e in equivalences {
                equivalenceText += "\(e), "
            }
            return "$\\bar{\(a!)} = [\(equivalenceText)...]$"
        }
        return "Pas de solution pour a > n"
    }
}
