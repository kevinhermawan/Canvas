//
//  SectionHeader.swift
//
//
//  Created by Kevin Hermawan on 26/12/23.
//

import SwiftUI

struct SectionHeader: View {
    private let titleKey: LocalizedStringKey
    private var actionTitleKey: LocalizedStringKey?
    private var action: (() -> Void)?
    
    init(_ titleKey: LocalizedStringKey) {
        self.titleKey = titleKey
    }
    
    var body: some View {
        HStack {
            Text(titleKey)
            
            if let actionTitleKey, let action {
                Spacer()
                
                Button(actionTitleKey, action: action)
                    .fontWeight(.medium)
                    .buttonStyle(.link)
            }
        }
    }
    
    func action(_ titleKey: LocalizedStringKey, action: @escaping () -> Void) -> SectionHeader {
        var view = self
        view.actionTitleKey = titleKey
        view.action = action
        
        return view
    }
}

#Preview {
    Form {
        Section {
            Text("Content")
        } header: {
            SectionHeader("Section Header")
                .action("Remove", action: {})
        }
    }
    .padding()
}
