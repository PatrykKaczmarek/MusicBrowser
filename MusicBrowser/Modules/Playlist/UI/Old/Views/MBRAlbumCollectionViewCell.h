//
// MBRAlbumCollectionViewCell.h
// MusicBrowser
//
        
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

extern CGFloat const MBRAlbumCollectionViewCellDesignatedWidth;
extern NSString * const MBRAlbumCollectionViewCellIdentifier;

typedef NS_ENUM(NSUInteger, MBRAlbumCollectionViewCellLayoutType) {
    /// Displays a regular layout where all data are provided.
    MBRAlbumCollectionViewCellLayoutTypeRegular,
    /// Displays a layout with activity indicator rendered above all subviews.
    MBRAlbumCollectionViewCellLayoutTypeLoading,
};

@interface MBRAlbumCollectionViewCell : UICollectionViewCell

/// A type of the layout to be displayed by the receiver.
@property (nonatomic, assign) MBRAlbumCollectionViewCellLayoutType layoutType;

/// A block being invoked when a favorite status changes. Contains one parameter which is a new status.
@property (nonatomic, copy, nullable) void (^onFavoriteStatusChange)(BOOL);

/// Sets album's title.
/// - Parameter title: A title of the album to set.
- (void)setTitle:(nullable NSString *)title;

/// Loads an image from the external resource at given url using given session.
/// - Parameters:
///   - url: A url pointing to the external image on the server.
///   - session: Session used for the image download. Weakly stored.
- (void)loadImageFromURL:(NSURL *)url usingSession:(__weak NSURLSession *)session;

/// Sets visibility of indicator whether the album is favorite.
/// - Parameters:
///   - favorite: A favorite status.
///   - allowChanges: Indicates whether a favorite status is allowed to change.
- (void)setFavorite:(BOOL)favorite allowChanges:(BOOL)allowChanges;

@end

@interface MBRAlbumCollectionViewCell (Unavailable)

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
