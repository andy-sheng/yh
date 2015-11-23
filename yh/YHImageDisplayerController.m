//
//  YHImageDisplayer.m
//  yh
//
//  Created by andy on 15/11/10.
//  Copyright © 2015年 andy. All rights reserved.
//

#import "YHImageDisplayerController.h"
#import <UIImageView+AFNetworking.h>

@interface YHImageDisplayerController()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView  *scrollView;
@property (strong, nonatomic) UIPageControl *pageController;
@property (strong, nonatomic) NSArray       *urls;
@property (assign, nonatomic) NSInteger      currentPage;
@property (assign, nonatomic) NSInteger      imageCount;

@end
@implementation YHImageDisplayerController



+ (YHImageDisplayerController *)displayerWithUrls:(NSArray *)urls imageId:(NSInteger)imageId{
    
    YHImageDisplayerController *controller = [[YHImageDisplayerController alloc] init];
    controller.urls        = urls;
    controller.imageCount  = [urls count];
    controller.currentPage = imageId;
    return controller;
    
}

+ (YHImageDisplayerController *)displayerWithUrlstrs:(NSArray *)urlstrs imageId:(NSInteger)imageId{
    
    NSMutableArray *urls = [[NSMutableArray alloc] init];
    for (NSString *urlStr in urlstrs) {
        [urls addObject:[NSURL URLWithString:urlStr]];
    }
    return [YHImageDisplayerController displayerWithUrls:urls imageId:imageId];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
    
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    self.scrollView.contentSize = CGSizeMake(self.imageCount * screenSize.width, screenSize.height);
    
    for (int i = 0; i < self.imageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenSize.width * i, 0, screenSize.width, screenSize.height)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView setImageWithURL:self.urls[i]];
        [self.scrollView addSubview:imageView];
    }
    
    self.scrollView.maximumZoomScale               = 2;
    self.scrollView.minimumZoomScale               = 0.2;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator   = NO;
    self.scrollView.delegate                       = self;
    self.scrollView.pagingEnabled                  = YES;
    self.scrollView.contentOffset                  = CGPointMake(screenSize.width * self.currentPage, 0);
    
    self.pageController               = [[UIPageControl alloc] init];
    self.pageController.center        = CGPointMake(screenSize.width / 2, screenSize.height - 20);
    self.pageController.numberOfPages = self.imageCount;
    self.pageController.currentPage   = self.currentPage;
    
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageController];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

-(void)dismiss {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self.pageController.currentPage = self.scrollView.contentOffset.x / screenSize.width;
    
}

-(UIView*) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.scrollView.subviews[self.currentPage];
    
}

@end
