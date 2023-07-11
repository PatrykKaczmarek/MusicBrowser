//
// AppServices.swift
// MusicBrowser
//

protocol AppServices {
    /// An API client that will be used by services.
    var apiClient: APIClient { get }

    /// Handles the entire business logic related to user's playlists.
    var playlistService: PlaylistService { get }
}
