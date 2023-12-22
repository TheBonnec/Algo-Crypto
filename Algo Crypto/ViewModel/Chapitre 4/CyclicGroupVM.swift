//
//  CyclicGroupVM.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 22/12/2023.
//

import SwiftData
import SwiftUI
import Combine


class CyclicGroupVM: ObservableObject, CalculationVMProtocol {
    
    /* ----- Propriétés ----- */
    
    var id = UUID()
    
    @Published var n: Int?
    private var model: CyclicGroup?
    var result: Bool {
        calculate()
    }
    
    
    
    /* ----- Inits ----- */
    
    required init() {
        self.n = nil
        self.model = nil
    }
    
    init(n: Int?) {
        self.n = n
        self.model = nil
    }
    
    init(model: CyclicGroup) {
        self.n = model.n
        self.model = model
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func calculate() -> Bool {
        guard inputValidity() else { return false }
        
        func isPrime(_ number: Int) -> Bool {
            if number <= 1 {
                return false
            } else if number <= 3 {
                return true
            }
            
            for i in 2...Int(Double(number).squareRoot()) {
                if number % i == 0 {
                    return false
                }
            }
            return true
        }
        
        
        if n! == 1 || n! == 2 || n! == 4 {
            return true
        }
        if n! % 2 == 0 {
            // Pour n = 2p^k, où p est un nombre premier impair
            let reducedN = n! / 2
            if reducedN % 2 == 0 {
                return false
            }
            return isPrime(reducedN)
        } else {
            // Pour n = p^k, chercher le premier p et vérifier si n est une puissance de p
            var primeFactor = 0
            for i in 3...n! where n! % i == 0 && isPrime(i) {
                primeFactor = i
                break
            }
            if primeFactor == 0 {
                return false
            }
            var remainder = n!
            while remainder % primeFactor == 0 {
                remainder /= primeFactor
            }
            return remainder == 1
        }
    }
    
    
    func inputValidity() -> Bool {
        guard self.n != nil && self.n! > 0 else { return false }
        return true
    }
    
    
    func resetInputs() {
        self.n = nil
        self.model = nil
    }
    
    
    func saveModel(context: ModelContext) -> Bool {
        guard inputValidity() else { return false }
        if model == nil {
            model = CyclicGroup(n: n, result: result)
        } else {
            model!.setEvery(n: n, result: result)
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
        return "Le groupe $Inv(\\frac{\\mathbb{Z}}{\(n ?? 0)\\mathbb{Z}})$ est"
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "InputError".localized() }
        if result {
            return "Cyclique"
        }
        return "Non Cyclique"
    }
}
