//
//  PageInfo.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 07/11/2023.
//

import Foundation
import SwiftUI


enum Page: String {
    case euclidAlgo, extendedEuclidAlgo, modulo, congruence, equivalenceClass, additionInZ, multiplicationInZ, invertiblesInZ, linearEquationInZ, inverseInZ
}



class PageInfo<Content: View>: Identifiable, Equatable {
    let id = UUID()
    let page: Page
    let pageName: String
    let destination: () -> Content

    init(page: Page, pageName: String, @ViewBuilder destination: @escaping () -> Content) {
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
    let groupName: String
    let pages: [PageInfo<AnyView>]
    
    init(groupName: String, pages: [PageInfo<AnyView>]) {
        self.groupName = groupName
        self.pages = pages
    }
}



class Pages {
    let pageGroups: [PageGroup]
    let defaultPage = PageInfo(page: .euclidAlgo, pageName: "Euclidean Algorithm - GCD") { AnyView(EuclidAlgoPage()) }
    
    
    init() {
        self.pageGroups = [
            PageGroup(groupName: "Chapitre 1", pages: [
                defaultPage,
                PageInfo(page: .extendedEuclidAlgo, pageName: "Extended Euclidean Algorithm") { AnyView(ExtendedEuclidAlgoPage()) },
                PageInfo(page: .modulo, pageName: "Modulo") { AnyView(ModuloPage()) },
                PageInfo(page: .congruence, pageName: "Congruence") { AnyView(CongruencePage()) },
                PageInfo(page: .equivalenceClass, pageName: "Equivalence Class") { AnyView(EquivalenceClassPage()) },
                PageInfo(page: .additionInZ, pageName: "Addition In Z/nZ") { AnyView(AdditionInZPage()) },
                PageInfo(page: .multiplicationInZ, pageName: "Multiplication In Z/nZ") { AnyView(MultiplicationInZPage()) },
                PageInfo(page: .invertiblesInZ, pageName: "Invertible Elements In Z/nZ") { AnyView(InvertiblesInZPage()) },
                PageInfo(page: .linearEquationInZ, pageName: "Linear Equation in Z/nZ") { AnyView(LinearEquationInZPage()) },
                PageInfo(page: .inverseInZ, pageName: "Inverse In Z/nZ") { AnyView(InverseInZPage()) }
            ])
        ]
    }
}
