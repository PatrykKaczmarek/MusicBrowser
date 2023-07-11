//
// MBRPlaylistHeaderView.h
// MusicBrowser
//
        
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface MBRPlaylistHeaderView : UIView

/// Initializes an instance of the receiver.
/// - Parameters:
///   - frame: The frame rectangle for the receiver relative to the superview.
///   - title: A title of the header.
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

@end

@interface MBRPlaylistHeaderView (Unavailable)

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
