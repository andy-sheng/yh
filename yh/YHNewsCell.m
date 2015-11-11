//
//  YHTextNewsCell.m
//  yh
//
//  Created by andy on 15/11/3.
//  Copyright © 2015年 andy. All rights reserved.
//

#import "YHNewsCell.h"

#define IDENTTIFIER @"newsCell"
@interface YHNewsCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *car;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *likesCount;
@property (weak, nonatomic) IBOutlet UILabel *commentsCount;
@property (weak, nonatomic) IBOutlet UILabel *comments;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;
@property (weak, nonatomic) IBOutlet UIImageView *img5;
@property (weak, nonatomic) IBOutlet UIImageView *img6;


@end
@implementation YHNewsCell
- (IBAction)avatarTouched:(id)sender {
    [_delegate nameTouched];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [[UICollectionViewCell alloc] init];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (void)setNews:(YHNews *)news {
    //self.content.text = @"定期保养才是真理！定期保养才是真理！定期保养才是真理！定期保养才是真理！定期保养才是真理！定期保养才是真理！定期保养才是真理！定期保养才是真理！定期保养才是真理！定期保养才是真理！定期保养才是真理！定期保养才是真理！";
}

+ (NSString *)identifier {
    return IDENTTIFIER;
}

- (void)awakeFromNib {
    //
    _car.layer.cornerRadius = 6;
    _car.layer.masksToBounds = YES;
    
    
    _content.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - _content.frame.origin.x - 8;
    
    //set name label touched action
    [_name addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nameTouched:)]];
    
    //set image touched action
    [_img1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTouched:)]];
    [_img2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTouched:)]];
    [_img3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTouched:)]];
    [_img4 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTouched:)]];
    [_img5 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTouched:)]];
    [_img6 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTouched:)]];
    
    
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
    [_delegate imageTouched:(int)gestureRecgnizer.view.tag];
}

-(void) nameTouched:(UITapGestureRecognizer*)gestureRecgnizer {
    [_delegate nameTouched];
}


@end
