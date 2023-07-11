//
// DefaultAppServices.swift
// MusicBrowser
//
        
final class DefaultAppServices: AppServices {

    // MARK: Initializer

    /// Initializes an instance of the receiver.
    ///
    /// - Parameters:
    ///   - apiClient: An API client that will be used by services.
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    // MARK: AppServices

    let apiClient: APIClient

    lazy var playlistService = PlaylistService(
        apiClient: apiClient,
        storage: FileManager.default
    )
}
