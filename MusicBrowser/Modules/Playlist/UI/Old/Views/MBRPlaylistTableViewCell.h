//
// MBRPlaylistTableViewCell.h
// MusicBrowser
//
        
@import UIKit;
#import "MBRPlaylistCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const MBRPlaylistTableViewCelldentifier;

typedef NS_ENUM(NSUInteger, MBRPlaylistTableViewCellLayoutType) {
    /// Displays a placeholder label for indicating empty album.
    MBRPlaylistTableViewCellLayoutTypeEmpty,
    /// Displays a regular layout for populating collection view with albums.
    MBRPlaylistTableViewCellLayoutTypeRegular
};

@interface MBRPlaylistTableViewCell : UITableViewCell

/// An instance of collection view which displays playlist's albums horizontally.
@property (nonatomic, strong, nonnull, readonly) MBRPlaylistCollectionView *collectionView;

/// A type of the layout to be displayed by the receiver.
@property (nonatomic, assign) MBRPlaylistTableViewCellLayoutType layoutType;

@end

@interface MBRPlaylistTableViewCell (Unavailable)

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
