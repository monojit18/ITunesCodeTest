//
//  MasterViewController.m
//  ITunesSearch
//
//  Created by Monojit Datta on 22/11/16.
//  Copyright © 2016 Monojit Datta. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ITSSearchListModel.h"
#import "MasterTableViewCell.h"

const NSString* const kCellIdentifierString = @"MasterCell";

@interface MasterViewController () <UISearchBarDelegate>
{
    
    ITSSearchListModel* _pSearchListModel;
    
}

@property(nonatomic, strong) UISearchBar* searchBar;

-(void) refreshViewBindings:(ITSSearchModel*) pSearchModel;

@end

@implementation MasterViewController

#pragma mark - Private Methods

-(void) refreshViewBindings:(ITSSearchModel*) pSearchModel
{
    
    NSUInteger index = [_pSearchListModel.searchModelsArray indexOfObject:pSearchModel];
    NSIndexPath* pIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    [self.tableView reloadRowsAtIndexPaths:@[pIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    
}

#pragma mark - View Callbacks

- (void)viewDidLoad
{
    
    [super viewDidLoad];
 
    UINavigationController* pNavigationController = [self.splitViewController.viewControllers lastObject];
    self.detailViewController = (DetailViewController*)(pNavigationController.topViewController);
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    self.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchBar;
    
    _pSearchListModel = [[ITSSearchListModel alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OnRefresh:) name:@"OnRefresh" object:nil];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

-(void) dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
//    if ([[segue identifier] isEqualToString:@"showDetail"])
//    {
//        
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        ITSSearchModel* pSearchModel = _pSearchListModel.searchModelsArray[indexPath.row];
//        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
//        [controller setSearchModel:pSearchModel];
//        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
//        controller.navigationItem.leftItemsSupplementBackButton = YES;
//    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_pSearchListModel || !(_pSearchListModel.searchModelsArray))
        return 1;
    
    return _pSearchListModel.searchModelsArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MasterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString*)kCellIdentifierString
                                                                forIndexPath:indexPath];
    
    if (!_pSearchListModel || !(_pSearchListModel.searchModelsArray.count))
    {
        
        cell.artWorkImageView.hidden = YES;
        cell.trackNameLabel.text = @"No Data to display";
        cell.artistNameLabel.text = nil;
        
        return cell;
        
    }

    cell.artWorkImageView.hidden = NO;
    ITSSearchModel* pSearchModel = _pSearchListModel.searchModelsArray[indexPath.row];
    cell.trackNameLabel.text = pSearchModel.trackName;
    cell.artistNameLabel.text = pSearchModel.artistName;
    
    if (pSearchModel.artWorkData)
        cell.artWorkImageView.image = [UIImage imageWithData:pSearchModel.artWorkData];
    
    return cell;
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return NO;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ITSSearchModel* pSearchModel = _pSearchListModel.searchModelsArray[indexPath.row];
    if (!pSearchModel || !(self.detailViewController))
        return;
    
    [self.detailViewController setSearchModel:pSearchModel];
    self.detailViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    self.detailViewController.navigationItem.leftItemsSupplementBackButton = YES;
    
    [self.navigationController pushViewController:self.detailViewController animated:YES];
    
}


#pragma mark - SearchBar delegate methods

-(void)searchBarSearchButtonClicked:(UISearchBar *) pSearchBar
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    __weak typeof(self) pWeakSelf = self;
    [_pSearchListModel search:pSearchBar.text withCallbackAsync:^(BaseAppModel *pAppModel, NSError *pError)
     {
        
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         [pWeakSelf.tableView reloadData];
         
     }];
    
}

#pragma mark - Notification methods

-(void) OnRefresh:(NSNotification*) pNotification
{
    
    ITSSearchModel* pSearchModel = pNotification.userInfo[@"searchModel"];
    if (!pSearchModel)
        return;
    
    [self refreshViewBindings:pSearchModel];

}

@end
