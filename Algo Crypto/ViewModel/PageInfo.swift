//
//  PageInfo.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 07/11/2023.
//

import Foundation
import SwiftUI


enum Page: String {
    case euclidAlgo, extendedEuclidAlgo, modulo, congruence, equivalenceClass, additionInZ, multiplicationInZ, invertiblesInZ, linearEquationInZ, inverseInZ, primeFactors, phi, polynomialEquation, oppositeKey, rsa, rsaSignature
}



class PageInfo<Content: View>: Identifiable, Equatable {
    let id = UUID()
    let page: Page
    let pageName: LocalizedStringKey
    let destination: () -> Content

    init(page: Page, pageName: LocalizedStringKey, @ViewBuilder destination: @escaping () -> Content) {
        self.page = page
        self.pageName = pageName
        self.destination = destination
    }
    
    static func == (lhs: PageInfo, rhs: PageInfo) -> Bool {
        return lhs.id == rhs.id
    }
}



class PageGroup: Identifiable {
    let id = UUID()
    let groupName: LocalizedStringKey
    let pages: [PageInfo<AnyView>]
    
    init(groupName: LocalizedStringKey, pages: [PageInfo<AnyView>]) {
        self.groupName = groupName
        self.pages = pages
    }
}



class Pages {
    let pageGroups: [PageGroup]
    
    // Chapitre 1
    let euclidAlgo = PageInfo(page: .euclidAlgo, pageName: "EuclidAlgo") { AnyView(EuclidAlgoPage()) }
    let extendedEuclidAlgo = PageInfo(page: .extendedEuclidAlgo, pageName: "ExtendedEuclidAlgo") { AnyView(ExtendedEuclidAlgoPage()) }
    let modulo = PageInfo(page: .modulo, pageName: "Modulo") { AnyView(ModuloPage()) }
    let congruence = PageInfo(page: .congruence, pageName: "Congruence") { AnyView(CongruencePage()) }
    let equivalenceClass = PageInfo(page: .equivalenceClass, pageName: "EquivalenceClass") { AnyView(EquivalenceClassPage()) }
    let additionInZ = PageInfo(page: .additionInZ, pageName: "AdditionInZ") { AnyView(AdditionInZPage()) }
    let multiplicationInZ = PageInfo(page: .multiplicationInZ, pageName: "MultiplicationInZ") { AnyView(MultiplicationInZPage()) }
    let invertibleElementsInZ = PageInfo(page: .invertiblesInZ, pageName: "InvertibleElementsInZ") { AnyView(InvertiblesInZPage()) }
    let linearEquationInZ = PageInfo(page: .linearEquationInZ, pageName: "LinearEquationInZ") { AnyView(LinearEquationInZPage()) }
    let inverseInZ = PageInfo(page: .inverseInZ, pageName: "InverseInZ") { AnyView(InverseInZPage()) }
    
    // Chapitre 2
    let primeFactors = PageInfo(page: .primeFactors, pageName: "Décomposition en Facteurs Premiers", destination: { AnyView(PrimeFactorsPage()) })
    let phi = PageInfo(page: .phi, pageName: "Phi - 'Totient Function'", destination: { AnyView(PhiPage()) })
    let polynomialEquation = PageInfo(page: .polynomialEquation, pageName: "Équation Polynomiale dans Z/nZ", destination: { AnyView(PolynomialEquationPage()) })
    let oppositeKey = PageInfo(page: .oppositeKey, pageName: "Clef Opposée", destination: { AnyView(OppositeKeyPage()) })
    let rsa = PageInfo(page: .rsa, pageName: "Encryptage / Décryptage RSA", destination: { AnyView(RSAPage()) })
    let rsaSignature = PageInfo(page: .rsaSignature, pageName: "Signature RSA", destination: { AnyView(RSASignaturePage()) })
    
    
    
    init() {
        self.pageGroups = [
            PageGroup(groupName: "Chapter1", pages: [euclidAlgo, extendedEuclidAlgo, modulo, congruence, equivalenceClass, additionInZ, multiplicationInZ, invertibleElementsInZ, linearEquationInZ, inverseInZ]),
            PageGroup(groupName: "Chapitre 3", pages: [primeFactors, phi, polynomialEquation, oppositeKey, rsa, rsaSignature])
        ]
    }
}
