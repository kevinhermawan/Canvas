//
//  AppSidebarView.swift
//  Canvas
//
//  Created by Kevin Hermawan on 25/12/23.
//

import SwiftUI

struct AppSidebarView: View {
    @Binding private var selection: AppSidebarItem
    
    init(selection: Binding<AppSidebarItem>) {
        self._selection = selection
    }
    
    var body: some View {
        List(AppSidebar.allCases, selection: $selection) { sidebar in
            Section(sidebar.title) {
                ForEach(sidebar.items) { item in
                    Label(item.title, systemImage: item.systemImage)
                        .tag(item)
                }
            }
        }
    }
}

#Preview {
    NavigationSplitView {
        AppSidebarView(selection: .constant(.imageGeneration))
    } detail: {
        EmptyView()
    }
}
