//
// MBRHomeTableViewCell.m
// MusicBrowser
//

#import "MBRPlaylistTableViewCell.h"
#import "MBRAlbumCollectionViewCell.h"

NSString * const MBRPlaylistTableViewCelldentifier = @"MBRPlaylistTableViewCelldentifier";

@interface MBRPlaylistTableViewCell ()

@property (nonatomic, strong, nonnull, readonly) UILabel *placeholderLabel;

@end

@implementation MBRPlaylistTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _collectionView = [[[MBRPlaylistCollectionView alloc] init] shc_configureForAutoLayout];
        [_collectionView
            registerClass:[MBRAlbumCollectionViewCell class]
            forCellWithReuseIdentifier:MBRAlbumCollectionViewCellIdentifier
        ];
        [self.contentView addSubview:_collectionView];

        _placeholderLabel = [[[UILabel alloc] init] shc_configureForAutoLayout];
        _placeholderLabel.font = [UIFont systemFontOfSize:14];
        _placeholderLabel.textAlignment = NSTextAlignmentCenter;
        _placeholderLabel.text = NSLocalizedString(@"cell.playlist.empty.title", @"Title is displayed  when a playlist consists of 0 albums. It's a placeholder.");
        [self.contentView addSubview:_placeholderLabel];

        [NSLayoutConstraint activateConstraints:@[
            [self.collectionView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
            [self.collectionView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
            [self.collectionView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
            [self.collectionView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
            [self.collectionView.heightAnchor constraintEqualToConstant:200],


            [self.placeholderLabel.leadingAnchor constraintEqualToAnchor:self.collectionView.leadingAnchor],
            [self.placeholderLabel.trailingAnchor constraintEqualToAnchor:self.collectionView.trailingAnchor],
            [self.placeholderLabel.topAnchor constraintEqualToAnchor:self.collectionView.topAnchor],
            [self.placeholderLabel.bottomAnchor constraintEqualToAnchor:self.collectionView.bottomAnchor],
        ]];
        self.userInteractionEnabled = YES;
        self.layoutType = MBRPlaylistTableViewCellLayoutTypeRegular;
    }
    return self;
}

#pragma mark - Accessors

- (void)setLayoutType:(MBRPlaylistTableViewCellLayoutType)layoutType {
    switch (layoutType) {
        case MBRPlaylistTableViewCellLayoutTypeEmpty:
            [self.collectionView setHidden:YES];
            [self.placeholderLabel setHidden:NO];
            break;
        case MBRPlaylistTableViewCellLayoutTypeRegular:
            [self.collectionView setHidden:NO];
            [self.placeholderLabel setHidden:YES];
            break;
    }
}

@end
