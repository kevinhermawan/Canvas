//
//  ImageResultListView.swift
//
//
//  Created by Kevin Hermawan on 26/12/23.
//

import SwiftUI

public struct ImageResultListView<Content: View>: View {
    private let data: [URL]
    private let content: (_: URL) -> Content
    
    public init(_ data: [URL], @ViewBuilder content: @escaping (_: URL) -> Content) {
        self.data = data
        self.content = content
    }
    
    public var body: some View {
        ScrollView {
            LazyVGrid(columns: [.init(.adaptive(minimum: 256), spacing: 16)], spacing: 16) {
                ForEach(data, id: \.self) { url in
                    content(url)
                }
            }
            .padding()
        }
    }
}
