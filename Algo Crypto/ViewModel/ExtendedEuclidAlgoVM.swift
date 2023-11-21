//
//  ExtendedEuclidAlgoVM.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 20/11/2023.
//

import Foundation
import SwiftData
import SwiftUI
import Combine


class ExtendedEuclidAlgoVM: ObservableObject, CalculationVMProtocol {
    
    /* ----- Propriétés ----- */
    
    var id = UUID()
    
    @Published var a: Int?
    @Published var b: Int?
    private var model: ExtendedEuclidAlgo?
    var result: EEAResult {
        calculate()
    }
    
    
    
    /* ----- Inits ----- */
    
    required init() {
        self.a = nil
        self.b = nil
        self.model = nil
    }
    
    // TODO: Remplir result avec le résultat sauvegarder par le model
    init(model: ExtendedEuclidAlgo) {
        self.a = model.a
        self.b = model.b
        self.model = model
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func calculate() -> EEAResult {
        guard inputValidity() else {
            return EEAResult(u: -1, v: -1)
        }
        
        var u = 1
        var v = 0
        var u1 = 0
        var v1 = 1
        var r = a!
        var r1 = b!
        var q = 0
        
        while r1 > 0 {
            q = r / r1
            (u, u1) = (u1, u - q * u1)
            (v, v1) = (v1, v - q * v1)
            (r, r1) = (r1, r - q * r1)
        }
        
        return EEAResult(u: u, v: v, r: r, q: q)
    }
    
    
    func inputValidity() -> Bool {
        guard self.a != 0 && self.b != 0 else { return false }
        guard self.a != nil && self.b != nil else { return false }
        return true
    }
    
    
    func resetInputs() {
        self.a = nil
        self.b = nil
    }
    
    
    func saveModel(context: ModelContext) {
        guard inputValidity() else { return }
        if self.model == nil {
            let r = self.result
            self.model = ExtendedEuclidAlgo(a: self.a, b: self.b, u: r.u, v: r.v, r: r.r, q: r.q)
        } else {
            self.model!.a = self.a
            self.model!.b = self.b
            self.model!.u = self.result.u
            self.model!.v = self.result.v
            self.model!.r = self.result.r
            self.model!.q = self.result.q
        }
        context.insert(self.model!)
    }
    
    func deleteModel(context: ModelContext) {
        guard self.model != nil else { return }
        guard inputValidity() else { return }
        context.delete(self.model!)
    }
    
    
    func displayLabel() -> String {
        return "gcd(\(a ?? 0), \(b ?? 0))"
    }
    
    func displayResult() -> String {
        let r = self.result.r
        if r != nil {
            return "\(self.result.r!)"
        } else {
            return "Input Error"
        }
    }
    
    
    
    struct EEAResult {
        var u: Int
        var v: Int
        var r: Int?
        var q: Int?
    }
}
