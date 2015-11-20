//
//  YHNewsList.h
//  yh
//
//  Created by andy on 15/11/19.
//  Copyright © 2015年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHNews.h"

@interface YHNewsList : NSObject

+(YHNewsList *) newsList;
- (void) refreshWithSuccess:(void(^)(void))successBlock fail:(void(^)(void))failBlock;
- (YHNews *) newsAtIndex:(NSInteger) index;
- (NSInteger)count;

@end
