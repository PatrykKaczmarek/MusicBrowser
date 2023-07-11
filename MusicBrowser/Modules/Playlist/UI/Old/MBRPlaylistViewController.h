//
// MBRPlaylistViewController.h
// MusicBrowser
//

@import UIKit;

#import "MBRPlaylistViewControllerDelegate.h"
#import "MBRPlaylistViewControllerDataSource.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(PlaylistViewOption)
typedef NS_OPTIONS (NSInteger, MBRPlaylistViewOption) {
    /// Add a favorite bar button on the right side of the navigation bar.
    MBRPlaylistViewOptionAddFavoriteBarButton= 1 << 0,
    /// Add a close bar button on the right side of the navigation bar.
    MBRPlaylistViewOptionAddCloseBarButton= 1 << 1,
    /// Assumes that the receiver displays favorites albums only when favorite status may change.
    MBRPlaylistViewOptionAllowChangingFavorites = 1 << 2,
    /// Indicates whether the user may reload the data manually.
    MBRPlaylistViewOptionAllowReloading = 1 << 3,
};

NS_SWIFT_NAME(PlaylistViewController)
@interface MBRPlaylistViewController: UIViewController

/// Initializes an instance of the receiver with given options.
/// - Parameter options: A set of options allowing configuration of the receiver's behavior.
- (instancetype)initWithOptions:(MBRPlaylistViewOption)options;

@property (nonatomic, assign, readonly) MBRPlaylistViewOption options;

/// An instance of delegate that should respond to user's interaction or handle the view controller tasks that cannot be handled internally.
@property (nonatomic, weak, nullable) id<MBRPlaylistViewControllerDelegate> delegate;

/// An instance of data source that the view controller uses to display its content.
@property (nonatomic, weak, nullable) id<MBRPlaylistViewControllerDataSource> dataSource;

/// Reloads the receiver's content.
- (void)reload;

@end

@interface MBRPlaylistViewController (Unavailable)

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
