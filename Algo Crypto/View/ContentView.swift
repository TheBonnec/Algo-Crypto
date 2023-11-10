//
//  ContentView.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 30/10/2023.
//

import SwiftUI
import SwiftData
import Dynamic



struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @State var pageSelected: Page = .euclid
    
    let pages: Pages = Pages()
    

    var body: some View {
        NavigationSplitView {
            ZStack {
                Color(.appBackground)
                    .ignoresSafeArea()
                
                List {
                    ForEach(pages.pageGroups) { pageGroup in
                        Section(pageGroup.groupName) {
                            ForEach(pageGroup.pages) { page in
                                Button {
                                    self.pageSelected = page.page
                                    print()
                                } label: {
                                    HStack {
                                        Text("\(page.pageName)")
                                            
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                    .padding(.vertical, 12)
                                    .background(pageSelected == page.page ? Color.cyan.opacity(0.2) : nil)
                                    .cornerRadius(8)
                                }                                
                            }
                        }
                    }
                }
                
                .navigationTitle("Algo Crypto")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(removing: .sidebarToggle)
                .navigationDestination(for: Page.self) { page in
                    //PageSelector(page: page)
                    EuclidAlgoView()
                }
            }
        } detail: {
            PageSelector(page: pageSelected)
                .padding(.horizontal, 4)
                .padding(.vertical)
        }
        .tint(.cyan)
    }
}



#Preview {
    ContentView()
}
