//
//  PhiVM.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 26/11/2023.
//

import Foundation
import SwiftData
import SwiftUI
import Combine


class PhiVM: ObservableObject, CalculationVMProtocol {
    
    /* ----- Propriétés ----- */
    
    var id = UUID()
    
    @Published var mode: PhiMode
    @Published var n: Int?
    @Published var p: Int?
    @Published var q: Int?
    private var model: Phi?
    var result: Int {
        calculate()
    }
    
    
    
    /* ----- Inits ----- */
    
    required init() {
        self.mode = .n
        self.n = nil
        self.p = nil
        self.q = nil
        self.model = nil
    }
    
    init(n: Int) {
        self.mode = .n
        self.n = n
        self.p = nil
        self.q = nil
        self.model = nil
    }
    
    init(p: Int, q: Int) {
        self.mode = .pq
        self.n = nil
        self.p = p
        self.q = q
        self.model = nil
    }
    
    init(model: Phi) {
        self.mode = model.mode
        self.n = model.n
        self.p = model.p
        self.q = model.q
        self.model = model
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func calculate() -> Int {
        guard inputValidity() else { return -1 }
        
        switch mode {
        case .n: return calculateN()
        case .pq: return calculatePQ()
        case .phiPhi: return calculatePhiPhi()
        }
        
        
        func calculateN() -> Int {
            if n!.isPrime() {
                return n! - 1
            } else {
                var result = n!
                var N = n!
                var i = 2

                while i * i <= N {
                    if N % i == 0 {
                        // i est un facteur premier de n
                        while N % i == 0 {
                            N /= i
                        }
                        result -= result / i
                    }
                    i += 1
                }

                if N > 1 {
                    result -= result / N
                }

                return result
            }
        }
        
        func calculatePQ() -> Int {
            return ((p! - 1) * (q! - 1))
        }
        
        func calculatePhiPhi() -> Int {
            let phi = PhiVM(n: self.n!)
            let phiPhi = PhiVM(n: phi.result)
            return phiPhi.result
            
            /*
            // Phi avec n et k : Force Brute
            let phi = calculateN()
            var count = 0
            
            for e in 0...k! {
                let gcd = EuclidAlgoVM(a: e, b: phi)
                if gcd.result == 1 {
                    count += 1
                }
            }
            return count
            */
        }
    }
    
    
    func inputValidity() -> Bool {
        switch mode {
        case .n:
            guard self.n != nil else { return false }
            guard self.n! > 1 else { return false }
        case .pq:
            guard self.p != nil && self.q != nil else { return false }
            guard self.p! > 0 && self.p!.isPrime() else { return false }
            guard self.q! > 0 && self.q!.isPrime() else { return false }
        case .phiPhi:
            guard self.n != nil else { return false }
            guard self.n! > 1 else { return false }
        }
        return true
    }
    
    
    func resetInputs() {
        self.n = nil
        self.p = nil
        self.q = nil
        self.model = nil
    }
    
    
    func saveModel(context: ModelContext) -> Bool {
        guard inputValidity() else { return false }
        if model == nil {
            model = Phi(mode: mode, n: n, p: p, q: q, result: result)
        } else {
            model!.setEvery(mode: mode, n: n, p: p, q: q, result: result)
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
        case .n: return "$\\phi(\(n ?? 0))$"
        case .pq: return "$\\phi(\(p ?? 0) \\times \(q ?? 0))$"
        case .phiPhi: return "$\\phi(\\phi(\(n ?? 0)))$"
        }
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "InputError".localized() }
        return "\(result)"
    }
}
