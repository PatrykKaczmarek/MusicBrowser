//
// UIView+Extensions.h
// MusicBrowser
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extensions)

/// Configures an existing view to not convert the autoresizing mask into constraints and returns its instance.
- (instancetype)shc_configureForAutoLayout;

@end

NS_ASSUME_NONNULL_END
