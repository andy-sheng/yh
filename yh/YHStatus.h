//
//  YHStatus.h
//  hi
//
//  Created by lixiangqian on 15/11/13.
//  Copyright © 2015年 lixiangqian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHStatus : NSObject
@property (nonatomic,assign)long long Id;
@property (nonatomic,copy)NSString * userNameData;
@property (nonatomic,copy)NSString * userSourceData;
@property (nonatomic,copy)NSString * userCreateAtData;
@property (nonatomic,copy)NSString * usertextData;
@property (nonatomic,copy)NSString * userImageData;
@property (nonatomic,copy)NSString * userLocationData;

-(YHStatus *)initwithYHstatusdic:(NSDictionary *)dic;
+(YHStatus *)staticinitwithYHstatusdic:(NSDictionary *)dic;
@end
