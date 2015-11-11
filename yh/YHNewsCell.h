//
//  YHTextNewsCell.h
//  yh
//
//  Created by andy on 15/11/3.
//  Copyright © 2015年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHNews.h"
#import "YHNewsCellActionProtocol.h"

@interface YHNewsCell : UITableViewCell
@property (nonatomic, weak) id<YHNewsCellActionProtocol> delegate;

+ (NSString *)identifier;
- (void)setNews:(YHNews *)news;
@end
