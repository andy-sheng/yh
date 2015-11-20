//
//  YHNewsList.m
//  yh
//
//  Created by andy on 15/11/19.
//  Copyright © 2015年 andy. All rights reserved.
//

#import "YHNewsList.h"
#import "YHConfig.h"
#import <AFNetworking.h>

@interface YHNewsList()

@property(atomic, strong) NSMutableArray *list;
@property(atomic) NSInteger listCount;

@end

@implementation YHNewsList

+ (YHNewsList *) newsList {
    return [[YHNewsList alloc] init];
}

- (NSInteger)count{
    return self.listCount;
}

- (YHNews *) newsAtIndex:(NSInteger)index {
    return self.list[index];
}

- (void) refreshWithSuccess:(void (^)(void))successBlock
                       fail:(void (^)(void))failBlock {
    //data
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@news.json", SERVER_ADDR]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:url.absoluteString, SERVER_ADDR] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        self.listCount = [(NSNumber *)[responseObject valueForKey:@"count"] integerValue];
        NSLog(@"self.listCount:%@", responseObject);
        NSLog(@"listcount:%ld", self.listCount);
        NSArray *tmp = [responseObject valueForKey:@"news"];
        self.list = [[NSMutableArray alloc] init];
        
        for (NSInteger i = 0; i < tmp.count; i++) {
            
            YHNews *news = [YHNews newsWithDic:tmp[i]];
            [self.list addObject:news];
            
        }
        successBlock();
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        failBlock();
    }];
}

- (void) more {
    
}

@end
