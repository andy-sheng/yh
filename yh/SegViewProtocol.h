//
//  SegViewProtocol.h
//  yh
//
//  Created by andy on 15/10/29.
//  Copyright © 2015年 andy. All rights reserved.
//

#ifndef SegViewProtocol_h
#define SegViewProtocol_h

#import <UIKit/UIKit.h>
@protocol SegViewProtocol



@optional
- (NSString *) getBarBtnTitle;
- (UIViewController*)getBarBtnResponder;
- (void) show;
- (void) hide;
@end



#endif /* SegViewProtocol_h */
