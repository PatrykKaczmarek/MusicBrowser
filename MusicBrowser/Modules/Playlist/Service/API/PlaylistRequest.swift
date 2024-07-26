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
        "9a119280-8d07-4a03-b562-60c727a49f49"
    }
}
