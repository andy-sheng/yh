//
//  YHTextNewsCell.m
//  yh
//
//  Created by andy on 15/11/3.
//  Copyright © 2015年 andy. All rights reserved.
//

#import "YHNewsCell.h"
#import "YHConfig.h"
#import <UIImageView+AFNetworking.h>
#define IDENTTIFIER @"newsCell"
@interface YHNewsCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) YHNews *news;

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *car;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *likesCount;
@property (weak, nonatomic) IBOutlet UILabel *commentsCount;
@property (weak, nonatomic) IBOutlet UILabel *comments;
@property (weak, nonatomic) IBOutlet UIImageView *img0;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;
@property (weak, nonatomic) IBOutlet UIImageView *img5;


@end
@implementation YHNewsCell

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [[UICollectionViewCell alloc] init];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (void)initWithNews:(YHNews *)news {
    
    self.news = news;
    [self.avatar setImageWithURL:[NSURL URLWithString:self.news.avatar]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat       = @"HH:mm";
    
    
    self.name.text          = self.news.name;
    self.car.text           = self.news.car;
    self.time.text          = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.news.time]];
    self.content.text       = self.news.content;
    self.location.text      = self.news.location;
    self.likesCount.text    = [NSString stringWithFormat:@"赞:%ld", self.news.likesCount];
    self.commentsCount.text = [NSString stringWithFormat:@"评论:%ld", self.news.commentsCount];
    
    [self initImages];
    
}

- (void) initImages {
    NSInteger imageCount = [self.news.images count];
    NSString *urlStr = imageCount > 0 ? [self.news.images objectAtIndex:0] : nil;
    if (urlStr) {
        [self.img0 setImageWithURL:[NSURL URLWithString:urlStr]];
    } else {
        [self.img0 setImage:nil];
    }
    
    urlStr = imageCount > 1 ? [self.news.images objectAtIndex:1] : nil;
    if (urlStr) {
        [self.img1 setImageWithURL:[NSURL URLWithString:urlStr]];
    } else {
        [self.img1 setImage:nil];
    }
    
    if (imageCount == 4) { //four is fucking magic 😂
        [self.img2 setImage:nil];
        [self.img3 setImageWithURL:[NSURL URLWithString:[self.news.images objectAtIndex:2]]];
        [self.img4 setImageWithURL:[NSURL URLWithString:[self.news.images objectAtIndex:3]]];
    } else {
        urlStr = imageCount > 2 ? [self.news.images objectAtIndex:2] : nil;
        if (urlStr) {
            [self.img2 setImageWithURL:[NSURL URLWithString:urlStr]];
        } else {
            [self.img2 setImage:nil];
        }
        
        urlStr = imageCount > 3 ? [self.news.images objectAtIndex:3] : nil;
        if (urlStr) {
            [self.img3 setImageWithURL:[NSURL URLWithString:urlStr]];
        } else {
            [self.img3 setImage:nil];
        }
        
        urlStr = imageCount > 4 ? [self.news.images objectAtIndex:4] : nil;
        if (urlStr) {
            [self.img4 setImageWithURL:[NSURL URLWithString:urlStr]];
        } else {
            [self.img4 setImage:nil];
        }
    }
    
    
    urlStr = imageCount > 5 ? [self.news.images objectAtIndex:5] : nil;
    if (urlStr) {
        [self.img5 setImageWithURL:[NSURL URLWithString:urlStr]];
    } else {
        [self.img5 setImage:nil];
    }
}

+ (NSString *)identifier {
    return IDENTTIFIER;
}

- (void)awakeFromNib {
    
    //
    _car.layer.cornerRadius = 6;
    _car.layer.masksToBounds = YES;
    
    
    _content.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - _content.frame.origin.x - 8;
    
    //set avatar touched action
    [self.avatar addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nameTouched:)]];
    
    //set name label touched action
    [self.name addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nameTouched:)]];
    
    //set image touched action
    [self.img0 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTouched:)]];
    [self.img1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTouched:)]];
    [self.img2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTouched:)]];
    [self.img3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTouched:)]];
    [self.img4 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTouched:)]];
    [self.img5 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTouched:)]];
    
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)layoutSubviews {
    [super layoutSubviews];
}


-(void) imgTouched:(UITapGestureRecognizer*)gestureRecgnizer {
    if (((UIImageView *)gestureRecgnizer.view).image == nil) {
        return;
    }
    if ([self.news.images count] == 4 && (gestureRecgnizer.view.tag == 3 || gestureRecgnizer.view.tag == 4)) {
        [_delegate imageTouchedWithNid:self.news.nid imageId:gestureRecgnizer.view.tag - 1];
    } else {
        [_delegate imageTouchedWithNid:self.news.nid imageId:gestureRecgnizer.view.tag];
    }
    
    
}

-(void) nameTouched:(UITapGestureRecognizer*)gestureRecgnizer {
    [_delegate nameTouched];
}


@end
