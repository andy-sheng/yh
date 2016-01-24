//
//  YHTextNewsCell.h
//  yh
//
//  Created by andy on 15/11/3.
//  Copyright © 2015年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHNews.h"


@protocol YHNewsCellDelegate <NSObject>

@optional
-(void)imageTouchedWithNid:(NSInteger) nid imageId:(NSInteger)imageId;
-(void)nameTouched;

@end

@interface YHNewsCell : UITableViewCell
@property (nonatomic, weak) id<YHNewsCellDelegate> delegate;

+ (NSString *)identifier;
- (void)initWithNews:(YHNews *)news;
- (NSInteger)getHeight;
@end
