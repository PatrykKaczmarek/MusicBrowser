//
// FileManager.swift
// MusicBrowser
//

import Foundation

extension FileManager: Storable {
    func writeData(_ data: Data, to file: String) throws {
        guard let documentDirectoryURL = urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw StorableError.storageFileNotFound
        }
        let fileURL = documentDirectoryURL.appendingPathComponent(file)
        try data.write(to: fileURL)
    }

    func remove(file: String) throws {
        guard let documentDirectoryURL = urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw StorableError.storageFileNotFound
        }
        let fileURL = documentDirectoryURL.appendingPathComponent(file)
        try FileManager.default.removeItem(at: fileURL)
    }

    func readData(from file: String) throws -> Data {
        guard let documentDirectoryURL = urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw StorableError.storageFileNotFound
        }
        let fileURL = documentDirectoryURL.appendingPathComponent(file)
        return try Data(contentsOf: fileURL)
    }
}
