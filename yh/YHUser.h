//
//  YHUser.h
//  yh
//
//  Created by andy on 15/11/2.
//  Copyright © 2015年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHUser : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *slogan;
@property(nonatomic, copy) NSString *avatar;
@property(nonatomic, copy) NSString *cover;

+ (YHUser *)user;
@end
