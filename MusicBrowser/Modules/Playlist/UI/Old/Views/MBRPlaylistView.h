//
// MBRPlaylistView.h
// MusicBrowser
//

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MBRPlaylistViewLayoutType) {
    /// Displays a regular layout where all data are provided.
    MBRPlaylistViewLayoutTypeRegular,
    /// Displays a layout where there is no data to display.
    MBRPlaylistViewLayoutTypeEmpty,
};

@interface MBRPlaylistView : UIView

/// A type of the layout to be displayed by the receiver.
@property (nonatomic, assign) MBRPlaylistViewLayoutType layoutType;

/// A table view that displays data vertically.
@property (nonatomic, strong, nonnull, readonly) UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
