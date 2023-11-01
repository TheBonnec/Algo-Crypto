//
//  PageStack.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 30/10/2023.
//

import SwiftUI


struct PageVStack<Content: View>: View {
    
    @ViewBuilder var view: Content
    
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                view
                Spacer()
            }
            Spacer()
        }
        .ignoresSafeArea()
    }
}



struct PageHStack<Content: View>: View {
    
    
    @ViewBuilder var view: Content
    
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                view
                Spacer()
            }
            Spacer()
        }
        .ignoresSafeArea()
    }
}
