//
//  APIKeyViewModel.swift
//
//
//  Created by Kevin Hermawan on 25/12/23.
//

import Foundation
import KeychainAccess
import ViewState

@MainActor
@Observable
public final class APIKeyViewModel {
    private let keychainKey: String = "apikey"
    private var keychain: Keychain
    
    public var viewState: ViewState? = nil
    public var apiKey: String? = nil
    
    public init(keychain: Keychain = Keychain()) {
        self.keychain = keychain
        self.fetch()
    }
    
    public func fetch() {
        self.viewState = nil
        
        do {
            self.apiKey = try keychain.get(keychainKey)
        } catch {
            self.viewState = .error(message: error.localizedDescription)
        }
    }
    
    public func setup(apiKey: String) {
        self.viewState = nil
        
        do {
            try keychain.set(apiKey, key: keychainKey)
            self.fetch()
        } catch {
            self.viewState = .error(message: error.localizedDescription)
        }
    }
    
    public func remove() {
        self.viewState = nil
        
        do {
            try keychain.remove(keychainKey)
            self.fetch()
        } catch {
            self.viewState = .error(message: error.localizedDescription)
        }
    }
}
