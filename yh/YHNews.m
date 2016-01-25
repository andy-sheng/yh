//
//  YHTextNews.m
//  yh
//
//  Created by andy on 15/11/3.
//  Copyright © 2015年 andy. All rights reserved.
//

#import "YHNews.h"
#import "YHConfig.h"


@interface YHNews()



@end
@implementation YHNews

- (void)addComment:(NSDictionary *)comment {
    [self.comments addObject:comment];
}
+ (YHNews *)news {
    return [[YHNews alloc] init];
}

+ (YHNews *)newsWithDic:(id) dic {
    YHNews *news = [[YHNews alloc] init];
    news.nid           = [(NSNumber *)[dic valueForKey:@"nid"] integerValue];
    news.avatar        = [NSString stringWithFormat:@"%@%@", SERVER_ADDR, [dic valueForKey:@"avatar"]];
    news.name          = [dic valueForKey:@"name"];
    news.userId        = [dic valueForKey:@"uid"];
    news.car           = [dic valueForKey:@"car"];
    news.content       = [dic valueForKey:@"content"];
    news.location      = [dic valueForKey:@"location"];
    news.time          = [(NSNumber *)[dic valueForKey:@"time"] integerValue];
    news.likesCount    = [(NSNumber *)[dic valueForKey:@"likes_count"] integerValue];
    news.commentsCount = [(NSNumber *)[dic valueForKey:@"comments_count"] integerValue];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    NSArray *tmp = [dic valueForKey:@"images"];
    NSInteger imagesCount = [tmp count];
    for (NSInteger i = 0; i < imagesCount; i++) {
        [images addObject:[NSString stringWithFormat:@"%@%@", SERVER_ADDR, tmp[i]]];
    }
    news.images        = [images copy];
    
    NSMutableArray *comments = [[NSMutableArray alloc] init];
    tmp = [dic valueForKey:@"comments"];
    NSUInteger commentsCount = [tmp count];
    for (NSUInteger i = 0; i < commentsCount; i++) {
        [comments addObject:tmp[i]];
    }
    news.comments = comments;
    NSLog(@"%@", comments);
    return news;
}

@end
