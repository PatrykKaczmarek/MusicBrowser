//
// MBRPlaylistHeaderView.m
// MusicBrowser
//

#import "MBRPlaylistHeaderView.h"

@interface MBRPlaylistHeaderView ()

@property (nonatomic, strong, nonnull, readonly) UILabel *label;

@end

@implementation MBRPlaylistHeaderView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        _label = [[UILabel alloc] init];
        _label.font = [UIFont boldSystemFontOfSize:16];
        _label.text = title;
        [self addSubview:_label];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.label.frame = CGRectMake(10, 0, self.bounds.size.width - 20, self.bounds.size.height);
}

@end
