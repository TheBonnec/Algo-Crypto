//
//  ElGamalEncryptionVM.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 22/12/2023.
//

import Foundation
import SwiftData
import SwiftUI
import Combine


class ElGamalEncryptionVM: ObservableObject, CalculationVMProtocol {
    
    /* ----- Propriétés ----- */
    
    var id = UUID()
    
    @Published var mode: ElGamalEncryptionMode
    @Published var message: Int?
    @Published var n: Int?
    @Published var g: Int?
    @Published var k: Int?
    @Published var r: Int?
    @Published var e: Int?
    @Published var d: Int?
    private var model: ElGamalEncryption?
    var result: [Int] {
        switch self.mode {
        case .encrypt: calculateEncrypt()
        case .decrypt: calculateDecrypt()
        }
    }
    
    
    
    /* ----- Inits ----- */
    
    required init() {
        self.mode = .encrypt
        self.message = nil
        self.n = nil
        self.g = nil
        self.k = nil
        self.r = nil
        self.e = nil
        self.d = nil
        self.model = nil
    }
    
    init(model: ElGamalEncryption) {
        self.mode = model.mode
        self.message = model.message
        self.n = model.n
        self.g = model.g
        self.k = model.k
        self.r = model.r
        self.e = model.e
        self.d = model.d
        self.model = model
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func calculateEncrypt() -> [Int] {
        guard inputValidity() else { return [] }
        
        let r = ModuloVM(x: g!, a: k!, n: n!).result
        let messageChiffré = ModuloVM(x: (message! * ModuloVM(x: e!, a: k!, n: n!).result), a: 1, n: n!).result
        return [r, messageChiffré]
    }
    
    
    func calculateDecrypt() -> [Int] {
        guard inputValidity() else { return [] }
        
        func modInverse(b: Int, m: Int) -> Int? {
            var a = b % m
            for x in 1..<m {
                if (a * x) % m == 1 {
                    return x
                }
            }
            return nil  // Aucun inverse modulaire si cette ligne est atteinte
        }
        
        // Calculer l'inverse modulaire de r^dA mod p
        let s = ModuloVM(x: r!, a: d!, n: n!).result
        let sInverse = modInverse(b: s, m: n!)
        
        // Déchiffrer le message
        if sInverse != nil {
            let m = ModuloVM(x: (message! * sInverse!), a: 1, n: n!).result
            return [m]
        }
        return [-1]
    }
    
    
    func inputValidity() -> Bool {
        guard self.message != nil && self.message! >= 0 else { return false }
        guard self.n != nil && self.n! > 0 else { return false }
        guard self.g != nil && self.g! > 1 else { return false }
        
        switch mode {
        case .encrypt:
            guard self.k != nil && self.k! > 0 else { return false }
            guard self.e != nil && self.e! > 0 else { return false }
        case .decrypt:
            guard self.r != nil && self.r! >= 0 else { return false }
            guard self.d != nil && self.d! > 0 else { return false }
        }
        return true
    }
    
    
    func resetInputs() {
        self.mode = .encrypt
        self.message = nil
        self.n = nil
        self.g = nil
        self.k = nil
        self.r = nil
        self.e = nil
        self.d = nil
        self.model = nil
    }
    
    
    func saveModel(context: ModelContext) -> Bool {
        guard inputValidity() else { return false }
        if model == nil {
            model = ElGamalEncryption(mode: mode, message: message, n: n, g: g, k: k, r: r, e: e, d: d, result: result)
        } else {
            model!.setEvery(mode: mode, message: message, n: n, g: g, k: k, r: r, e: e, d: d, result: result)
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
        case .encrypt: return "Le message \(message ?? 0) avec n = \(n ?? 0), g = \(g ?? 0), k = \(k ?? 0) et e = \(e ?? 0) est chiffré en"
        case .decrypt: return "Le message \(message ?? 0) avec n = \(n ?? 0), g = \(g ?? 0), r = \(r ?? 0) et d = \(d ?? 0) est chiffré en"
        }
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "InputError".localized() }
        switch mode {
        case .encrypt:
            return "(r = \(result[0]), message chiffré = \(result[1]))"
        case .decrypt:
            if result[0] == -1 {
                return "Aucun déchiffrage possible"
            }
            return "\(result[0])"
        }
    }
}
