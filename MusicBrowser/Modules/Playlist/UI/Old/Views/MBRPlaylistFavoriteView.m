//
// MBRPlaylistFavoriteView.m
// MusicBrowser
//
        
#import "MBRPlaylistFavoriteView.h"

@interface MBRPlaylistFavoriteView ()

@property (nonatomic, strong, nonnull, readonly) UIImageView *imageView;

@property (nonatomic, strong, nonnull, readonly) UITapGestureRecognizer *tapGestureRecognizer;

@property (nonatomic, strong, nonnull, readonly) UIVisualEffectView *visualEffectView;

@end

@implementation MBRPlaylistFavoriteView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIVisualEffect *visualEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterial];
        _visualEffectView = [[[UIVisualEffectView alloc] initWithEffect:visualEffect] shc_configureForAutoLayout];
        [_visualEffectView setClipsToBounds:YES];
        [self addSubview:self.visualEffectView];

        _imageView = [[[UIImageView alloc] init] shc_configureForAutoLayout];
        _imageView.tintColor = UIColor.yellowColor;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.image = [[UIImage systemImageNamed:@"star.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _imageView.tintColor = UIColor.yellowColor;
        [self addSubview:_imageView];


        [NSLayoutConstraint activateConstraints:@[
            [self.visualEffectView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [self.visualEffectView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
            [self.visualEffectView.topAnchor constraintEqualToAnchor:self.topAnchor],
            [self.visualEffectView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],

            [self.imageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
            [self.imageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
            [self.imageView.widthAnchor constraintEqualToConstant:28],
            [self.imageView.heightAnchor constraintEqualToAnchor:self.imageView.widthAnchor]
        ]];

        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewWasTapped)];
        [self addGestureRecognizer:self.tapGestureRecognizer];
        [self setFavorite:NO];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.visualEffectView.layer setCornerRadius:MIN(self.frame.size.width, self.frame.size.height) / 2];
}

#pragma mark - Actions

- (void)viewWasTapped {
    [self setFavorite:!self.isFavorite];
    if (self.onTap != NULL) {
        self.onTap(self.isFavorite);
    }
}

- (void)setEnabled:(BOOL)enabled {
    [self.tapGestureRecognizer setEnabled:enabled];
}

- (BOOL)isEnabled {
    return self.tapGestureRecognizer.enabled;
}

#pragma mark - Accessors

- (void)setFavorite:(BOOL)favorite {
    _favorite = favorite;
    [self setHidden:!favorite];
}

@end
