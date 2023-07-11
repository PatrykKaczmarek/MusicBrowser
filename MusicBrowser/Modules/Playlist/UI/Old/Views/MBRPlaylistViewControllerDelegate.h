//
// MBRPlaylistViewControllerDelegate.h
// MusicBrowser
//
        
@import Foundation;
@class MBRPlaylistViewController;
@protocol MBRAlbum;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(PlaylistViewControllerDelegate)
@protocol MBRPlaylistViewControllerDelegate <NSObject>

/// Informs a receiver that view controller requires to reload data, e.g. due to user's interaction.
/// - Parameter viewController: A view controller requesting data refresh.
- (void)refreshDataForPlaylistViewController:(MBRPlaylistViewController *)viewController;

/// Informs a receiver that the user did select given album which handling is out of scope of the view controller.
/// - Parameters:
///   - viewController: A view controller requesting to handle album selection.
///   - album: A selected album
- (void)playlistViewController:(MBRPlaylistViewController *)viewController didSelectAlbum:(id<MBRAlbum>)album;

/// Informs a receiver that the only favorites albums should be only visible.
/// - Parameter viewController: A view controller requesting to handle this action.
/// - SeeAlso: `MBRPlaylistViewOption.MBRPlaylistViewOptionAddFavoriteBarButton`.
- (void)playlistViewControllerShowFavoritesOnly:(MBRPlaylistViewController *)viewController;

/// Informs a receiver that the view controller did a change to an `Album` model to `isFavorite` property.
/// - Parameters:
///   - viewController: A view controller making the change.
///   - album: An album that has been change.
/// - SeeAlso: `MBRPlaylistViewOption.MBRPlaylistViewOptionAllowChangingFavorites`.
- (void)playlistViewController:(MBRPlaylistViewController *)viewController didChangeFavoriteValueInAlbum:(id<MBRAlbum>)album;

@end

NS_ASSUME_NONNULL_END
