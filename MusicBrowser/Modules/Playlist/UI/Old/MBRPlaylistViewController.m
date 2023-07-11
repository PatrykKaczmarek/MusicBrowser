//
// MBRPlaylistViewController.m
// MusicBrowser
//

#import "MBRPlaylistViewController.h"
#import "MBRPlaylistView.h"
#import "MBRPlaylistTableViewCell.h"
#import "MBRAlbumCollectionViewCell.h"
#import "MBRPlaylist.h"
#import "MBRAlbum.h"
#import "MBRPlaylistViewControllerDelegate.h"
#import "MBRPlaylistViewControllerDataSource.h"
#import "MBRPlaylistHeaderView.h"

@interface MBRPlaylistViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic, nullable, readonly) MBRPlaylistView *mainView;

@property (strong, nonnull, nonatomic) NSURLSession *session;

@end

@implementation MBRPlaylistViewController

- (instancetype)initWithOptions:(MBRPlaylistViewOption)options {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _options = options;
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
}

- (void)loadView {
    self.view = [[MBRPlaylistView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavigationBar];
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshData];
}

#pragma mark - API

- (void)reload {
    [self.mainView.tableView.refreshControl endRefreshing];
    [self.mainView.tableView reloadData];
    [self setupNavigationBar];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    id<MBRPlaylist> playlist = [self playlists][section];
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    CGRect frame = CGRectMake(0, 0, tableView.bounds.size.width, height);
    return [[MBRPlaylistHeaderView alloc] initWithFrame:frame title:playlist.title];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self playlists].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MBRPlaylistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MBRPlaylistTableViewCelldentifier];
    NSArray<id<MBRAlbum>> *albums = [self playlists][indexPath.section].albums;
    if (albums.count == 0) {
        cell.layoutType = MBRPlaylistTableViewCellLayoutTypeEmpty;
        cell.collectionView.delegate = nil;
        cell.collectionView.dataSource = nil;
    } else {
        cell.layoutType = MBRPlaylistTableViewCellLayoutTypeRegular;
        cell.collectionView.delegate = self;
        cell.collectionView.dataSource = self;
    }
    cell.collectionView.identifier = indexPath.section;
    [cell.collectionView reloadData];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self playlists][section].albums.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(MBRAlbumCollectionViewCellDesignatedWidth, collectionView.bounds.size.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    id<MBRAlbum> album = [self albumAtIndexPath:indexPath inCollectionView:collectionView];
    if (album && [self.delegate respondsToSelector:@selector(playlistViewController:didSelectAlbum:)]) {
        [self.delegate playlistViewController:self didSelectAlbum:album];
    }
}

#pragma mark - UICollectionViewDataSource

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MBRAlbumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MBRAlbumCollectionViewCellIdentifier forIndexPath:indexPath];

    id<MBRAlbum> album = [self albumAtIndexPath:indexPath inCollectionView:collectionView];
    if (!album) {
        return cell;
    }
    BOOL allowFavoriteChange = (self.options & MBRPlaylistViewOptionAllowChangingFavorites) != 0;
    [cell setTitle:album.title];
    [cell setFavorite:album.isFavorite allowChanges:allowFavoriteChange];

    __weak typeof(self) weakSelf = self;
    cell.onFavoriteStatusChange = allowFavoriteChange ? ^(BOOL isFavorite) {
        [weakSelf changeFavoriteValue:isFavorite inAlbum:album];
    } : nil;

    NSURL *url = [[NSURL alloc] initWithString:album.coverURLString];
    if (url) {
        [cell loadImageFromURL:url usingSession:self.session];
    }
    return cell;
}

#pragma mark - Internal

- (void)setupNavigationBar {
    BOOL isShowingFavorites = (self.options & MBRPlaylistViewOptionAllowChangingFavorites) != 0;
    self.title = isShowingFavorites
        ? NSLocalizedString(@"screen.playlist.navigation.title.favorites", @"A navigation title on a favorite albums screen")
        : NSLocalizedString(@"screen.playlist.navigation.title", @"A navigation title on a playlists screen");

    NSMutableArray<UIBarButtonItem *> *barButtonItems = [NSMutableArray array];
    if ((self.options & MBRPlaylistViewOptionAddFavoriteBarButton) != 0) {
        [barButtonItems addObject:[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"screen.playlist.navigation.button.favorites", @"A title of the right navigation button that should show favorite albums only.") style:UIBarButtonItemStylePlain target:self action:@selector(showFavorites)]];
    }
    if ((self.options & MBRPlaylistViewOptionAddCloseBarButton) != 0) {
        [barButtonItems addObject:[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"screen.playlist.navigation.button.close", @"A title of the right navigation button that should dismiss a screen.") style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)]];
    }
    self.navigationItem.rightBarButtonItems = barButtonItems;

    self.mainView.layoutType = [self playlists].count == 0
        ? MBRPlaylistViewLayoutTypeEmpty
        : MBRPlaylistViewLayoutTypeRegular;
}

- (void)setupTableView {
    BOOL allowReloading = (self.options & MBRPlaylistViewOptionAllowReloading) != 0;
    if (allowReloading) {
        self.mainView.tableView.refreshControl = ^{
            UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
            [refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
            return refreshControl;
        }();
    }
    self.mainView.tableView.delegate = self;
    self.mainView.tableView.dataSource = self;
    [self.mainView.tableView
        registerClass:[MBRPlaylistTableViewCell class]
        forCellReuseIdentifier:MBRPlaylistTableViewCelldentifier
    ];
}

- (void)refreshData {
    if ([self.delegate respondsToSelector:@selector(refreshDataForPlaylistViewController:)]) {
        [self.delegate refreshDataForPlaylistViewController:self];
    }
}

- (void)showFavorites {
    if ([self.delegate respondsToSelector:@selector(playlistViewControllerShowFavoritesOnly:)]) {
        [self.delegate playlistViewControllerShowFavoritesOnly:self];
    }
}

- (void)dismiss {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)changeFavoriteValue:(BOOL)newValue inAlbum:(id<MBRAlbum>)album {
    album.favorite = newValue;
    if ([self.delegate respondsToSelector:@selector(playlistViewController:didChangeFavoriteValueInAlbum:)]) {
        [self.delegate playlistViewController:self didChangeFavoriteValueInAlbum:album];
        [self refreshData];
    }
}

- (nullable NSArray<id<MBRPlaylist>> *)playlists {
    if ([self.dataSource respondsToSelector:@selector(playlistsToDisplayByViewController:)]) {
        return [self.dataSource playlistsToDisplayByViewController:self];
    }
    return nil;
}

- (nullable id<MBRAlbum>)albumAtIndexPath:(NSIndexPath *)indexPath inCollectionView:(UICollectionView *)collectionView {
    MBRPlaylistCollectionView *playlistCollectionView = [collectionView isKindOfClass:[MBRPlaylistCollectionView class]] ? (id)collectionView : nil;
    if (!playlistCollectionView) {
        return nil;
    }
    return [self playlists][playlistCollectionView.identifier].albums[indexPath.row];
}

#pragma mark - Accessors

- (MBRPlaylistView *)mainView {
    return (id)self.view;
}

@end
