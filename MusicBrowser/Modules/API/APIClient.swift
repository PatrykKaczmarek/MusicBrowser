//
// APIClient.swift
// MusicBrowser
//

protocol APIClient {

    /// Performs given request and returns result in a completion block.
    /// - Parameters:
    ///   - request: A request to perform.
    ///   - completion: Invoked on a main thread. Contains parsed response or an error.
    func perform<Request: APIRequest>(
        request: Request,
        completion: @escaping (Result<Request.Response, APIClientError>) -> Void?
    )
}
