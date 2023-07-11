//
// APIResponse.swift
// MusicBrowser
//
        
import Foundation

protocol APIResponse: Decodable {
    /// A decoder used for changing response's data to in-app model representation.
    static var decoder: JSONDecoder { get }
}

extension APIResponse {
    static var decoder: JSONDecoder {
        JSONDecoder()
    }
}
