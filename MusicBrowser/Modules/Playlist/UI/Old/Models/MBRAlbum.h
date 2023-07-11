//
// MBRAlbum.h
// MusicBrowser
//
        
@import Foundation;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Album)
@protocol MBRAlbum

/// An identifier of the album.
@property (nonatomic, strong, readonly) NSString *identifier;

/// A title of the album.
@property (nonatomic, strong, readonly) NSString *title;

/// A url resource for the cover image given as a string.
@property (nonatomic, strong, readonly) NSString *coverURLString;

/// A url resource for the cover image given as a string.
@property (nonatomic, assign, readwrite, getter=isFavorite) BOOL favorite;

@end

NS_ASSUME_NONNULL_END
