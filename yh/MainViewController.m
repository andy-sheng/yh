//
//  MainViewController.m
//  yh
//
//  Created by andy on 15/10/27.
//  Copyright © 2015年 andy. All rights reserved.
//
#import "YHUser.h"
#import "SegViewProtocol.h"
#import "MainViewController.h"
#import "YHNewsTableViewController.h"
#import "NearbyTableViewController.h"
#import "MessageTableViewController.h"
#import "ContactTableViewController.h"
#import "YHImageDisplayerController.h"
#import "YHPublishViewController.h"

@interface MainViewController ()
{
    YHImageDisplayerController *_imageDisplayer;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (strong, nonatomic) YHNewsTableViewController *newsTableController;
@property (strong, nonatomic) NearbyTableViewController *nearbyTableViewController;
@property (strong, nonatomic) ContactTableViewController *contactTableViewController;
@property (strong, nonatomic) MessageTableViewController *messageTableViewController;
@property (strong, nonatomic) UITableViewController<SegViewProtocol> *currentTable;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barBtn;

@end

@implementation MainViewController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.navigationController pushViewController:viewController animated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.currentTable viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    _newsTableController = [[YHNewsTableViewController alloc] initWithMainViewController:self];
    _currentTable = self.newsTableController;
    
    
    [self addTableView:_currentTable.tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void) addTableView:(UITableView *) tableView {
    [self.view addSubview:tableView];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tableView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.segment
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0f
                                                           constant:-20]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tableView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.segment
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0f
                                                           constant:20]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tableView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.segment
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:10.0f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tableView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:0]];
}

- (IBAction)segmentTouched:(UISegmentedControl *)sender {
    [self.currentTable.tableView removeFromSuperview];
    switch (sender.selectedSegmentIndex) {
        case 1:
            self.messageTableViewController = [[UIStoryboard storyboardWithName:@"Message" bundle:nil] instantiateViewControllerWithIdentifier:@"goChat"];
            self.currentTable = self.messageTableViewController;
            self.barBtn.title = @"发起群聊";
            break;
        case 2:
            self.nearbyTableViewController = self.nearbyTableViewController ? self.nearbyTableViewController
                :[[NearbyTableViewController alloc] init];
            self.currentTable = self.nearbyTableViewController;
            self.barBtn.title = @"设置过滤";
            break;
        case 3:
            self.contactTableViewController = self.contactTableViewController ? self.contactTableViewController
                :[[ContactTableViewController alloc] init];
            self.currentTable = self.contactTableViewController;
            self.barBtn.title = @"设置添加好友";
            break;
        case 0:default:
            self.currentTable = self.newsTableController;
            self.barBtn.title = [self.currentTable getBarBtnTitle];
            break;
    }
    [self addTableView:self.currentTable.tableView];
}
- (IBAction)barItemTouched:(UIBarButtonItem *)sender {
    [self.navigationController pushViewController:[self.currentTable getBarBtnResponder] animated:YES];
}
@end
