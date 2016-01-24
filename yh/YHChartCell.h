//
//  YHChartCell.h
//  hi
//
//  Created by lixiangqian on 15/11/13.
//  Copyright © 2015年 lixiangqian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHStatus;
@interface YHChartCell : UITableViewCell
@property(copy,nonatomic)YHStatus *cellstatus;
@property(assign,nonatomic)CGFloat height;
@property (weak,nonatomic) IBOutlet UIImageView* userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userMessage;
@property (weak, nonatomic) IBOutlet UILabel *userTimer;
@property (weak, nonatomic) IBOutlet UILabel *userSource;
+(NSString *)identifier;
@end
