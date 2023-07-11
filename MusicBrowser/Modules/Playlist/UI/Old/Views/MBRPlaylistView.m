//
// MBRPlaylistView.m
// MusicBrowser
//

#import "MBRPlaylistView.h"

@interface MBRPlaylistView ()

@property (nonatomic, strong, nonnull, readonly) UILabel *placeholderLabel;

@end

@implementation MBRPlaylistView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[[UITableView alloc] init] shc_configureForAutoLayout];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 200;
        _tableView.allowsSelection = NO;
        [self addSubview:_tableView];

        _placeholderLabel = [[[UILabel alloc] init] shc_configureForAutoLayout];
        _placeholderLabel.textAlignment = NSTextAlignmentCenter;
        _placeholderLabel.font = [UIFont systemFontOfSize:14];
        _placeholderLabel.text = NSLocalizedString(@"screen.playlist.empty.title", @"A placeholder displayed when there are no albums to display.");
        [self addSubview:_placeholderLabel];

        [NSLayoutConstraint activateConstraints:@[
            [self.tableView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [self.tableView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
            [self.tableView.topAnchor constraintEqualToAnchor:self.topAnchor],
            [self.tableView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],

            [self.placeholderLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
            [self.placeholderLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor]
        ]];

        [self setLayoutType:MBRPlaylistViewLayoutTypeRegular];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

#pragma mark - Accessors

- (void)setLayoutType:(MBRPlaylistViewLayoutType)layoutType {
    [self.tableView setHidden:layoutType == MBRPlaylistViewLayoutTypeEmpty];
    [self.placeholderLabel setHidden:layoutType == MBRPlaylistViewLayoutTypeRegular];
}

@end
