//
//  ExtendedEuclidAlgoVM.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 21/11/2023.
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
    
    init(a: Int?, b: Int?) {
        self.a = a
        self.b = b
        self.model = nil
    }
    
    init(model: ExtendedEuclidAlgo) {
        self.a = model.a
        self.b = model.b
        self.model = model
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func calculate() -> EEAResult {
        if model != nil {
            let eeaResult = EEAResult(u: model!.u, v: model!.v, r: model!.r, q: model!.q)
            return eeaResult
        }
        guard inputValidity() else { return EEAResult(u: -1, v: -1, r: -1, q: -1) }
        
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
        guard a != nil && b != nil else { return false }
        guard a != 0 && b != 0 else { return false }
        return true
    }
    
    
    func resetInputs() {
        self.a = nil
        self.b = nil
        self.model = nil
    }
    
    
    func saveModel(context: ModelContext) -> Bool {
        guard inputValidity() else { return false }
        if model == nil {
            model = ExtendedEuclidAlgo(a: a, b: b, u: result.u, v: result.v, r: result.r, q: result.r)
        } else {
            model!.setEvery(a: a, b: b, u: result.u, v: result.v, r: result.r, q: result.r)
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
        return "\("gcd".localized())(\(a ?? 0), \(b ?? 0))"
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "InputError".localized() }
        return "\(result.r ?? 0)"
    }
    
    
    
    /* ----- Structs ----- */
    
    struct EEAResult {
        var u: Int
        var v: Int
        var r: Int?
        var q: Int?
    }
}
