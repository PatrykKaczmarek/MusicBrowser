//
// StorableAlbum.swift
// MusicBrowser
//

final class StorableAlbum: Album, ObservableObject, Codable, Equatable {

    // MARK: Album

    let identifier: String

    let title: String

    let coverURLString: String

    @Published var isFavorite: Bool

    // MARK: Initializer

    init(identifier: String, title: String, coverURLString: String, isFavorite: Bool = false) {
        self.identifier = identifier
        self.title = title
        self.coverURLString = coverURLString
        self.isFavorite = isFavorite
    }

    // MARK: Decodable

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(String.self, forKey: .identifier)
        title = try container.decode(String.self, forKey: .title)
        coverURLString = try container.decode(String.self, forKey: .coverURLString)
        isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
    }

    // MARK: Encodable

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(title, forKey: .title)
        try container.encode(coverURLString, forKey: .coverURLString)
        try container.encode(isFavorite, forKey: .isFavorite)
    }

    // MARK: Equatable

    static func == (lhs: StorableAlbum, rhs: StorableAlbum) -> Bool {
        lhs.identifier == rhs.identifier
    }
}

// MARK: Private

private extension StorableAlbum {
    private enum CodingKeys: String, CodingKey {
        case identifier
        case title
        case coverURLString
        case isFavorite
    }
}
