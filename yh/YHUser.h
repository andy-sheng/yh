//
//  YHUser.h
//  yh
//
//  Created by andy on 15/11/2.
//  Copyright © 2015年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHUser : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *slogan;
@property(nonatomic, strong) NSString *avatar;
@property(nonatomic, strong) NSString *cover;
@property(nonatomic, strong) NSMutableArray *newsList;


+ (YHUser *)user;
+ (YHUser *)userWithId:(NSString *)userId;
- (void)fecthDataWithSuccess:(void (^)(void))successBlock
                        fail:(void (^)(void))failBlock;
@end
