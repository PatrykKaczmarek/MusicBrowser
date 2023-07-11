//
// APIRequest.swift
// MusicBrowser
//
        
import Foundation

protocol APIRequest: Encodable {
    associatedtype Response: APIResponse

    /// A path part of the url.
    var path: String { get }

    /// An array of items to be added to query.
    var queryItems: [URLQueryItem]? { get }

    /// A REST method used by the request.
    var method: APIRequestMethod { get }

    /// A version of the API request.
    var apiVersion: APIVersion { get }

    /// An encoder used for changing request's properties to HTTP body.
    var encoder: JSONEncoder { get }

    /// A  dictionary defining how information sent/received through the connection are encoded.
    var headerFields: [String: String] { get }
}

extension APIRequest {
    var encoder: JSONEncoder {
        JSONEncoder()
    }

    var queryItems: [URLQueryItem]? {
        nil
    }

    var headerFields: [String: String] {
        [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }

    func encode(to encoder: Encoder) throws {}
}
