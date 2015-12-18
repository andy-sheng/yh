//
//  MainViewController.h
//  yh
//
//  Created by andy on 15/10/27.
//  Copyright © 2015年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
- (IBAction)segmentTouched:(UISegmentedControl *)sender;
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated ;
@end
