//
// PlaylistRequest.swift
// MusicBrowser
//

struct PlaylistRequest: APIRequest {

    // MARK: APIRequest

    typealias Response = PlaylistResponse

    var method: APIRequestMethod {
        .get
    }

    var apiVersion: APIVersion {
        .version(.three)
    }

    var path: String {
        "497e225f-3198-4455-8907-782713149520"
    }
}
