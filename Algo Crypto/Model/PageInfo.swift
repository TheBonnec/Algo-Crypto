//
//  PageInfo.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 07/11/2023.
//

import Foundation
import SwiftUI


enum Page: String {
    case euclidAlgo, extendedEuclidAlgo
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
                PageInfo(page: .extendedEuclidAlgo, pageName: "Extended Euclidean Algorithm") { AnyView(ExtendedEuclidAlgoPage()) }
            ])
        ]
    }
}
