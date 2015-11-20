//
//  YHTextNews.m
//  yh
//
//  Created by andy on 15/11/3.
//  Copyright © 2015年 andy. All rights reserved.
//

#import "YHNews.h"



@interface YHNews()



@end
@implementation YHNews

+ (YHNews *)news {
    return [[YHNews alloc] init];
}

+ (YHNews *)newsWithDic:(id) dic {
    YHNews *news = [[YHNews alloc] init];
    news.avatar        = [dic valueForKey:@"avatar"];
    news.name          = [dic valueForKey:@"name"];
    news.car           = [dic valueForKey:@"car"];
    news.content       = [dic valueForKey:@"content"];
    news.location      = [dic valueForKey:@"location"];
    news.time          = [(NSNumber *)[dic valueForKey:@"time"] integerValue];
    news.likesCount    = [(NSNumber *)[dic valueForKey:@"likes_count"] integerValue];
    news.commentsCount = [(NSNumber *)[dic valueForKey:@"comments_count"] integerValue];
    
    return news;
}

@end
