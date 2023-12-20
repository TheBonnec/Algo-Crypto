//
//  Power.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 21/11/2023.
//

import Foundation
import SwiftUI


extension Int {
    func power(_ exp: Int, modulus: Int) -> Int {
        var result = 1
        var base = self % modulus

        var exp = exp
        while exp > 0 {
            if exp % 2 == 1 {
                result = (result * base) % modulus
            }
            base = (base * base) % modulus
            exp /= 2
        }

        return result
    }
}
