//
//  YHNewsCoverCell.h
//  yh
//
//  Created by andy on 15/11/2.
//  Copyright © 2015年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHUser.h"

@protocol YHNewsCoverCellDelegate <NSObject>

@optional
-(void)showNewCommentsBtnTouched;
-(void)coverTouched;
@end



@interface YHNewsCoverCell : UITableViewCell

@property (nonatomic, weak) id<YHNewsCoverCellDelegate> delegate;

+ (YHNewsCoverCell *)newsCoverCellWithUser:(YHUser *)user;
+ (NSString *)identifier;
- (void) setUser:(YHUser *)user;

@end
