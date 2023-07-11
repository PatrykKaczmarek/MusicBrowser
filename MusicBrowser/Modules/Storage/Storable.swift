//
// Storable.swift
// MusicBrowser
//

import Foundation

protocol Storable {
    /// Writes `data` to a file named `file`.
    func writeData(_ data: Data, to file: String) throws

    /// Removes file named `file`.
    func remove(file: String) throws

    /// Reads `Data` from a file named `file`. If the file doesn't exists, throws an error.
    func readData(from file: String) throws -> Data
}
