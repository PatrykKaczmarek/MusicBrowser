//
// Service.swift
// MusicBrowser
//

import Foundation

protocol Service {
    associatedtype Model: Codable

    /// Provides `Model` models. Firstly taken from the persistence store, but may be forced fetched from the server too.
    ///
    /// - Parameters:
    ///   - forceFetch: Indicates whether `Model` should be force fetched from the server or taken directly from the storage.
    ///   - completion: A completion closure invoked on a main thread. In case of success contains fetched `Model`. An error otherwise.
    /// - Discussion:  Provided models will be available in `models` variable.
    ///
    func provideData(forceFetch: Bool, completion: @escaping (Result<Model, Error>) -> Void)

    /// Saves currently stored `models` into persistent store.
    func saveData() throws

    /// Cache for provided `Model` to omit the necessity of reading directly from the storage what may affect performance.
    /// - Discussion: Remember to use `save()` function to write to the storage.
    var models: Model { get }

    /// An instance of `APIClient` used by `Service` for fetching data from server.
    var apiClient: APIClient { get }

    /// An instance of object used by `Service` for storing `Model` persistently.
    var persistentStorage: GenericPersistentStorage<Model> { get }
}
