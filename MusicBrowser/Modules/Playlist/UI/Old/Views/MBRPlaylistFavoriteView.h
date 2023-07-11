//
// MBRPlaylistFavoriteView.h
// MusicBrowser
//
        
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface MBRPlaylistFavoriteView : UIView

/// Indicates favorite status. An image appearance relays on this value.
@property (nonatomic, assign, getter=isFavorite) BOOL favorite;

/// Indicates whether the view should be editable: change `favorite` property on tap and trigger `onTap` block.
@property (nonatomic, assign, getter=isEnabled) BOOL enabled;

/// A block being invoked when a favorite status changes. Contains one parameter which is a new status.
@property (nonatomic, copy, nullable) void (^onTap)(BOOL);

@end

@interface MBRPlaylistFavoriteView (Unavailable)

- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
