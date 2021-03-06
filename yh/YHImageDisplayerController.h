//
//  YHImageDisplayer.h
//  yh
//
//  Created by andy on 15/11/10.
//  Copyright © 2015年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHImageDisplayerController : UIViewController

+ (YHImageDisplayerController *)displayerWithUrls: (NSArray *) urls imageId:(NSInteger) imageId;
+ (YHImageDisplayerController *)displayerWithUrlstrs: (NSArray *) urlstrs imageId:(NSInteger) imageId;

@end
