//
//  ViewController.m
//  keyboard
//
//  Created by andy on 15/12/23.
//  Copyright © 2015年 andy. All rights reserved.
//

#import "ASKeyboard.h"
#import "Masonry.h"

#define KEYBOARD_INPUT_HEIGHT 50.0f
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ASKeyboard() <UITextViewDelegate>

@property(strong ,nonatomic) UIView *inputView;
@property(strong, nonatomic) UIView *pluginView;
@property(strong, nonatomic) NSMutableArray *leftButtons;
@property(strong, nonatomic) NSMutableArray *rightButtons;
@property(strong, nonatomic) NSArray *leftButtonsConfig;
@property(strong, nonatomic) NSArray *rightButtonsConfig;
@property(strong, nonatomic) NSMutableDictionary *data;

@end

@implementation ASKeyboard

- (void)setupData:(NSMutableDictionary *)data {
    self.data = data;
}

- (void)show {
    if (self.hasShowed) {
        return;
    }
    CGRect frame = self.view.frame;
    frame.origin.y = SCREEN_HEIGHT - self.view.frame.size.height;
    self.view.frame = frame;
    [self.view.superview bringSubviewToFront:self.view]; // keyboard maybe cover by other views in it's superview
    
    self.hasShowed = YES;
}

- (void)popupKeyboard:(NSNotification*) notification {
    CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect frame = self.view.frame;
    frame.origin.y = keyboardRect.origin.y - frame.size.height;
    self.view.frame = frame;
}

- (CGPoint)showWithPluginView {
    [self show];
    [self.textView becomeFirstResponder];
    
    return self.view.frame.origin;
}

- (void)hide{
    
    [self.textView resignFirstResponder];
    
    CGRect frame = self.view.frame;
    frame.origin.y = SCREEN_HEIGHT;
    self.view.frame = frame;
    
    self.hasShowed = NO;
}

- (void)hidePluginView {
    [self.textView resignFirstResponder];
    
    CGRect frame = self.view.frame;
    frame.origin.y = SCREEN_HEIGHT - self.view.frame.size.height;
    self.view.frame = frame;
}

- (void)setupButtons:(NSArray*) buttonConfig {
    for (NSDictionary* config in buttonConfig) {
        UIButton *button = [[UIButton alloc] init];
        if ([[config valueForKey:@"action"]  isEqual: @"submit"]) {
            [button addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        }
        if ([[config valueForKey:@"type"]  isEqual: @"text"]) {
            [button setTitle:[config valueForKey:@"content"] forState:UIControlStateNormal];
        } else {
            [button setTitle:@"图" forState:UIControlStateNormal];
        }
        [self.inputView addSubview:button];
    }
}

- (void)submitBtnClick {
    [self.data setObject:self.textView.text forKey:@"content"];
    [self.delegate finishInput:self.data];
}

- (void)viewDidLoad {
    NSLog(@"load");
    [super viewDidLoad];
    
    self.leftButtonsConfig = @[@{@"type":@"image", @"action":@"normal", @"content":@"发送"}];
    self.rightButtonsConfig = @[@{@"type":@"text", @"action":@"submit", @"content":@"发送"}];
    
    // init inputview
    self.inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KEYBOARD_INPUT_HEIGHT)];
    self.inputView.backgroundColor = [UIColor grayColor];
    
    
    // init left buttons
    [self setupButtons:self.leftButtonsConfig];
    
    // init textfield
    self.textView = [[UITextView alloc] init];
    self.textView.delegate = self;
    [self.inputView addSubview:self.textView];
    
    
    
    // init right buttons
    [self setupButtons:self.rightButtonsConfig];
    
    
    
    [self.view addSubview:self.inputView];
    CGRect frame = self.inputView.frame;
    frame.origin.y = SCREEN_HEIGHT;
    self.view.frame = frame;
    //[self updateViewConstraints];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popupKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    
    self.hasShowed = NO;
}

- (void)updateViewConstraints {
    // setup constraints
    for (NSUInteger i = 0; i < [self.inputView.subviews count]; i++) {
        if (i == 0) {
            [[self.inputView.subviews objectAtIndex:i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.inputView.mas_topMargin);
                make.bottom.equalTo(self.inputView.mas_bottomMargin);
                make.leading.equalTo(self.inputView.mas_leadingMargin);
            }];
        } else {
            [[self.inputView.subviews objectAtIndex:i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.inputView.mas_topMargin);
                make.bottom.equalTo(self.inputView.mas_bottomMargin);
                make.leading.equalTo([self.inputView.subviews objectAtIndex:i - 1].mas_trailing).offset(8);
            }];
        }
    }
    [[self.inputView.subviews lastObject] mas_updateConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.inputView.mas_trailingMargin);
    }];
    
    [super updateViewConstraints];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
