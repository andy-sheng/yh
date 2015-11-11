//
//  YHUser.m
//  yh
//
//  Created by andy on 15/11/2.
//  Copyright © 2015年 andy. All rights reserved.
//

#import "YHUser.h"

@implementation YHUser

+ (YHUser *)user {
    YHUser *user = [[YHUser alloc] init];
    user.name = @"name";
    user.slogan = @"slogan";
    user.cover = @"cover.png";
    user.avatar = @"avatar.png";
    return user;
}
@end
