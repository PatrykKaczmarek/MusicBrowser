//
// DefaultAPIClient.swift
// MusicBrowser
//

import Foundation

final class DefaultAPIClient: APIClient {

    // MARK: Properties

    private let session: URLSession

    private let configuration: APIConfiguration

    private let acceptableStatusCodes = 200...299

    // MARK: Initializer

    init(configuration: APIConfiguration, session: URLSession = .shared) {
        self.configuration = configuration
        self.session = session
    }

    // MARK: APIClient

    func perform<Request: APIRequest>(
        request: Request,
        completion: @escaping (Result<Request.Response, APIClientError>) -> Void?
    ) {
        let resolveSuccess: (Request.Response) -> Void = { response in
            let result: Result<Request.Response, APIClientError> = .success(response)
            DispatchQueue.main.async { completion(result) }
        }

        let resolveFailure: (APIClientError) -> Void = { error in
            let result: Result<Request.Response, APIClientError> = .failure(error)
            DispatchQueue.main.async { completion(result) }
        }

        do {
            let urlRequest = try encode(request: request)
            session.dataTask(with: urlRequest) { [weak self] data, response, error in
                guard let self = self else {
                    return
                }
                do {
                    let data = try self.validate(data: data, response: response, error: error)
                    let result = try self.decodeResponse(from: request, using: data)
                    resolveSuccess(result)
                } catch {
                    resolveFailure(APIClientError(error: error))
                }
            }.resume()
        } catch {
            resolveFailure(.requestBuildError(error))
        }
    }
}

// MARK: Private

private extension DefaultAPIClient {
    func encode<Request: APIRequest>(
        request: Request
    ) throws -> URLRequest {
        do {
            return try APIRequestBuilder.build(
                request: request,
                baseURL: configuration.baseURL
            )
        } catch {
            throw APIClientError.requestBuildError(error)
        }
    }

    func decodeResponse<Request: APIRequest>(
        from request: Request,
        using data: Data
    ) throws -> Request.Response {
        do {
            let decoder = Request.Response.decoder
            return try decoder.decode(Request.Response.self, from: data)
        } catch let error as DecodingError {
            throw APIClientError.responseDecodingError(error)
        } catch {
            throw APIClientError.responseParseError(error)
        }
    }

    func validate(data: Data?, response: URLResponse?, error: Error?) throws -> Data {
        /// If there was an error, resolve failure immediately.
        if let error = error {
            throw APIClientError.connectionError(error)
        }
        /// If the response is invalid, resolve failure immediately.
        guard let response = response as? HTTPURLResponse else {
            throw APIClientError.responseTypeError
        }
        /// Validate against acceptable status codes.
        guard acceptableStatusCodes.contains(response.statusCode) else {
            throw APIClientError.statusCodeError(response.statusCode)
        }
        /// If data is missing, resolve failure immediately.
        /// Missing data is not the same as zero-width data – the former is considered erroreus.
        guard let data = data else {
            throw APIClientError.responseDataError
        }
        return data
    }
}
