//
// PlaylistService.swift
// MusicBrowser
//

import Foundation

final class PlaylistService: Service {

    // MARK: Service

    private(set) var models: [StorablePlaylist]

    private(set) var apiClient: APIClient

    private(set) var persistentStorage: GenericPersistentStorage<[StorablePlaylist]>

    // MARK: Initializer

    /// Initializes an instance of the receiver.
    ///
    /// - Parameters:
    ///   - apiClient: A client that will be used for performing API requests.
    ///   - storage: A storage that will be used for storing fetched data.
    init(apiClient: APIClient, storage: Storable) {
        self.apiClient = apiClient
        self.persistentStorage = GenericPersistentStorage<[StorablePlaylist]>(
            storage: storage,
            storageName: "playlists"
        )
        self.models = (try? persistentStorage.getValue()) ?? []
    }

    // MARK: API

    func provideData(forceFetch: Bool, completion: @escaping (Result<[StorablePlaylist], Error>) -> Void) {
        let shouldFetch = models.isEmpty || forceFetch
        guard shouldFetch else {
            completion(.success(models))
            return
        }
        apiClient.perform(request: PlaylistRequest()) { [weak self] result in
            switch result {
            case .success(let response):
                guard let self = self else {
                    return
                }
                try? self.persistentStorage.setValue(response.playlists)
                self.models = response.playlists
                completion(.success(response.playlists))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func saveData() throws {
        try persistentStorage.setValue(models)
    }
}
