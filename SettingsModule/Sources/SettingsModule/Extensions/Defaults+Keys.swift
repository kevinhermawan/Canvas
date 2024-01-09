//
//  Defaults+Keys.swift
//
//
//  Created by Kevin Hermawan on 09/01/24.
//

import Defaults
import Foundation

let fileManager = FileManager.default
let homeDirectory = fileManager.homeDirectoryForCurrentUser

public extension Defaults.Keys {
    static let autosaveEnabled = Key<Bool>("autosaveEnabled", default: true)
    static let autosaveLocation = Key<URL>("autosaveLocation", default: homeDirectory.appending(path: "Canvas"))
}
