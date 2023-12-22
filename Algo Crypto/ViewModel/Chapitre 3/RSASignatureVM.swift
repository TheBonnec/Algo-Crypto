//
//  RSASignatureVM.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 26/11/2023.
//

import Foundation
import SwiftData
import SwiftUI
import Combine


class RSASignatureVM: ObservableObject, CalculationVMProtocol {
    
    /* ----- Propriétés ----- */
    
    var id = UUID()
    
    @Published var mode: RSASignatureMode
    @Published var signature: Int?
    @Published var dA: Int?
    @Published var dB: Int?
    @Published var eA: Int?
    @Published var eB: Int?
    @Published var nA: Int?
    @Published var nB: Int?
    private var model: RSASignature?
    var result: Int {
        calculate()
    }
    
    
    
    /* ----- Inits ----- */
    
    required init() {
        self.mode = .encrypt
        self.signature = nil
        self.dA = nil
        self.dB = nil
        self.eA = nil
        self.eB = nil
        self.nA = nil
        self.nB = nil
        self.model = nil
    }
    
    init(model: RSASignature) {
        self.mode = model.mode
        self.signature = model.signature
        self.dA = model.dA
        self.dB = model.dB
        self.eA = model.eA
        self.eB = model.eB
        self.nA = model.nA
        self.nB = model.nB
        self.model = model
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func calculate() -> Int {
        guard inputValidity() else { return -1 }
        
        switch mode {
        case .encrypt: return encrypt()
        case .decrypt: return decrypt()
        }
        
        
        func encrypt() -> Int {
            if nA! < nB! {
                let y1 = ModuloVM(x: signature!, a: dA!, n: nA!)
                let y2 = ModuloVM(x: y1.result, a: eB!, n: nB!)
                return y2.result
            } else {
                let y1 = ModuloVM(x: signature!, a: eB!, n: nB!)
                let y2 = ModuloVM(x: y1.result, a: dA!, n: nA!)
                return y2.result
            }
        }
        
        func decrypt() -> Int {
            if nA! < nB! {
                let y1 = ModuloVM(x: signature!, a: dB!, n: nB!)
                let y2 = ModuloVM(x: y1.result, a: eA!, n: nA!)
                return y2.result
            } else {
                let y1 = ModuloVM(x: signature!, a: eA!, n: nA!)
                let y2 = ModuloVM(x: y1.result, a: dB!, n: nB!)
                return y2.result
            }
        }
    }
    
    
    func inputValidity() -> Bool {
        guard self.signature != nil && self.signature! > 0 else { return false }
        switch mode {
        case .encrypt:
            guard self.dA != nil && self.dA! > 0 else { return false }
            guard self.eB != nil && self.eB! > 0 else { return false }
        case .decrypt:
            guard self.dB != nil && self.dB! > 0 else { return false }
            guard self.eA != nil && self.eA! > 0 else { return false }
        }
        guard self.nA != nil && self.nA! > 0 else { return false }
        guard self.nB != nil && self.nB! > 0 else { return false }
        return true
    }
    
    
    func resetInputs() {
        self.signature = nil
        self.dA = nil
        self.dB = nil
        self.eA = nil
        self.eB = nil
        self.nA = nil
        self.nB = nil
        self.model = nil
    }
    
    
    func saveModel(context: ModelContext) -> Bool {
        guard inputValidity() else { return false }
        if model == nil {
            model = RSASignature(mode: mode, signature: signature, dA: dA, dB: dB, eA: eA, eB: eB, nA: nA, nB: nB, result: result)
        } else {
            model!.setEvery(mode: mode, signature: signature, dA: dA, dB: dB, eA: eA, eB: eB, nA: nA, nB: nB, result: result)
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
        case .encrypt: return "La signature \(signature ?? 0) encryptée est"
        case .decrypt: return "La signature \(signature ?? 0) décryptée est"
        }
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "InputError".localized() }
        return "\(result)"
    }
}
