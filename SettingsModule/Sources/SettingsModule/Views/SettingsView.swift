//
//  SettingsView.swift
//
//
//  Created by Kevin Hermawan on 09/01/24.
//

import SwiftUI

public struct SettingsView: View {
    public init() {}
    
    public var body: some View {
        VStack {
            TabView {
                GeneralView()
                    .tabItem {
                        Label("General", systemImage: "gearshape")
                    }
            }
        }
        .padding()
        .frame(width: 450)
    }
}
