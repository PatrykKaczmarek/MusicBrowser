//
// MBRPlaylistViewControllerDataSource.h
// MusicBrowser
//
        
@import Foundation;
@class MBRPlaylistViewController;
@protocol MBRPlaylist;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(PlaylistViewControllerDataSource)
@protocol MBRPlaylistViewControllerDataSource <NSObject>

/// An array of playlists that should be displayed on the playlists screen.
/// - Parameter viewController: A view controller displaying playlists.
- (NSArray<id<MBRPlaylist>> *)playlistsToDisplayByViewController:(MBRPlaylistViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
