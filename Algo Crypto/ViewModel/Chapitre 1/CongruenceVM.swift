//
//  CongruenceVM.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 21/11/2023.
//

import Foundation
import SwiftData
import SwiftUI
import Combine


class CongruenceVM: ObservableObject, CalculationVMProtocol {
    
    /* ----- Propriétés ----- */
    
    var id = UUID()
    
    @Published var a: Int?
    @Published var p: Int?
    @Published var b: Int?
    @Published var q: Int?
    @Published var n: Int?
    private var model: Congruence?
    var result: Int {
        calculate()
    }
    
    
    
    /* ----- Inits ----- */
    
    required init() {
        self.a = nil
        self.p = nil
        self.b = nil
        self.q = nil
        self.n = nil
        self.model = nil
    }
    
    init(model: Congruence) {
        self.a = model.a
        self.p = model.p
        self.b = model.b
        self.q = model.q
        self.n = model.n
        self.model = model
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func calculate() -> Int {
        if model != nil { return model!.result }
        guard inputValidity() else { return -1 }
        
        var r = 0
        
        let moduloA = ModuloVM(x: a!, a: p!, n: n!)
        let moduloB = ModuloVM(x: b!, a: q!, n: n!)
        
        let mA = moduloA.result
        let mB = moduloB.result
        
        
        let eea = ExtendedEuclidAlgoVM(a: mA, b: n!)
        
        if eea.result.r != nil && eea.result.r! != 0 {
            let tempResult: Double = Double(mB * eea.result.u) / Double(eea.result.r!)
            if floor(tempResult) == tempResult {
                r = Int(tempResult) % n!
                if r < 0 {
                    r = n! + r
                }
            } else {
                r = -2
            }
        } else {
            r = -2
        }
        
        return r
    }
    
    
    func inputValidity() -> Bool {
        guard self.a != nil && self.p != nil && self.b != nil && self.q != nil && self.n != nil else { return false }
        guard self.p! > 0 && self.q! > 0 && self.n! > 1 else { return false }
        return true
    }
    
    
    func resetInputs() {
        self.a = nil
        self.p = nil
        self.b = nil
        self.q = nil
        self.n = nil
        self.model = nil
    }
    
    
    func saveModel(context: ModelContext) -> Bool {
        guard inputValidity() else { return false }
        if model == nil {
            model = Congruence(a: a, p: p, b: b, q: q, n: n, result: result)
        } else {
            model!.setEvery(a: a, p: p, b: b, q: q, n: n, result: result)
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
        return "$\(a ?? 0)^{\(p ?? 0)} \\times x ≡ \(b ?? 0)^{\(q ?? 0)}[\(n ?? 0)]$"
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "InputError".localized() }
        
        if result == -444 {
            return "Aucune solution"
        }
        return "x = \(result)"
    }
}
