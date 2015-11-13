//
//  NewsTableViewController.m
//  yh
//
//  Created by andy on 15/10/29.
//  Copyright © 2015年 andy. All rights reserved.
//

#import "YHNewsTableViewController.h"
#import "YHNewsCoverCell.h"
#import "YHNewsCell.h"
#import "YHUser.h"
#import "YHNews.h"
#import "YHNewsCellActionProtocol.h"
#import "YHImageDisplayerController.h"
#import <MJRefresh.h>

#define COVER_ROW 0


@interface YHNewsTableViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate,YHNewsCellActionProtocol>

@end

@implementation YHNewsTableViewController

- (void)refresh {
    NSLog(@"refreshing...");
    [self.tableView.mj_header endRefreshing];
}

-(void)more {
    [self.tableView.mj_footer endRefreshing];
    NSLog(@"more");
}

- (void)nameTouched {
    
    [_mainViewDelegate displayTimeLine];
}

- (void)imageTouched:(int)tag {
    
    [_mainViewDelegate displayImages];
}

-(void)coverTouched {
    
    [_mainViewDelegate changeCover];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //上拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(more)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YHNewsCell" bundle:nil] forCellReuseIdentifier:[YHNewsCell identifier]];
    [self.tableView registerNib:[UINib nibWithNibName:@"YHNewsCoverCell" bundle:nil] forCellReuseIdentifier:[YHNewsCoverCell identifier]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == COVER_ROW) {
        YHNewsCoverCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[YHNewsCoverCell identifier]];
        cell.delegate = self;
        [cell setUser:[YHUser user]];
        return cell;
    } else {
        YHNewsCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[YHNewsCell identifier]];
        cell.delegate = self;
        [cell setNews:[YHNews news]];
        return cell;
    }
}

#warning height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == COVER_ROW) {
        return self.tableView.bounds.size.width / 600 * 300;
    } else {
        YHNewsCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[YHNewsCell identifier]];
        [cell setNews:[YHNews news]];
        
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        cell.bounds = CGRectMake(0.0f,0.0f, CGRectGetWidth(self.tableView.bounds), CGRectGetHeight(cell.bounds));
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
     
        return [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //NSLog(@"%f", self.tableView.contentInset.top);
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
