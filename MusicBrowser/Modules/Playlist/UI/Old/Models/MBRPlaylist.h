//
// MBRPlaylist.h
// MusicBrowser
//
        
@import Foundation;
@protocol MBRAlbum;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Playlist)
@protocol MBRPlaylist

/// An identifier of the playlist.
@property (nonatomic, strong, readonly) NSString *identifier;

/// A title of the playlist.
@property (nonatomic, strong, readonly) NSString *title;

/// An array of albums that this playlist consists of.
@property (nonatomic, strong, readonly) NSArray<id<MBRAlbum>> *albums;

@end

NS_ASSUME_NONNULL_END
