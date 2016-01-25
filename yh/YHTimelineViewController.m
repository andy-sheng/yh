//
//  YHTimelineViewController.m
//  yh
//
//  Created by andy on 16/1/24.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "YHTimelineViewController.h"
#import "YHUser.h"
#import "YHTimelineCoverCell.h"
#import "YHTimelineCell.h"

#import <MJRefresh.h>

@interface YHTimelineViewController()

@property (nonatomic, strong) YHUser *user;

@end
@implementation YHTimelineViewController

- (void)initWithUserId:(NSString *) userId {
    self.user = [YHUser userWithId:userId];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    //上拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    //下拉加载
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(more)];
    
    
    [self.tableView.mj_header beginRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.user.newsList count] + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        YHTimelineCoverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"covercell"];
        cell = [cell initWithUser:self.user];
        NSLog(@"name:%@", self.user.name);
        return cell;
    } else {
        YHTimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"timelinecell"];
        cell = [cell initWithNews:self.user.newsList[indexPath.row - 1]];
        return cell;
    }
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)refresh {
    [self.user fecthDataWithSuccess:^{
        [self.tableView reloadData];
       [self.tableView.mj_header endRefreshing];
    } fail:^{
        [self.tableView.mj_header endRefreshing];
        NSLog(@"fail");
    }];
}

- (void)more {
    
}
@end
