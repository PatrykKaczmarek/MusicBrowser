//
// AppFlowController.swift
// MusicBrowser
//

import UIKit

protocol AppFlowController {

    /// The root view controller of the current flow.
    var rootViewController: UIViewController? { get }

    /// Foundation of the application that serves as a source of classes, structs, models or data
    /// that should be taken only from one place conforming to "single source of truth" methodology.
    var appFoundation: AppFoundation { get }

    /// Presents a no-op alert with a close button and optional title and message.
    /// Popup is automatically localized in language currenly used by a user.
    ///
    /// - Parameters:
    ///   - title: A title of the alert.
    ///   - message: A message of the alert.
    func presentNoopAlert(title: String?, message: String?, closeHandler: (() -> Void)?)

    /// Presents a no-op alert with a close button on a rootViewController.
    /// `error.localizedDescription` is used as a message.
    /// Title will be generic.
    ///
    /// - Parameter error: An error to be displayed.
    func presentNoopAlert(error: Error, closeHandler: (() -> Void)?)

    /// Presents HUD over entire content and blocks user interaction.
    /// - Parameter message: An optional HUD message
    ///
    /// - Warning: Only one HUD will be presented at once.
    func showHUD(message: String?)

    /// Hides HUD.
    func hideHUD()
}

extension AppFlowController {

    func presentNoopAlert(title: String? = nil, message: String? = nil, closeHandler: (() -> Void)? = nil) {
        rootViewController?.presentNoopAlert(
            title: title,
            message: message,
            closeHandler: closeHandler
        )
    }

    func presentNoopAlert(error: Error, closeHandler: (() -> Void)? = nil) {
        rootViewController?.presentNoopAlert(
            title: genericTitle,
            message: error.localizedDescription,
            closeHandler: closeHandler
        )
    }

    func showHUD() {
        showHUD(message: nil)
    }

    func showHUD(message: String?) {
        appFoundation.hudPresenter.show(message: message)
    }

    func hideHUD() {
        appFoundation.hudPresenter.hide()
    }
}

// MARK: Private

private extension AppFlowController {
    var genericTitle: String {
        "alert.title.generic.text".localized()
    }
}
