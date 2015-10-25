//
//  ViewController.m
//  LZStudentNote
//
//  Created by comst on 15/10/25.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

#import "LZBusiness/LZBusiness.h"
@interface ViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) LZStuManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@", NSHomeDirectory());
}

- (IBAction)addItem:(UIBarButtonItem *)sender {
    
    
    LZStudent *newStudent = [[LZStudent alloc] init];
    newStudent.name = [self randomString];
    
    newStudent.phone = [self randomPhone];
    
    [self.array addObject:newStudent];
    
    [self.manager addStudent:newStudent];
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:[self.array count] - 1 inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}

- (NSString *)randomString{
    
    NSMutableString *res = [NSMutableString string];
    NSInteger len = arc4random_uniform(10) + 1;
    for (NSInteger i = 0; i < len; i ++) {
        [res appendString:[NSString stringWithFormat:@"%c", 'a' + arc4random_uniform(26)]];
    }
    return res ;
}

- (NSString *)randomPhone{
    NSString *res = [NSString stringWithFormat:@"%u", arc4random_uniform(1<<30)];
    
    return res;
}


- (IBAction)editItems:(id)sender {
    
    self.tableView.editing = !self.tableView.editing;
    
}

- (NSMutableArray *)array{
    if (!_array) {
        
        _array = [NSMutableArray arrayWithArray:[self.manager allStudents]];
        if ([_array count] == 0) {
            _array = [NSMutableArray array];
        }
    }
    return _array;
}

- (LZStuManager *)manager{
    if (!_manager) {
        _manager = [[LZStuManager alloc] init];
    }
    return _manager;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZCell"];
    
    LZStudent *stu = self.array[indexPath.row];
    
    cell.textLabel.text = stu.name;
    cell.detailTextLabel.text = stu.phone;
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        LZStudent *stu = self.array[indexPath.row];
        [self.array removeObject:stu];
        [self.manager deleteStudent:stu];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - searchbar delegate

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
     NSLog(@"%@ -  %@, %lu", searchBar.text, text, (unsigned long)[text length]);
    
    if ([text isEqualToString:@"\n"]) {
        [searchBar resignFirstResponder];
        return NO;
    }else if ([text length] == 0){
        NSUInteger len = [searchBar.text length];
        if (len == 1) {
            self.array = nil;
            [self array];
        }else{
             self.array = [NSMutableArray arrayWithArray:[self.manager searchStudent:[searchBar.text substringToIndex:len - 1]]];
        }
    }else{
        self.array = [NSMutableArray arrayWithArray:[self.manager searchStudent:[searchBar.text stringByAppendingString:text]]];
    }
    
    [self.tableView reloadData];
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"didchange: %@", searchText);
}
@end
