//
//  SettingsManager.swift
//
//
//  Created by Kevin Hermawan on 09/01/24.
//

import Defaults
import Foundation
import KeychainAccess

@Observable
public final class SettingsManager {
    private let keychainKey: String = "apikey"
    private var keychain: Keychain
    
    public var apiKey: String? = nil
    
    public var apiKeyMasked: String? {
        let prefixLength = 3
        let suffixLength = 4
        
        guard let apiKey, apiKey.count > prefixLength + suffixLength else { return nil }
        let prefix = apiKey.prefix(prefixLength)
        let suffix = apiKey.suffix(suffixLength)
        
        return "\(prefix)····················\(suffix)"
    }
    
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
    
    public init(keychain: Keychain) {
        self.keychain = keychain
        self.fetchAPIKey()
    }
}

extension SettingsManager {
    public func fetchAPIKey() {
        self.apiKey = try? keychain.get(keychainKey)
    }
    
    public func setupAPIKey(apiKey: String) {
        try? keychain.set(apiKey, key: keychainKey)
        self.fetchAPIKey()
    }
    
    public func removeAPIKey() {
        try? keychain.remove(keychainKey)
        self.fetchAPIKey()
    }
}
