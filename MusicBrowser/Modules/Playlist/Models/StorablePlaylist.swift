//
// StorablePlaylist.swift
// MusicBrowser
//
        
final class StorablePlaylist: Playlist, Codable {

    // MARK: Playlist

    let identifier: String

    let title: String

    var albums: [Album] {
        storableAlbums
    }

    let storableAlbums: [StorableAlbum]

    // MARK: Initializer

    init(identifier: String, title: String, albums: [StorableAlbum]) {
        self.identifier = identifier
        self.title = title
        self.storableAlbums = albums
    }
}

// MARK: Private

private extension StorablePlaylist {
    private enum CodingKeys: String, CodingKey {
        case identifier
        case title
        case storableAlbums
    }
}
