//
// APIRequestBuilder.swift
// MusicBrowser
//
        
import Foundation

struct APIRequestBuilder {
    enum UnderlyingError: Error {
        case cannotComposeURL
    }

    static func build(
        request: some APIRequest,
        baseURL: URL
    ) throws -> URLRequest {
        var components = URLComponents()
        components.path = [
            request.apiVersion.rawValue,
            request.path
        ].joined(separator: "/")
        components.queryItems = request.queryItems
        guard let url = components.url(relativeTo: baseURL) else {
            throw UnderlyingError.cannotComposeURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = request.headerFields
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = try? request.encoder.encode(request)
        return urlRequest
    }
}
