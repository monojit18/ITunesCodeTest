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

@interface MasterViewController () <UISearchBarDelegate>
{
    
    ITSSearchListModel* _pSearchListModel;
    
}

@property(nonatomic, strong) UISearchBar* searchBar;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
 
    UINavigationController* pc = [self.splitViewController.viewControllers lastObject];
    self.detailViewController = (DetailViewController *)pc.topViewController;
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    self.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchBar;
    
  // [self.tableView registerClass:[MasterTableViewCell class] forCellReuseIdentifier:@"MasterCell"];
    
    _pSearchListModel = [[ITSSearchListModel alloc] init];
    
}


- (void)viewWillAppear:(BOOL)animated {
    // self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _pSearchListModel.searchModelsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MasterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MasterCell" forIndexPath:indexPath];

    ITSSearchModel* pSearchModel = _pSearchListModel.searchModelsArray[indexPath.row];
    cell.trackNameLabel.text = pSearchModel.trackName;
    cell.artistNameLabel.text = pSearchModel.artistName;
    
    if (pSearchModel.artWorkData)
        cell.artWorkImageView.image = [UIImage imageWithData:pSearchModel.artWorkData];
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ITSSearchModel* pSearchModel = _pSearchListModel.searchModelsArray[indexPath.row];
    [self.detailViewController setSearchModel:pSearchModel];
    self.detailViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    self.detailViewController.navigationItem.leftItemsSupplementBackButton = YES;
    
    [self.navigationController pushViewController:self.detailViewController animated:YES];
    
}


#pragma mark - SearchBar delegate methods

-(void)searchBarSearchButtonClicked:(UISearchBar *) pSearchBar
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [_pSearchListModel search:pSearchBar.text withCallbackAsync:^(BaseAppModel *pAppModel, NSError *pError)
     {
        
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         [self.tableView reloadData];
         
         
     }];
    
    
}


@end
