//
//  YHTextNews.h
//  yh
//
//  Created by andy on 15/11/3.
//  Copyright © 2015年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHNews : NSObject

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *car;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, assign) NSInteger likesCount;
@property (nonatomic, assign) NSInteger commentsCount;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *comments;

+ (YHNews *)news;
+ (YHNews *)newsWithDic:(id) dic;

@end
