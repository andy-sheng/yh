//
//  YHStatus.m
//  hi
//
//  Created by lixiangqian on 15/11/13.
//  Copyright © 2015年 lixiangqian. All rights reserved.
//

#import "YHStatus.h"

@implementation YHStatus

-(YHStatus *)initwithYHstatusdic:(NSDictionary *)dic{
    id checkself =[super init];
    if (self ==checkself) {
        self.Id = [dic[@"nid"] longLongValue];
        self.usertextData =dic[@"message"];
        self.userImageData=dic[@"avatar"];
        self.userNameData = dic[@"name"];
        self.userSourceData=dic[@"car"];
        self.userCreateAtData= dic[@"createAt"];
    }
    return self;
}

+(YHStatus *)staticinitwithYHstatusdic:(NSDictionary *)dic{
    YHStatus *status=[[YHStatus alloc]initwithYHstatusdic:dic];
    return status;
}
@end
