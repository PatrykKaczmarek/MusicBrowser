//
// UIViewController.swift
// MusicBrowser
//

import UIKit

extension UIViewController {
    /// Presents a no-op alert with a close button.
    ///
    /// - Parameters:
    ///   - title: A title of the alert.
    ///   - message: A message of the alert.
    ///   - closeHandler: A closure that invokes on `close` button tap.
    func presentNoopAlert(
        title: String? = nil,
        message: String? = nil,
        closeHandler: (() -> Void)? = nil
    ) {
        if let presentedViewController = presentedViewController {
            let presentAlert = !(presentedViewController is UIAlertController)
            if presentAlert {
                presentedViewController.presentNoopAlert(
                    title: title,
                    message: message,
                    closeHandler: closeHandler
                )
            }
        } else {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(
                title: closeTitle,
                style: .default,
                handler: { _ in
                    closeHandler?()
                }
            ))
            present(alertController, animated: true)
        }
    }
}

// MARK: Private

private extension UIViewController {
    var closeTitle: String {
        "alert.close.text".localized()
    }
}
