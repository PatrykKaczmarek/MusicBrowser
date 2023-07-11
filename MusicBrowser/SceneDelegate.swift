//
// SceneDelegate.swift
// MusicBrowser
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties

    var window: UIWindow?

    /// The main application flow controller.
    private var flowController: AppFlowController?

    // MARK: - UIWindowSceneDelegate

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else {
            return
        }

        let window = UIWindow(windowScene: scene)
        let appFoundation = DefaultAppFoundation(window: window)
        flowController = PlaylistFlowController(appFoundation: appFoundation)
        window.rootViewController = flowController?.rootViewController.flatMap {
            UINavigationController(rootViewController: $0)
        }
        window.makeKeyAndVisible()
        self.window = window
    }
}
