//
// MBRPlaylistCollectionView.m
// MusicBrowser
//
        
#import "MBRPlaylistCollectionView.h"

@implementation MBRPlaylistCollectionView

- (instancetype)init {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 24, 0, 24);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 16;
    flowLayout.estimatedItemSize = CGSizeMake(200, 200);

    self = [super initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    return self;
}

@end
