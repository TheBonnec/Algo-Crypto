//
//  PageInfo.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 07/11/2023.
//

import Foundation
import SwiftUI
import CIUAisen


enum PageList: String {
    case euclidAlgo, extendedEuclidAlgo, modulo, congruence, equivalenceClass, additionInZ, multiplicationInZ, invertiblesInZ, linearEquationInZ, inverseInZ, primeFactors, phi, polynomialEquation, oppositeKey, rsa, rsaSignature
}



class PageInfo<Content: View>: Identifiable, Equatable {
    let id = UUID()
    let page: PageList
    let pageName: LocalizedStringKey
    let destination: () -> Content

    init(page: PageList, pageName: LocalizedStringKey, @ViewBuilder destination: @escaping () -> Content) {
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
    let pageGroups: [LienDeNavigateurGroupe]
    
    // Chapitre 1
    let euclidAlgo = LienDeNavigateur(clé: "EuclidAlgo", destination: EuclidAlgoPage())
    let extendedEuclidAlgo = LienDeNavigateur(clé: "ExtendedEuclidAlgo", destination: ExtendedEuclidAlgoPage())
    let modulo = LienDeNavigateur(clé: "Modulo", destination: ModuloPage())
    let congruence = LienDeNavigateur(clé: "Congruence", destination: CongruencePage())
    let equivalenceClass = LienDeNavigateur(clé: "EquivalenceClass", destination: EquivalenceClassPage())
    let additionInZ = LienDeNavigateur(clé: "AdditionInZ", destination: AdditionInZPage())
    let multiplicationInZ = LienDeNavigateur(clé: "MultiplicationInZ", destination: MultiplicationInZPage())
    let invertibleElementsInZ = LienDeNavigateur(clé: "LinearEquationInZ", destination: InvertiblesInZPage())
    let linearEquationInZ = LienDeNavigateur(clé: "LinearEquationInZ", destination: LinearEquationInZPage())
    let inverseInZ = LienDeNavigateur(clé: "InverseInZ", destination: InverseInZPage())
    
    // Chapitre 3
    let primeFactors = LienDeNavigateur(clé: "Décompo. en Facteurs Premiers", destination: PrimeFactorsPage())
    let phi = LienDeNavigateur(clé: "Phi - 'Totient Function'", destination: PhiPage())
    let polynomialEquation = LienDeNavigateur(clé: "Équation Polynomiale dans Z/nZ", destination: PolynomialEquationPage())
    let oppositeKeyRSA = LienDeNavigateur(clé: "Clef Opposée - RSA", destination: OppositeKeyRSAPage())
    let rsa = LienDeNavigateur(clé: "Encryptage / Décryptage RSA", destination: RSAPage())
    let rsaSignature = LienDeNavigateur(clé: "Signature RSA", destination: RSASignaturePage())
    
    // Chapitre 4
    let orderInZ = LienDeNavigateur(clé: "Ordre sur Z/nZ", destination: OrderInZPage())
    let cyclicGroup = LienDeNavigateur(clé: "Groupe Cyclique", destination: CyclicGroupPage())
    let generators = LienDeNavigateur(clé: "Générateurs de Inv(Z/nZ)", destination: GeneratorsPage())
    let oppositeKeyElGamal = LienDeNavigateur(clé: "Clef Opposée - El Gamal", destination: OppositeKeyElGamalPage())
    let elGamalEncryption = LienDeNavigateur(clé: "Encrypt. / Decrypt. El Gamal", destination: ElGamalEncryptionPage())
    
    
    
    init() {
        self.pageGroups = [
            LienDeNavigateurGroupe(titre: "Chapter1", liensDeNavigateur: [euclidAlgo, extendedEuclidAlgo, modulo, congruence, equivalenceClass, additionInZ, multiplicationInZ, invertibleElementsInZ, linearEquationInZ, inverseInZ]),
            LienDeNavigateurGroupe(titre: "Chapter3", liensDeNavigateur: [primeFactors, phi, polynomialEquation, oppositeKeyRSA, rsa, rsaSignature]),
            LienDeNavigateurGroupe(titre: "Chapitre 4", liensDeNavigateur: [orderInZ, cyclicGroup, generators, oppositeKeyElGamal, elGamalEncryption])
        ]
    }
}
