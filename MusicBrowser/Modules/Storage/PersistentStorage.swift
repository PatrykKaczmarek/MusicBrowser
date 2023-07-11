//
// PersistentStorage.swift
// MusicBrowser
//

protocol PersistentStorage {
    associatedtype Value

    /// Sets given `value` for a certain `key`
    /// - Parameters:
    ///   - value: A value to save.
    ///   - key: A key associated with the value.
    func setValue(_ value: Value?, forKey key: String) throws

    /// Retrieves a `Value` for given `key`.
    /// - Parameter key: A key associated with the value.
    /// - Returns: An instance of `Value` if stored. Nil otherwise.
    func getValue(forKey key: String) throws -> Value?
}
