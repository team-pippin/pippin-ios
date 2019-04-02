//
//  String+SpecialCharacters.swift
//  Pippin
//
//  Created by Will Brandin on 4/2/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import Foundation

extension String {
    func removeSpecialCharactersFromText() -> String {
        let notAllowedChars: CharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ").inverted
        return self.components(separatedBy: notAllowedChars).joined(separator: "")
    }
}

