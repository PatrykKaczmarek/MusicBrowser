//
// DefaultAppFoundation.swift
// MusicBrowser
//

import UIKit

final class DefaultAppFoundation: AppFoundation {

    // MARK: Initializer

    /// Initializes app foundation.
    ///
    /// - Parameters:
    ///   - window: A window used by the application.
    init(window: UIWindow) {
        hudPresenter = DefaultAppHUDPresenter(window: window)
        let apiClient = DefaultAPIClient(configuration: MusicBrowserAPIConfiguration())
        services = DefaultAppServices(apiClient: apiClient)
    }

    // MARK: AppFoundation

    /// - SeeAlso: AppFoundation.services
    let services: AppServices

    /// - SeeAlso: AppFoundation.hudPresenter
    let hudPresenter: AppHUDPresenter
}
