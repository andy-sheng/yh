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
#import "YHNewsCommentsCell.h"
#import "YHUser.h"
#import "YHNews.h"
#import "YHNewsCellActionProtocol.h"
#import "YHImageDisplayerController.h"
#import "YHConfig.h"
#import "YHNewsList.h"
#import "YHNewsSparatorCell.h"
#import "MainViewController.h"
#import <MJRefresh.h>
#import <AFNetworking.h>

#define COVER_ROW 0


@interface YHNewsTableViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate,YHNewsCellActionProtocol>

@property(nonatomic, strong) YHNewsList *newsList;
@property(nonatomic, weak) MainViewController *mainController;
@end

@implementation YHNewsTableViewController

- (YHNewsTableViewController *)initWithMainViewController:(MainViewController*)mainViewController {
    self.mainController = mainViewController;
    return self;
}

- (UIViewController*)loadViewControllerWithStoryBoard:(NSString*)storyBoardName Identifier:(NSString*) identifier{
    return [[UIStoryboard storyboardWithName:storyBoardName bundle:nil] instantiateViewControllerWithIdentifier:identifier];
}

- (UIViewController *)getBarBtnResponder {
    return [self loadViewControllerWithStoryBoard:@"News" Identifier:@"YHPublishViewController"];
}

- (NSString *)getBarBtnTitle {
    return @"发布动态";
}
- (void)refresh {
    NSLog(@"refreshing...");

    [self.newsList refreshWithSuccess:^{
        NSLog(@"end refreshing");
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } fail:^{
        
    }];
    

}

-(void)more {
    [self.newsList moreWithSuccess:^{
        NSLog(@"more");
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } fail:^{
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)nameTouched {
    [self.mainController pushViewController:[self loadViewControllerWithStoryBoard:@"News" Identifier:@"YHTimelineViewController"] animated:YES];
}

- (void)imageTouchedWithNid:(NSInteger)nid imageId:(NSInteger)imageId {
    
    [self.mainController presentViewController:[YHImageDisplayerController displayerWithUrlstrs:[self.newsList newsWithNid:nid].images imageId:imageId] animated:YES completion:nil];
    
}

-(void)coverTouched {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"更换背景" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.mainController pushViewController:[self loadViewControllerWithStoryBoard:@"News" Identifier:@"YHChangeCoverController"] animated:YES];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self.mainController presentViewController:alert animated:YES completion:nil];
    
}

- (void)viewDidLoad {

    [super viewDidLoad];

    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 50;
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //上拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    //下拉加载
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(more)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YHNewsCell" bundle:nil] forCellReuseIdentifier:[YHNewsCell identifier]];
    [self.tableView registerNib:[UINib nibWithNibName:@"YHNewsCoverCell" bundle:nil] forCellReuseIdentifier:[YHNewsCoverCell identifier]];
    [self.tableView registerClass:[YHNewsCommentsCell class] forCellReuseIdentifier:[YHNewsCommentsCell identifier]];
    [self.tableView registerClass:[YHNewsSparatorCell class] forCellReuseIdentifier:[YHNewsSparatorCell identifier]];
    
    //data
    self.newsList = [YHNewsList newsList];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    NSLog(@"%ld", [self.newsList count] + 1);
    return [self.newsList count] * 3 + 1;
}


/*cell*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == COVER_ROW) {
        YHNewsCoverCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[YHNewsCoverCell identifier]];
        cell.delegate = self;
        [cell setUser:[YHUser user]];
        
        return cell;
    } else {
        if (indexPath.row % 3 == 1) {
            YHNewsCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[YHNewsCell identifier]];
            cell.delegate = self;
            [cell initWithNews:[self.newsList newsAtIndex:(indexPath.row - 1) / 3]];
            
            return cell;
        } else if(indexPath.row % 3 == 2) {
            YHNewsCommentsCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[YHNewsCommentsCell identifier]];
            [cell initWithComments:[self.newsList newsAtIndex:(indexPath.row - 2) / 3].comments];
            
            return cell;
        } else {
            YHNewsSparatorCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[YHNewsSparatorCell identifier]];
            cell = [cell init];
            return cell;
        }
        
    }
}

/*cell height*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == COVER_ROW) {
        return self.tableView.bounds.size.width / 600 * 300;
    } else {
        if (indexPath.row % 3 == 1) {
            YHNewsCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[YHNewsCell identifier]];
            [cell initWithNews:[self.newsList newsAtIndex:(indexPath.row - 1) / 3]];
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
            cell.bounds = CGRectMake(0.0f,0.0f, CGRectGetWidth(self.tableView.bounds), CGRectGetHeight(cell.bounds));
            [cell setNeedsLayout];
            [cell layoutIfNeeded];
            
            return [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        } else if(indexPath.row % 3 == 2){
            
            YHNewsCommentsCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[YHNewsCommentsCell identifier]];
            if ([[self.newsList newsAtIndex:(indexPath.row - 2) / 3].comments count] == 0) {
                return 0;
            }
            [cell initWithComments:[self.newsList newsAtIndex:(indexPath.row - 2) / 3].comments];
            //[cell updateConstraints];
            [cell setNeedsLayout];
            [cell layoutIfNeeded];
            return [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            
        } else {
            //YHNewsSparatorCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[YHNewsSparatorCell identifier]];
            return NEWS_SPARATOR_HEIGHT;
        }
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
