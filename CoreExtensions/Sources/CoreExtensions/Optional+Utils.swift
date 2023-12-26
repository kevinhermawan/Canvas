//
//  Optional+Utils.swift
//
//
//  Created by Kevin Hermawan on 25/12/23.
//

public extension Optional {
    var isNil: Bool {
        self == nil
    }
    
    var isNotNil: Bool {
        self != nil
    }
}
