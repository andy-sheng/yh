//
//  YHNewsCellActionProtocol.h
//  yh
//
//  Created by andy on 15/11/10.
//  Copyright © 2015年 andy. All rights reserved.
//

#ifndef YHNewsCellActionProtocol_h
#define YHNewsCellActionProtocol_h
@protocol YHNewsCellActionProtocol <NSObject>

@optional
-(void)coverTouched;
-(void)imageTouched:(int)tag;
-(void)nameTouched;

@end

#endif /* YHNewsCellActionProtocol_h */
