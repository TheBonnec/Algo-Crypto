//
//  MultiplicationInZVM.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 21/11/2023.
//

import Foundation
import SwiftData
import SwiftUI
import Combine


class MultiplicationInZVM: ObservableObject, CalculationVMProtocol {
    
    /* ----- Propriétés ----- */
    
    var id = UUID()
    
    @Published var a: Int?
    @Published var b: Int?
    @Published var n: Int?
    private var model: MultiplicationInZ?
    var result: Int {
        calculate()
    }
    
    
    
    /* ----- Inits ----- */
    
    required init() {
        self.a = nil
        self.b = nil
        self.n = nil
        self.model = nil
    }
    
    init(model: MultiplicationInZ) {
        self.a = model.a
        self.b = model.b
        self.n = model.n
        self.model = model
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func calculate() -> Int {
        if model != nil { return model!.result }
        guard inputValidity() else { return -1 }
        
        let am = a! % n!
        let bm = b! % n!
        return (am * bm) % n!
    }
    
    
    func inputValidity() -> Bool {
        guard self.a != nil && self.b != nil && self.n != nil else { return false }
        guard self.a! >= 0 && self.b! >= 0 && self.n! > 0 else { return false }
        return true
    }
    
    
    func resetInputs() {
        self.a = nil
        self.b = nil
        self.n = nil
        self.model = nil
    }
    
    
    func saveModel(context: ModelContext) -> Bool {
        guard inputValidity() else { return false }
        if model == nil {
            model = MultiplicationInZ(a: a, b: b, n: n, result: result)
        } else {
            model!.setEvery(a: a, b: b, n: n, result: result)
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
        return "$\\bar{\(a ?? 0)} ⊗ \\bar{\(b ?? 0)}$"
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "InputError".localized() }
        return "$\\bar{\(result)}$"
    }
}

