//
//  PrimeFactorsVM.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 25/11/2023.
//

import Foundation
import SwiftData
import SwiftUI
import Combine


class PrimeFactorsVM: ObservableObject, CalculationVMProtocol, Equatable {
    static func == (lhs: PrimeFactorsVM, rhs: PrimeFactorsVM) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    /* ----- Propriétés ----- */
    
    var id = UUID()
    
    @Published var n: Int?
    private var model: PrimeFactors?
    var factors: [Int] {
        calculate()
    }
    lazy var constantDisplayLabel: String = {
        print("Label recalled")
        return self.displayLabel()
    }()
    lazy var constantDisplayResult: String = {
        print("Result recalled")
        return self.displayResult()
    }()
    
    
    
    /* ----- Inits ----- */
    
    required init() {
        self.n = nil
        self.model = nil
    }
    
    init(n: Int) {
        self.n = n
        self.model = nil
    }
    
    init(model: PrimeFactors) {
        self.n = model.n
        self.model = model
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func calculate() -> [Int] {
        guard inputValidity() else { return [] }
        
        var factors: [Int] = []
        var number = n!
        var divisor = 2

        while number > 1 && divisor <= n! {
            while number % divisor == 0 {
                factors.append(divisor)
                number /= divisor
            }
            divisor += 1
        }

        return factors
    }
    
    
    func inputValidity() -> Bool {
        guard self.n != nil else { return false }
        guard self.n! > 1 else { return false }
        return true
    }
    
    
    func resetInputs() {
        self.n = nil
        self.model = nil
    }
    
    
    func saveModel(context: ModelContext) -> Bool {
        guard inputValidity() else { return false }
        if model == nil {
            model = PrimeFactors(n: n, factors: factors)
        } else {
            model!.setEvery(n: n, factors: factors)
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
        return "\(n ?? 0) se décompose en :"
    }
    
    func displayResult() -> String {
        var values: [Int]
        var display = "$"
        
        
        if model != nil {
            values = model!.factors
        } else {
            guard inputValidity() else { return "InputError".localized() }
            values = factors
        }
        
        for value in values {
            display += "\(value) \\times "
        }
        
        if display != "$" {
            display.removeLast(8)
            display += "$"
        } else {
            display.removeLast()
        }
        
        return display
    }
}
