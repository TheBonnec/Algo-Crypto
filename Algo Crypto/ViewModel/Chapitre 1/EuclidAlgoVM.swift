//
//  EuclidAlgoVM.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 21/11/2023.
//

import Foundation
import SwiftData
import SwiftUI
import Combine


class EuclidAlgoVM: ObservableObject, CalculationVMProtocol {
    
    /* ----- Propriétés ----- */
    
    var id = UUID()
    
    @Published var a: Int?
    @Published var b: Int?
    private var model: EuclidAlgo?
    var result: Int {
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
    
    init(model: EuclidAlgo) {
        self.a = model.a
        self.b = model.b
        self.model = model
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func calculate() -> Int {
        if model != nil { return model!.r }
        guard inputValidity() else { return -1 }
        
        // x et y sont des copies de a et b, car r et q sont toujours calculés et n'ont jamais besoin d'être stockés (q inutile, et r = a % b)
        var x = self.a!
        var y = self.b!
        var r = 1
        
        while r > 0 {
            r = x % y
            x = y
            y = r
        }
        return x
    }
    
    
    func inputValidity() -> Bool {
        guard self.a != nil && self.b != nil else { return false }
        guard self.a != 0 && self.b != 0 else { return false }
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
            model = EuclidAlgo(a: a!, b: b!, r: result)
        } else {
            model!.setEvery(a: a!, b: b!, r: result)
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
        return "\(self.result)"
    }
}
