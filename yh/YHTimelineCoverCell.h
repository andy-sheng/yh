//
//  YHTimelineCoverCell.h
//  yh
//
//  Created by andy on 16/1/25.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHUser.h"
@interface YHTimelineCoverCell : UITableViewCell



+ (NSString *)identify;
- (YHTimelineCoverCell *) initWithUser:(YHUser *) user;

@end
