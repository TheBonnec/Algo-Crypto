//
//  PageInfo.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 07/11/2023.
//

import Foundation


enum Page {
    case euclid, extendedEuclid, modulo, congruence, equivalenceClass, additionInZ, multiplicationInZ, inversesList, equationSolver, inverseInZ
}



class PageInfo: Identifiable {
    let id = UUID()
    let page: Page
    let pageName: String
    
    init(page: Page, pageName: String) {
        self.page = page
        self.pageName = pageName
    }
}



class PageGroup: Identifiable {
    let id = UUID()
    let groupName: String
    let pages: [PageInfo]
    
    init(groupName: String, pages: [PageInfo]) {
        self.groupName = groupName
        self.pages = pages
    }
}



class Pages {
    let pageGroups: [PageGroup]
    
    init() {
        self.pageGroups = [
            PageGroup(groupName: "Chapitre 1", pages: [
                PageInfo(page: .euclid, pageName: "Euclidian Algorithm - GCD"),
                PageInfo(page: .extendedEuclid, pageName: "Extended Euclidian Algorithm"),
                PageInfo(page: .modulo, pageName: "Modulo"),
                PageInfo(page: .congruence, pageName: "Congruence"),
                PageInfo(page: .equivalenceClass, pageName: "Equivalence Class"),
                PageInfo(page: .additionInZ, pageName: "Addition In Z/nZ"),
                PageInfo(page: .multiplicationInZ, pageName: "Multiplication In Z/nZ"),
                PageInfo(page: .inversesList, pageName: "Inverses In Z/nZ"),
                PageInfo(page: .equationSolver, pageName: "Linear Equations In Z/nZ"),
                PageInfo(page: .inverseInZ, pageName: "Inverse In Z/nZ")
            ])
        ]
    }
}
