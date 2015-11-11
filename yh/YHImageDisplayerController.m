//
//  YHImageDisplayer.m
//  yh
//
//  Created by andy on 15/11/10.
//  Copyright © 2015年 andy. All rights reserved.
//

#import "YHImageDisplayerController.h"

@interface YHImageDisplayerController()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageController;
@property (nonatomic) int currentPage;
@end
@implementation YHImageDisplayerController

- (void)viewDidLoad {
    
    [super viewDidLoad];
#warning test data
    NSArray *images = @[@"cover.png", @"avatar.png"];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
    
    _currentPage = 0;
    int imageCount = [images count];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    _scrollView.contentSize = CGSizeMake(imageCount * screenSize.width, screenSize.height);
    
    for (int i = 0; i < imageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenSize.width * i, 0, screenSize.width, screenSize.height)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView setImage:[UIImage imageNamed:images[i]]];
        [_scrollView addSubview:imageView];
    }
    
    _scrollView.maximumZoomScale = 2;
    _scrollView.minimumZoomScale = 0.2;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    
    _pageController = [[UIPageControl alloc] init];
    _pageController.center = CGPointMake(screenSize.width / 2, screenSize.height - 20);
    _pageController.numberOfPages = imageCount;
    _pageController.currentPage = _currentPage;
    
    
    [self.view addSubview:_scrollView];
    [self.view addSubview:_pageController];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

-(void)dismiss {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    _pageController.currentPage = _scrollView.contentOffset.x / screenSize.width;
    
}

-(UIView*) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return _scrollView.subviews[_currentPage];
    
}

@end
