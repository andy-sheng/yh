//
//  ViewController.h
//  keyboard
//
//  Created by andy on 15/12/23.
//  Copyright © 2015年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ASKeyboardDelegate

- (void)finishInput:(NSMutableDictionary*) data;

@end

@interface ASKeyboard : UIViewController

@property(weak, nonatomic)id<ASKeyboardDelegate> delegate;
@property(strong, nonatomic) UITextView *textView;
@property(assign ,nonatomic)BOOL hasShowed;

- (void)show;
- (void)hide;
- (CGPoint)showWithPluginView;
- (void) setupData:(NSMutableDictionary*) data;
- (ASKeyboard *)initWithConfig:(NSDictionary *)config;

@end

