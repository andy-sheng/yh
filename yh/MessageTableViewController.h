//
//  MessageTableViewController.h
//  yh
//
//  Created by andy on 15/10/29.
//  Copyright © 2015年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegViewProtocol.h"
@interface MessageTableViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource,SegViewProtocol>
@property(nonatomic,copy)NSMutableArray*status;
@property(nonatomic,copy)NSDictionary* initdata;
@end
