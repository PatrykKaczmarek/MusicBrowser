//
// PlaylistFlowController.swift
// MusicBrowser
//

import UIKit
import SwiftUI

final class PlaylistFlowController: NSObject, AppFlowController {

    // MARK: AppFlowController

    let rootViewController: UIViewController?

    let appFoundation: AppFoundation

    // MARK: Initializer

    init(appFoundation: AppFoundation) {
        let viewController = PlaylistViewController(
            options: [.addFavoriteBarButton, .allowReloading]
        )
        self.appFoundation = appFoundation
        self.rootViewController = viewController
        super.init()

        viewController.delegate = self
        viewController.dataSource = self
    }
}
// MARK: PlaylistViewControllerDelegate

extension PlaylistFlowController: PlaylistViewControllerDelegate {
    func playlistViewControllerShowFavoritesOnly(_ viewController: PlaylistViewController) {
        let favoritesViewController = PlaylistViewController(
            options: [.allowChangingFavorites, .addCloseBarButton]
        )
        favoritesViewController.delegate = self
        favoritesViewController.dataSource = self
        let navigationController = UINavigationController(rootViewController: favoritesViewController)
        navigationController.modalPresentationStyle = .fullScreen
        viewController.present(navigationController, animated: true)
    }

    func playlistViewController(
        _ viewController: PlaylistViewController,
        didChangeFavoriteValueIn album: Album
    ) {
        savePlaylists()()
    }

    func playlistViewController(_ viewController: PlaylistViewController, didSelect album: Album) {
        guard let storableAlbum = album as? StorableAlbum else {
            return
        }
        var albumView = AlbumView(album: storableAlbum)
        albumView.onFavoriteChange = savePlaylists()
        let hostingViewController = UIHostingController(rootView: albumView)
        viewController.navigationController?.pushViewController(hostingViewController, animated: true)
    }

    func refreshData(for viewController: PlaylistViewController) {
        showHUD(message: "screen.playlist.loading.title".localized())
        appFoundation.services.playlistService.provideData(forceFetch: false) { [weak self] result in
            self?.hideHUD()
            switch result {
            case .success:
                viewController.reload()
            case .failure(let error):
                self?.presentNoopAlert(error: error)
            }
        }
    }
}

// MARK: PlaylistViewControllerDataSource

extension PlaylistFlowController: PlaylistViewControllerDataSource {
    func playlistsToDisplay(by viewController: PlaylistViewController) -> [Playlist] {
        let playlists = appFoundation.services.playlistService.models
        return viewController.isShowingFavorites ? [
            StorablePlaylist(
                identifier: UUID().uuidString,
                title: "",
                albums: playlists.flatMap { $0.storableAlbums }.filter { $0.isFavorite }
            )
        ] : playlists
    }
}

// MARK: Private

private extension PlaylistFlowController {
    func savePlaylists() -> () -> Void {
        { [weak self] in
            do {
                try self?.appFoundation.services.playlistService.saveData()
            } catch {
                self?.presentNoopAlert(error: error)
            }
        }
    }
}

// MARK: Private + PlaylistViewController

private extension PlaylistViewController {
    var isShowingFavorites: Bool {
        options.contains(.allowChangingFavorites)
    }
}
