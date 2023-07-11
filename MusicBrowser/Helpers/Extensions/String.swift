//
// String.swift
// MusicBrowser
//

import Foundation

extension String {
    /// Converts the receiver to its localized version taken from localization files.
    /// - Parameters:
    ///   - bundle: A bundle where the localization file is located.
    ///   - tableName: A name of the file.
    /// - Returns: A localized string.
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "\(self)", comment: "")
    }
}
