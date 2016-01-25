//
//  YHUser.m
//  yh
//
//  Created by andy on 15/11/2.
//  Copyright © 2015年 andy. All rights reserved.
//

#import "YHUser.h"
#import "YHConfig.h"
#import "YHNews.h"
#import <AFNetworking.h>

@interface YHUser()

@property(nonatomic, strong) NSString* userId;

@end
@implementation YHUser

+ (YHUser *)user {
    YHUser *user = [[YHUser alloc] init];
    user.name = @"David";
    user.slogan = @"爱车，爱生活";
    user.cover = @"cover.png";
    user.avatar = @"avatar.png";
    return user;
}

+ (YHUser *)userWithId:(NSString *)userId {
    YHUser *user = [[YHUser alloc] init];
    user.userId = userId;
    return user;
}

- (void)fecthDataWithSuccess:(void (^)(void))successBlock
                        fail:(void (^)(void))failBlock {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@user/user-%@.json", SERVER_ADDR, self.userId]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:url.absoluteString, SERVER_ADDR] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        self.cover = [NSString stringWithFormat:@"%@%@", SERVER_ADDR, [responseObject valueForKey:@"cover"]];
        
        self.avatar = [NSString stringWithFormat:@"%@%@", SERVER_ADDR, [responseObject valueForKey:@"avatar"]];
        self.name = [responseObject valueForKey:@"name"];
        self.slogan = [responseObject valueForKey:@"slogan"];
        
        
        
        self.newsList = [NSMutableArray array];
        for (id news in [responseObject valueForKey:@"news"]) {
            YHNews *tmp = [YHNews newsWithDic:news];
            [self.newsList addObject:tmp];
        }
        NSLog(@"list:%@", self.newsList);
        
        successBlock();
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failBlock();
    }];
    
}
@end
