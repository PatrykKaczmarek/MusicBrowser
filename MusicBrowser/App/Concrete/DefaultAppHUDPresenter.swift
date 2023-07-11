//
// DefaultAppHUDPresenter.swift
// MusicBrowser
//

import UIKit
        
final class DefaultAppHUDPresenter: AppHUDPresenter {

    // MARK: Properties

    private let window: UIWindow

    private var hud: ActivityIndicatorView? {
        window.subviews.compactMap { $0 as? ActivityIndicatorView }.first
    }

    // MARK: Initializer

    /// Initializes class that presents HUD over given window.
    ///
    /// - Parameter window: A window being used for presenting HUDs.
    init(window: UIWindow) {
        self.window = window
    }

    // MARK: HUDPresenter

    /// - SeeAlso: HUDPresenter.presentsHUD
    var presentsHUD: Bool {
        hud != nil
    }

    /// - SeeAlso: HUDPresenter.show()
    func show(message: String?) {
        guard !presentsHUD else {
            return
        }
        let hud = ActivityIndicatorView(frame: window.bounds)
        hud.message = message
        window.addSubview(hud)
        hud.startAnimating()
    }

    /// - SeeAlso: HUDPresenter.hide()
    func hide() {
        hud?.stopAnimating { view in
            view.removeFromSuperview()
        }
    }
}
