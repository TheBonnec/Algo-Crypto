//
//  CalculationProtocol.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 31/10/2023.
//

import Foundation
import SwiftData


protocol CalculationProtocol: Identifiable, PersistentModel {
    init()
    
    func calculate()
    func inputValidity() -> Bool
    func displayLabel() -> String
    func displayResult() -> String
    func displayInfo() -> String
}
