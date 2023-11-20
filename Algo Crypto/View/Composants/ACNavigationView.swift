//
//  ACNavigationView.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 17/11/2023.
//

import SwiftUI

struct ACNavigationView<Content: View>: View {
    
    /* ----- Propriétés ----- */
    
    let content: Content
    let navigationGroups: [ACNavigationGroup]?
    let navigationLinks: [ACNavigationLink]?
    
    @State var selectedLink: String? = "d"
    
    
    
    init(navigationGroups: [ACNavigationGroup], @ViewBuilder content: () -> Content) {
        self.navigationGroups = navigationGroups
        self.navigationLinks = nil
        self.content = content()
    }
    
    init(navigationLinks: [ACNavigationLink], @ViewBuilder content: () -> Content) {
        self.navigationGroups = nil
        self.navigationLinks = navigationLinks
        self.content = content()
    }
    
    
    
    /* ----- Vues ----- */
    
    var body: some View {
        ScrollView {
            if self.navigationGroups != nil {
                navigationGroupsView
            } else if self.navigationLinks != nil {
                navigationLinksView
            } else {
                Text("Rien de rien.")
            }
            
            
            content
        }
        .frame(width: 275)
        .padding()
        .background(Color.appBackground)
        .border(width: 1, color: Color(uiColor: .lightGray), cornerRadius: 12)
        .cornerRadius(12)
        .padding()
    }
    
    
    var navigationGroupsView: some View {
        LazyVStack(alignment: .leading, spacing: 24) {
            ForEach(self.navigationGroups!) { group in
                LazyVStack(alignment: .leading, spacing: 0) {
                    Text(group.title)
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                    
                    
                    ForEach(group.links) { link in
                        HStack {
                            Text(link.label)
                            Spacer()
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(self.selectedLink == link.value ? Color.secondaryAppBackground : nil)
                        .cornerRadius(6)
                        .onTapGesture {
                            self.selectedLink = link.value
                        }
                    }
                }
            }
        }
    }
    
    
    var navigationLinksView: some View {
        LazyVStack {
            ForEach(self.navigationLinks!) { link in
                Text(link.label)
            }
        }
    }
}




class ACNavigationLink: Identifiable {
    let id = UUID()
    var label: String
    var value: String
    
    init(label: String, value: String) {
        self.label = label
        self.value = value
    }
}


class ACNavigationGroup: Identifiable {
    let id = UUID()
    var title: String
    var links: [ACNavigationLink]
    
    init(title: String, links: [ACNavigationLink]) {
        self.title = title
        self.links = links
    }
}





let groups = [ACNavigationGroup(
    title: "Chapitre 1",
    links: [
        ACNavigationLink(label: "Euclidian Algorithm - GCD", value: "a"),
        ACNavigationLink(label: "Extended Euclidian Algorithm", value: "b"),
        ACNavigationLink(label: "Modulo", value: "c"),
        ACNavigationLink(label: "Congruence", value: "d")
    ]),
    ACNavigationGroup(
        title: "Chapitre 2",
        links: [
            ACNavigationLink(label: "Euclidian Algorithm - GCD", value: "e"),
            ACNavigationLink(label: "Extended Euclidian Algorithm", value: "f"),
            ACNavigationLink(label: "Modulo", value: "g"),
            ACNavigationLink(label: "Congruence", value: "h")
        ])]

#Preview {
    ACNavigationView(navigationGroups: groups) {
        Text("")
    }
}

