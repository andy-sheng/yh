//
//  NewsTableViewController.m
//  yh
//
//  Created by andy on 15/10/29.
//  Copyright © 2015年 andy. All rights reserved.
//

#import "YHTimelineViewController.h"
#import "YHNewsTableViewController.h"
#import "YHNewsCoverCell.h"
#import "YHNewsCell.h"
#import "YHNewsCommentsCell.h"
#import "YHUser.h"
#import "YHNews.h"
#import "YHImageDisplayerController.h"
#import "YHConfig.h"
#import "YHNewsList.h"
#import "YHNewsSparatorCell.h"
#import "MainViewController.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "ASKeyboard.h"

#define COVER_ROW 0



@interface YHNewsTableViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UITextFieldDelegate, YHNewsCommentsCellDelegate, YHNewsCoverCellDelegate, YHNewsCellDelegate, ASKeyboardDelegate>
@property(assign, nonatomic) NSInteger newsId;
@property(nonatomic, strong) ASKeyboard *keyboard;
@property(assign, nonatomic)CGPoint locInTable;
@property(nonatomic, strong) UITextField *textfield;
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





- (void)viewDidLoad {

    [super viewDidLoad];

    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 50;
    [self.tableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)]];
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //上拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    //下拉加载
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(more)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YHNewsCell" bundle:nil] forCellReuseIdentifier:[YHNewsCell identifier]];
    [self.tableView registerNib:[UINib nibWithNibName:@"YHNewsCoverCell" bundle:nil] forCellReuseIdentifier:[YHNewsCoverCell identifier]];
    //[self.tableView registerClass:[YHNewsCommentsCell class] forCellReuseIdentifier:[YHNewsCommentsCell identifier]];
    [self.tableView registerClass:[YHNewsSparatorCell class] forCellReuseIdentifier:[YHNewsSparatorCell identifier]];
    
    // data
    self.newsList = [YHNewsList newsList];
    
    // keyboard
    self.keyboard = [[ASKeyboard alloc] init];
    self.keyboard.delegate = self;
    [self.mainController.view addSubview:self.keyboard.view];
}

#pragma mark ASKeyboardDelegate
- (void)finishInput:(NSMutableDictionary*) data{
    
    [self.keyboard hide];
    [data setObject:@"hehe" forKey:@"from"];
    
    NSInteger row = ([self.newsList addCommentWithcomment:data newsId:[data[@"nid"] integerValue]] + 1) * 3 - 1;
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:NO];
    [self.keyboard.textView setText:@""];
}

#pragma mark YHNewsCoverCellDelegate
-(void)coverTouched {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"更换背景" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.mainController pushViewController:[self loadViewControllerWithStoryBoard:@"News" Identifier:@"YHChangeCoverController"] animated:YES];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self.mainController presentViewController:alert animated:YES completion:nil];
    
}

- (void)showNewCommentsBtnTouched {
    [self.mainController pushViewController:[self loadViewControllerWithStoryBoard:@"News" Identifier:@"YHNewCommentsViewController"] animated:YES];
}


#pragma mark YHNewsCellDelegate
- (void)nameTouched {
    YHTimelineViewController *controller = (YHTimelineViewController*)[self loadViewControllerWithStoryBoard:@"News" Identifier:@"YHTimelineViewController"];
    [self.mainController pushViewController:controller animated:YES];
    //[self.mainController pushViewController:[self loadViewControllerWithStoryBoard:@"News" Identifier:@"YHTimelineViewController"] animated:YES];
}

- (void)imageTouchedWithNid:(NSInteger)nid imageId:(NSInteger)imageId {
    
    [self.mainController presentViewController:[YHImageDisplayerController displayerWithUrlstrs:[self.newsList newsWithNid:nid].images imageId:imageId] animated:YES completion:nil];
    
}


#pragma mark YHNewsCommentsCellDelegate
- (void)commentKeyBoardWillPopWithLoc:(CGPoint)loc commentDic:(NSMutableDictionary *)comment{
    NSLog(@"comment:%@", comment);
    [self.keyboard setupData:comment];
    
    
    CGPoint keyboardPos = [self.keyboard showWithPluginView];
    CGFloat offsetY = loc.y - keyboardPos.y
                            + self.tableView.frame.origin.y;
    [self.tableView setContentOffset:CGPointMake(0, offsetY) animated:YES];
    
}

- (void)hideKeyboard {
    [self.keyboard hide];
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
    
    return [self.newsList count] * 3 + 1;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
            NSString *reuseId = [NSString stringWithFormat:@"%@-%ld", [YHNewsCommentsCell identifier], [[self.newsList newsAtIndex:(indexPath.row - 2) / 3].comments count]];
            YHNewsCommentsCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseId];
            if (!cell) {
                cell = [[YHNewsCommentsCell alloc] initWithCommentsCount:[[self.newsList newsAtIndex:(indexPath.row - 2) / 3].comments count]];
            }
            [cell setupWithComments:[self.newsList newsAtIndex:(indexPath.row - 2) / 3].comments];
            cell.delegate = self;
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
        return UITableViewAutomaticDimension;
        //return self.tableView.bounds.size.width / 600 * 300;
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

            if ([[self.newsList newsAtIndex:(indexPath.row - 2) / 3].comments count] == 0) {
                NSLog(@"%ld", indexPath.row);
                return 0;
            }
            return UITableViewAutomaticDimension;
            
        } else {
            //YHNewsSparatorCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[YHNewsSparatorCell identifier]];
            return NEWS_SPARATOR_HEIGHT;
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //NSLog(@"%f", self.tableView.contentInset.top);
}


@end
