//
// MBRAlbumCollectionViewCell.m
// MusicBrowser
//

#import "MBRAlbumCollectionViewCell.h"
#import "MBRPlaylistFavoriteView.h"

CGFloat const MBRAlbumCollectionViewCellDesignatedWidth = 150;
NSString * const MBRAlbumCollectionViewCellIdentifier = @"MBRAlbumCollectionViewCellIdentifier";

@interface MBRAlbumCollectionViewCell ()

@property (nonatomic, strong, nonnull, readonly) UILabel *label;

@property (nonatomic, strong, nonnull, readonly) UIImageView *imageView;

@property (nonatomic, weak, nullable) NSURLSessionDownloadTask *imageDownloadTask;

@property (nonatomic, strong, nonnull, readonly) MBRPlaylistFavoriteView *favoriteView;

@property (nonatomic, strong, nonnull, readonly) UIActivityIndicatorView *activityIndicatorView;

@end


@implementation MBRAlbumCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[[UILabel alloc] init] shc_configureForAutoLayout];
        _label.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_label];

        _imageView = [[[UIImageView alloc] init] shc_configureForAutoLayout];
        _imageView.backgroundColor = UIColor.lightGrayColor;
        _imageView.tintColor = UIColor.whiteColor;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imageView];

        _favoriteView = [[[MBRPlaylistFavoriteView alloc] init] shc_configureForAutoLayout];
        [self.contentView addSubview:_favoriteView];

        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
        [_activityIndicatorView shc_configureForAutoLayout];
        _activityIndicatorView.color = UIColor.redColor;
        [self.contentView addSubview:_activityIndicatorView];

        [NSLayoutConstraint activateConstraints:@[
            [self.imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
            [self.imageView.heightAnchor constraintEqualToAnchor:self.imageView.widthAnchor],
            [self.imageView.widthAnchor constraintEqualToConstant:MBRAlbumCollectionViewCellDesignatedWidth],
            [self.imageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
            [self.imageView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],

            [self.favoriteView.trailingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant:-8],
            [self.favoriteView.bottomAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:-8],
            [self.favoriteView.heightAnchor constraintEqualToConstant:44],
            [self.favoriteView.widthAnchor constraintEqualToConstant:44],

            [self.label.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
            [self.label.widthAnchor constraintLessThanOrEqualToAnchor:self.imageView.widthAnchor],
            [self.label.topAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:8],
            [self.label.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],

            [self.activityIndicatorView.centerXAnchor constraintEqualToAnchor:self.imageView.centerXAnchor],
            [self.activityIndicatorView.centerYAnchor constraintEqualToAnchor:self.imageView.centerYAnchor]
        ]];
        [self.contentView setUserInteractionEnabled:YES];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];

    self.layoutType = MBRAlbumCollectionViewCellLayoutTypeRegular;
    self.imageView.image = nil;
    self.onFavoriteStatusChange = nil;
    [self setTitle:nil];
    [self setFavorite:NO allowChanges:NO];
    [self.imageDownloadTask cancel];
}

#pragma mark - API

- (void)setTitle:(NSString *)title {
    self.label.text = title;
}

- (void)loadImageFromURL:(NSURL *)url usingSession:(NSURLSession *)session {
    [self.imageDownloadTask cancel];
    self.layoutType = MBRAlbumCollectionViewCellLayoutTypeLoading;

    __weak typeof(self) weakSelf = self;
    self.imageDownloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *image = nil;

        if (location) {
            image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        }
        if (!image) {
            image = [[UIImage systemImageNamed:@"photo.artframe"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.layoutType = MBRAlbumCollectionViewCellLayoutTypeRegular;
            weakSelf.imageView.image = image;
        });
    }];
    [self.imageDownloadTask resume];
}

- (void)setFavorite:(BOOL)favorite allowChanges:(BOOL)allowChanges {
    [self.favoriteView setEnabled:allowChanges];
    [self.favoriteView setFavorite:favorite];
}

#pragma mark - Accessors

- (void)setLayoutType:(MBRAlbumCollectionViewCellLayoutType)layoutType {
    switch (layoutType) {
        case MBRAlbumCollectionViewCellLayoutTypeRegular:
            [self.activityIndicatorView stopAnimating];
            break;
        case MBRAlbumCollectionViewCellLayoutTypeLoading:
            [self.activityIndicatorView startAnimating];
            break;
    }
}

- (void)setOnFavoriteStatusChange:(void (^)(BOOL))onFavoriteStatusChange {
    self.favoriteView.onTap = onFavoriteStatusChange;
}

@end
