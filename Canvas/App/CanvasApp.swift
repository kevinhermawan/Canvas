//
//  CanvasApp.swift
//  Canvas
//
//  Created by Kevin Hermawan on 25/12/23.
//

import AppInfo
import CoreViewModels
import Sparkle
import SwiftUI

@main
struct CanvasApp: App {
    @State private var appUpdater: AppUpdater
    private var updater: SPUUpdater
    
    @State private var apiKeyViewModel: APIKeyViewModel
    @State private var dalleViewModel: DalleViewModel
    @State private var dalleModelInfoViewModel: DalleModelInfoViewModel
    
    init() {
        self._apiKeyViewModel = State(initialValue: APIKeyViewModel())
        self._dalleViewModel = State(initialValue: DalleViewModel())
        self._dalleModelInfoViewModel = State(initialValue: DalleModelInfoViewModel())
        
        let updaterController = SPUStandardUpdaterController(startingUpdater: true, updaterDelegate: nil, userDriverDelegate: nil)
        updater = updaterController.updater
        
        let appUpdater = AppUpdater(updater)
        _appUpdater = State(initialValue: appUpdater)
    }
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(apiKeyViewModel)
                .environment(dalleViewModel)
                .environment(dalleModelInfoViewModel)
        }
        .commands {
            CommandGroup(after: .appInfo) {
                Button("Check for Updates...") {
                    updater.checkForUpdates()
                }
                .disabled(appUpdater.canCheckForUpdates == false)
            }
            
            CommandGroup(replacing: .help) {
                if let helpURL = AppInfo.value(for: "HELP_URL"), let url = URL(string: helpURL) {
                    Link("Canvas Help", destination: url)
                }
            }
        }
    }
}
