//
// APIVersion.swift
// MusicBrowser
//
        
enum APIVersion {
    enum Value: String {
        case one = "v1"
        case two = "v2"
        case three = "v3"
    }

    case version(Value)
    case custom(String)

    var rawValue: String {
        switch self {
        case .version(let value):
            return value.rawValue
        case .custom(let string):
            return string
        }
    }
}
