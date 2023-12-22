//
//  ModuloVM.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 21/11/2023.
//

import Foundation
import SwiftData
import SwiftUI
import Combine


class ModuloVM: ObservableObject, CalculationVMProtocol {
    
    /* ----- Propriétés ----- */
    
    var id = UUID()
    
    @Published var x: Int?
    @Published var a: Int?
    @Published var n: Int?
    private var model: Modulo?
    var result: Int {
        calculate()
    }
    
    
    
    /* ----- Inits ----- */
    
    required init() {
        self.x = nil
        self.a = nil
        self.n = nil
        self.model = nil
    }
    
    init(x: Int?, a: Int?, n: Int?) {
        self.x = x
        self.a = a
        self.n = n
        self.model = nil
    }
    
    init(model: Modulo) {
        self.x = model.x
        self.a = model.a
        self.n = model.n
        self.model = model
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func calculate() -> Int {
        if model != nil { return model!.result }
        guard inputValidity() else { return -1 }
        
        var r = 1
        var base = x! % n!
        var exp = a!
        
        while exp > 0 {
            if exp % 2 == 1 {
                r = (r * base) % n!
            }
            
            base = (base * base) % n!
            exp /= 2
        }
        
        // Si résultat négatif
        if r < 0 {
            r = (r + n!) % n!
        }
        
        return r
    }
    
    
    func inputValidity() -> Bool {
        guard self.x != nil && self.a != nil && self.n != nil else { return false }
        guard self.a! > 0 && self.n! > 0 else { return false }
        return true
    }
    
    
    func resetInputs() {
        self.x = nil
        self.a = nil
        self.n = nil
        self.model = nil
    }
    
    
    func saveModel(context: ModelContext)  -> Bool {
        guard inputValidity() else { return false }
        if model == nil {
            model = Modulo(x: x, a: a, n: n, result: result)
        } else {
            model!.setEvery(x: x, a: a, n: n, result: result)
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
        return "$\(x ?? 0)^{\(a ?? 0)}[\(n ?? 0)]$"
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "InputError".localized() }
        return "\(result)[\(n!)]"
    }
}
