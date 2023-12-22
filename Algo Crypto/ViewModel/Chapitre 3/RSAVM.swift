//
//  RSAVM.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 26/11/2023.
//

import Foundation
import SwiftData
import SwiftUI
import Combine


class RSAVM: ObservableObject, CalculationVMProtocol {
    
    /* ----- Propriétés ----- */
    
    var id = UUID()
    
    @Published var mode: RSAMode
    @Published var message: Int?
    @Published var correctKey: Int?
    @Published var oppositeKey: Int?
    @Published var n: Int?
    private var model: RSA?
    var result: Int {
        calculate()
    }
    
    
    
    /* ----- Inits ----- */
    
    required init() {
        self.mode = .correctKey
        self.message = nil
        self.correctKey = nil
        self.oppositeKey = nil
        self.n = nil
        self.model = nil
    }
    
    init(model: RSA) {
        self.mode = model.mode
        self.message = model.message
        self.correctKey = model.correctKey
        self.oppositeKey = model.oppositeKey
        self.n = model.n
        self.model = model
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func calculate() -> Int {
        guard inputValidity() else { return -1 }
        
        switch mode {
        case .correctKey:
            let y = ModuloVM(x: message!, a: correctKey!, n: n!)
            return y.result
        case .oppositeKey:
            let y = PolynomialEquation(mode: .n, a: oppositeKey!, b: message!, n: n!)
            return y.result
        }
    }
    
    
    func inputValidity() -> Bool {
        switch mode {
        case .correctKey:
            guard self.correctKey != nil && self.correctKey! > 0 else { return false }
        case .oppositeKey:
            guard self.oppositeKey != nil && self.oppositeKey! > 0 else { return false }
        }
        guard self.message != nil && self.message! > 0 else { return false }
        guard self.n != nil && self.n! > 0 else { return false }
        return true
    }
    
    
    func resetInputs() {
        self.message = nil
        self.correctKey = nil
        self.oppositeKey = nil
        self.n = nil
        self.model = nil
    }
    
    
    func saveModel(context: ModelContext) -> Bool {
        guard inputValidity() else { return false }
        if model == nil {
            model = RSA(mode: mode, message: message, correctKey: correctKey, oppositeKey: oppositeKey, n: n, result: result)
        } else {
            model!.setEvery(mode: mode, message: message, correctKey: correctKey, oppositeKey: oppositeKey, n: n, result: result)
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
        switch mode {
        case .correctKey: return "Le message \(message ?? 0) encrypté / décrypté avec la clé \(correctKey ?? 0) est"
        case .oppositeKey: return "Le message \(message ?? 0) encrypté / décrypté avec la clé opposée \(correctKey ?? 0) est"
        }
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "InputError".localized() }
        return "\(result)"
    }
}
