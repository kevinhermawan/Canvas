//
//  AppUpdater.swift
//  Canvas
//
//  Created by Kevin Hermawan on 26/12/23.
//

import Combine
import Sparkle
import SwiftUI

@Observable
final class AppUpdater {
    private var cancellable: AnyCancellable?
    var canCheckForUpdates = false
    
    init(_ updater: SPUUpdater) {
        cancellable = updater.publisher(for: \.canCheckForUpdates)
            .assign(to: \.canCheckForUpdates, on: self)
    }
}
