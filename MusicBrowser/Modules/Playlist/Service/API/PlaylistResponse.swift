//
// PlaylistResponse.swift
// MusicBrowser
//
        
struct PlaylistResponse: APIResponse {
    // MARK: Properties

    /// Received playlists.
    let playlists: [StorablePlaylist]

    // MARK: Initializer

    /// - SeeAlso: Swift.Decodable
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var albums: [StorableAlbum] = []
        var playlists: [StorablePlaylist] = []

        var albumsContainer = try container.nestedUnkeyedContainer(forKey: .albums)
        if let count = albumsContainer.count, count >= 1 {
            while !albumsContainer.isAtEnd {
                let albumContainer = try albumsContainer.nestedContainer(keyedBy: AlbumCodingKeys.self)
                let identifier = try albumContainer.decode(String.self, forKey: .identifier)
                let title = try albumContainer.decode(String.self, forKey: .title)
                let imageURL = try albumContainer.decode(String.self, forKey: .imageUrl)

                let album = StorableAlbum(identifier: identifier, title: title, coverURLString: imageURL)
                albums.append(album)
            }
        }

        var playlistsContainer = try container.nestedUnkeyedContainer(forKey: .playlists)
        if let count = playlistsContainer.count, count >= 1 {
            while !playlistsContainer.isAtEnd {
                let playlistContainer = try playlistsContainer.nestedContainer(keyedBy: PlaylistCodingKeys.self)
                let identifier = try playlistContainer.decode(String.self, forKey: .identifier)
                let title = try playlistContainer.decode(String.self, forKey: .title)
                let albumIdentifiers = try playlistContainer.decode([String].self, forKey: .albumIdentifiers)

                let playlist = StorablePlaylist(
                    identifier: identifier,
                    title: title,
                    albums: albums.filter { albumIdentifiers.contains($0.identifier) }
                )
                playlists.append(playlist)
            }
        }
        self.playlists = playlists.sorted(by: { $0.identifier < $1.identifier })
    }
}

// MARK: Private

private extension PlaylistResponse {
    enum CodingKeys: String, CodingKey {
        case playlists
        case albums
    }

    enum AlbumCodingKeys: String, CodingKey {
        case identifier = "id"
        case title
        case imageUrl
    }

    enum PlaylistCodingKeys: String, CodingKey {
        case identifier = "id"
        case title
        case albumIdentifiers = "albums"
    }
}
