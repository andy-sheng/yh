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
#import <TTTAttributedLabel.h>

#define IDENTTIFIER @"newsCell"
@interface YHNewsCell () <TTTAttributedLabelDelegate>

@property (weak, nonatomic) YHNews *news;
@property (weak, nonatomic) NSString *userId;

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *car;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *likesCount;
@property (weak, nonatomic) IBOutlet UILabel *commentsCount;
@property (weak, nonatomic) IBOutlet UITextView *comments;
@property (weak, nonatomic) IBOutlet UIImageView *img0;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;
@property (weak, nonatomic) IBOutlet UIImageView *img5;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentsHeight;


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
    
    self.userId             = self.news.userId;
    self.name.text          = self.news.name;
    self.car.text           = self.news.car;
    self.time.text          = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.news.time]];
    self.content.text       = self.news.content;
    self.location.text      = self.news.location;
    self.likesCount.text    = [NSString stringWithFormat:@"赞:%ld", self.news.likesCount];
    self.commentsCount.text = [NSString stringWithFormat:@"评论:%ld", self.news.commentsCount];


    self.comments.text = @"引用的\na\na\na";


    
    [self initImages];
    
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    [_delegate nameTouched:self.userId];
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
    [super awakeFromNib];
    
    // car tag
    self.car.layer.cornerRadius  = 6;
    self.car.layer.masksToBounds = YES;
    
    // images
    self.img0.layer.cornerRadius  = 6;
    self.img0.layer.masksToBounds = YES;
    self.img1.layer.cornerRadius  = 6;
    self.img1.layer.masksToBounds = YES;
    self.img2.layer.cornerRadius  = 6;
    self.img2.layer.masksToBounds = YES;
    self.img3.layer.cornerRadius  = 6;
    self.img3.layer.masksToBounds = YES;
    self.img4.layer.cornerRadius  = 6;
    self.img4.layer.masksToBounds = YES;
    self.img5.layer.cornerRadius  = 6;
    self.img5.layer.masksToBounds = YES;
    
    // comments
    self.comments.layer.cornerRadius = 6;
    self.comments.layer.masksToBounds = YES;

    
    self.content.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - _content.frame.origin.x - 8;
    
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

- (void)layoutIfNeeded {
    [super layoutIfNeeded];
    self.commentsHeight.constant = [self.comments sizeThatFits:CGSizeMake(self.comments.frame.size.width, MAXFLOAT)].height;
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
    [_delegate nameTouched:self.userId];
}

- (NSInteger) getHeight {
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    self.bounds = CGRectMake(0.0f,0.0f, 328, CGRectGetHeight(self.bounds));
    [self setNeedsLayout];
    [self layoutIfNeeded];
    return [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + + 1;
}

@end
