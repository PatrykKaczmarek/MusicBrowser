//
// GenericPersistentStorage.swift
// MusicBrowser
//

final class GenericPersistentStorage<T: Codable>: PersistentStorage {

    // MARK: Properties

    private let storage: Storable

    private let storageName: String

    // MARK: Initialize

    /// Initializes an instance of the receiver.
    /// - Parameters:
    ///   - storage: A place where `T` values should be saved.
    ///   - storageName: A string being used as a `key` in `storage`.
    init(storage: Storable, storageName: String) {
        self.storage = storage
        self.storageName = storageName
    }

    // MARK: API

    /// Sets given `value` for `storageName`.
    /// - Parameters:
    ///   - value: A value to save.
    func setValue(_ value: T?) throws {
        try setValue(value, forKey: storageName)
    }

    /// Retrieves a `Value` for `storageName`.
    /// - Returns: An instance of `T` if stored. Nil otherwise.
    func getValue() throws -> T? {
        try getValue(forKey: storageName)
    }

    // MARK: PersistentStorage

    func setValue(_ value: T?, forKey key: String) throws {
        guard let value = value else {
            return
        }
        let data = try JSONEncoder().encode(value)
        try storage.writeData(data, to: key)
    }

    func getValue(forKey key: String) throws -> T? {
        let data = try storage.readData(from: key)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
