//
//  MasterViewController.m
//  LZSqlitePro
//
//  Created by comst on 15/10/26.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "LZManager.h"
#import "LZProductCell.h"
@interface MasterViewController ()


@property (nonatomic, strong) NSMutableArray *objects;

@property (nonatomic, strong) NSArray *filterArray;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchController *searchController;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.rowHeight = 80;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
//    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 50)];
//    self.tableView.tableHeaderView = self.searchBar;
//    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self];
//    self.tableView.tableHeaderView = self.searchController.searchBar;
//    self.searchController.searchBar.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 50);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (NSArray *)filterArray{
    
    if (!_filterArray) {
        
         LZManager *manager = [[LZManager alloc] init];
        _filterArray = [manager allProducts];
        
    }
    return _filterArray;
    
}
- (NSMutableArray *)objects{
    if (!_objects) {
        
        _objects = [NSMutableArray array];
        
        NSMutableArray *arraM ;
        arraM = [NSMutableArray array];
        
        LZManager *manager = [[LZManager alloc] init];
        NSArray *sourceArray ;
        sourceArray = [manager allProducts];
        
        UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
        
        for (LZProduct *item in sourceArray) {
            item.section = [collation sectionForObject:item collationStringSelector:@selector(name)];
        }
        
        for (NSInteger i = 0; i < [collation sectionIndexTitles].count; i ++) {
            
            NSMutableArray *singleArray = [NSMutableArray array];
            
            [arraM addObject:singleArray];
            
        }
        
        for (LZProduct *item in sourceArray) {
            
            NSMutableArray *sectionArray = [arraM objectAtIndex:item.section];
            
            [sectionArray addObject:item];
        }
        
        
        for (NSMutableArray *arrayItem in arraM) {
            
            NSArray *sortArray = [collation sortedArrayFromArray:arrayItem collationStringSelector:@selector(name)];
            [_objects addObject:sortArray];
        }
        
        
        
    }
    return _objects;
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.objects count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.objects[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LZProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZCell"];
    
    if (cell == nil) {
        cell = [[LZProductCell alloc] init];
    }
    LZProduct *product = [[self.objects objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.currentProduct = product;
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if ([[self.objects objectAtIndex:section] count] > 0) {
         return  [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
    }
    return nil;
   
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
