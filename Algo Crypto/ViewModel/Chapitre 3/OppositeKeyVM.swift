//
//  OppositeKeyVM.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 26/11/2023.
//

import Foundation
import SwiftData
import SwiftUI
import Combine


class OppositeKeyVM: ObservableObject, CalculationVMProtocol {
    
    /* ----- Propriétés ----- */
    
    var id = UUID()
    
    @Published var originalKey: Int?
    @Published var phi: Int?
    @Published var resultWarning: Bool = false
    private var model: OppositeKey?
    var finalKey: Int {
        calculate()
    }
    
    
    
    /* ----- Inits ----- */
    
    required init() {
        self.originalKey = nil
        self.phi = nil
        self.model = nil
    }
    
    init(model: OppositeKey) {
        self.originalKey = model.originalKey
        self.phi = model.phi
        self.model = model
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func calculate() -> Int {
        guard inputValidity() else { return -1 }
        
        let eea = ExtendedEuclidAlgoVM(a: originalKey!, b: phi!)
        let u = eea.result.u
        let result = ((u + phi!) % phi!)
        return result
    }
    
    
    func inputValidity() -> Bool {
        guard self.originalKey != nil && self.phi != nil else { return false }
        guard self.originalKey! > 0 && self.phi! > 0 else { return false }
        return true
    }
    
    
    func isSolutionExisting() -> Int {
        guard inputValidity() else { return 1 }
        
        // Nombre trop grand pour un Int classique
        let UFinalKey = UInt64(finalKey)
        let UOriginalKey = UInt64(originalKey!)
        let UPhi = UInt64(phi!)
        let test = UFinalKey.multipliedReportingOverflow(by: UOriginalKey)
        
        if !test.overflow {
            return Int(test.partialValue % UPhi)
        } else {
            return -1
        }
    }
    
    
    func resetInputs() {
        self.originalKey = nil
        self.phi = nil
        self.model = nil
    }
    
    
    func saveModel(context: ModelContext) -> Bool {
        guard inputValidity() else { return false }
        if model == nil {
            model = OppositeKey(originalKey: originalKey, phi: phi, finalKey: finalKey)
        } else {
            model!.setEvery(originalKey: originalKey, phi: phi, finalKey: finalKey)
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
        return "La clef opposée à \(originalKey ?? 0) est"
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "Input Error" }
        return "\(finalKey)"
    }
}
