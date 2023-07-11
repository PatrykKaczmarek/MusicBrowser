//
// APIConfiguration.swift
// MusicBrowser
//
        
protocol APIConfiguration {
    /// A host name.
    var host: String { get }

    /// A scheme used by the host.
    var scheme: APIScheme { get }

    /// URL initialized from scheme and host.
    var baseURL: URL { get }
}

extension APIConfiguration {

    var baseURL: URL {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        return components.url!
    }
}
