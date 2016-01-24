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

@property(atomic, assign) NSInteger curPage;
@property(atomic, strong) NSMutableArray *list;
@property(atomic) NSInteger listCount;

@end

@implementation YHNewsList

- (NSInteger)addCommentWithcomment:(NSDictionary *)comment newsId:(NSInteger)nid {
    for (NSInteger i = [self.list count] - 1; i >= 0; i--) {
        YHNews *news = [self.list objectAtIndex:i];
        if (news.nid == nid) {
            [news addComment:comment];
            return i;
        }
    }
    return 0;
}

+ (YHNewsList *) newsList {
    YHNewsList *newsList = [[YHNewsList alloc] init];
    newsList.list = [[NSMutableArray alloc] init];
    newsList.curPage = 1;
    return newsList;
}

- (NSInteger)count{
    return self.listCount;
}

- (YHNews *) newsAtIndex:(NSInteger)index {
    return self.list[index];
}

- (YHNews *) newsWithNid:(NSInteger)nid {
    for (YHNews *news in self.list) {
        if (news.nid == nid) {
            return news;
        }
    }
    return nil;
}

- (void) refreshWithSuccess:(void (^)(void))successBlock
                       fail:(void (^)(void))failBlock {
    
    self.curPage = 1;
    
    //data
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@news-1.json", SERVER_ADDR]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:url.absoluteString, SERVER_ADDR] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        self.listCount = [(NSNumber *)[responseObject valueForKey:@"count"] integerValue];
        
        NSArray *tmp = [responseObject valueForKey:@"news"];
        for (NSInteger i = 0; i < tmp.count; i++) {
            
            YHNews *news = [YHNews newsWithDic:tmp[i]];
            [self.list addObject:news];
            
        }
        successBlock();
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        failBlock();
    }];
}

- (void) moreWithSuccess:(void (^)(void))successBlock
                    fail:(void (^)(void))failBlock {
    self.curPage++;
    //data
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@news-%ld.json", SERVER_ADDR, self.curPage]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:url.absoluteString, SERVER_ADDR] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        self.listCount += [(NSNumber *)[responseObject valueForKey:@"count"] integerValue];
        NSArray *tmp = [responseObject valueForKey:@"news"];
        
        
        for (NSInteger i = 0; i < tmp.count; i++) {
            
            YHNews *news = [YHNews newsWithDic:tmp[i]];
            [self.list addObject:news];
            
        }
        successBlock();
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        failBlock();
    }];
}

@end
