//
//  OppositeKeyElGamalVM.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 22/12/2023.
//

import Foundation
import SwiftData
import SwiftUI
import Combine


class OppositeKeyElGamalVM: ObservableObject, CalculationVMProtocol {
    
    /* ----- Propriétés ----- */
    
    var id = UUID()
    
    @Published var mode: OppositeKeyElGamalMode
    @Published var n: Int?
    @Published var g: Int?
    @Published var eA: Int?
    @Published var dA: Int?
    private var model: OppositeKeyElGamal?
    var result: Int {
        switch self.mode {
        case .eA: calculateEA()
        case .dA: calculateDA()
        }
    }
    
    
    
    /* ----- Inits ----- */
    
    required init() {
        self.mode = .eA
        self.n = nil
        self.g = nil
        self.eA = nil
        self.dA = nil
        self.model = nil
    }
    
    init(model: OppositeKeyElGamal) {
        self.mode = model.mode
        self.n = model.n
        self.g = model.g
        self.eA = model.eA
        self.dA = model.dA
        self.model = model
    }
    
    init(mode: OppositeKeyElGamalMode, n: Int?, g: Int?, eA: Int?, dA: Int?) {
        self.mode = mode
        self.n = n
        self.g = g
        self.eA = eA
        self.dA = dA
        self.model = nil
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func calculateEA() -> Int {
        guard inputValidity() else { return -1 }
        
        let puissance = ModuloVM(x: g!, a: dA!, n: n!)
        return puissance.result
    }
    
    
    func calculateDA() -> Int {
        guard inputValidity() else { return -1 }
        
        for possibleDA in 1..<(n! - 1) {
            if ModuloVM(x: g!, a: possibleDA, n: n!).result == eA! {
                return possibleDA
            }
        }
        return -2
    }
    
    
    func inputValidity() -> Bool {
        guard self.n != nil && self.n! > 0 else { return false }
        guard self.g != nil && self.g! > 1 else { return false }
        
        switch mode {
        case .eA: guard self.dA != nil && self.dA! > 0 else { return false }
        case .dA: guard self.eA != nil && self.eA! > 0 else { return false }
        }
        return true
    }
    
    
    func isSolutionExisting() -> Bool {
        guard inputValidity() else { return true }
        
        switch mode {
        case .eA:
            if OppositeKeyElGamalVM(mode: .dA, n: n, g: g, eA: result, dA: nil).result == dA {
                return true
            }
            return false
        case .dA:
            if OppositeKeyElGamalVM(mode: .eA, n: n, g: g, eA: nil, dA: result).result == eA {
                return true
            }
            return false
        }
    }
    
    
    func resetInputs() {
        self.mode = .eA
        self.n = nil
        self.g = nil
        self.eA = nil
        self.dA = nil
        self.model = nil
    }
    
    
    func saveModel(context: ModelContext) -> Bool {
        guard inputValidity() else { return false }
        if model == nil {
            model = OppositeKeyElGamal(mode: mode, n: n, g: g, eA: eA, dA: dA, result: result)
        } else {
            model!.setEvery(mode: mode, n: n, g: g, eA: eA, dA: dA, result: result)
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
        case .eA: return "La clef eA pour n = \(n ?? 0), g = \(g ?? 0) et dA = \(dA ?? 0) est"
        case .dA: return "La clef dA pour n = \(n ?? 0), g = \(g ?? 0) et eA = \(eA ?? 0) est"
        }
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "InputError".localized() }
        if result == -2 {
            return "Aucun résultat trouvé"
        }
        return "\(result)"
    }
}
