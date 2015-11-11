//
//  YHMainViewDelegate.h
//  yh
//
//  Created by andy on 15/11/10.
//  Copyright © 2015年 andy. All rights reserved.
//

#ifndef YHMainViewDelegate_h
#define YHMainViewDelegate_h


@protocol YHMainViewDelegate <NSObject>
@required
-(void)changeCover;
-(void)displayImages;
-(void)displayTimeLine;
@end

#endif /* YHMainViewDelegate_h */
