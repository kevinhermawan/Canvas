//
//  FootnoteText.swift
//
//
//  Created by Kevin Hermawan on 25/12/23.
//

import SwiftUI

public struct FootnoteText: View {
    private var titleKey: LocalizedStringKey
    
    public init(_ titleKey: LocalizedStringKey) {
        self.titleKey = titleKey
    }
    
    public var body: some View {
        Text(titleKey)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.callout)
    }
}

#Preview {
    FootnoteText("Lorem ipsum dolor sit amet")
}
