//
//  SettingsManager.swift
//
//
//  Created by Kevin Hermawan on 09/01/24.
//

import Defaults
import Foundation

@Observable
public final class SettingsManager {
    public var autosaveEnabled: Bool = Defaults[.autosaveEnabled] {
        didSet {
            Defaults[.autosaveEnabled] = autosaveEnabled
        }
    }
    
    public var autosaveLocation: URL = Defaults[.autosaveLocation] {
        didSet {
            Defaults[.autosaveLocation] = autosaveLocation
        }
    }
    
    public init() {}
}
