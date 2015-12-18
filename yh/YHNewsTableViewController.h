//
//  NewsTableViewController.h
//  yh
//
//  Created by andy on 15/10/29.
//  Copyright © 2015年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegViewProtocol.h"
#import "MainViewController.h"
//#import "ChildViewScrollHandleDelegate.h"

@interface YHNewsTableViewController : UITableViewController <SegViewProtocol>

- (YHNewsTableViewController *)initWithMainViewController:(MainViewController *)mainViewController;
@end
