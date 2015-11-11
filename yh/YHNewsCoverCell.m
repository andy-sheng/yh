//
//  YHNewsCoverCell.m
//  yh
//
//  Created by andy on 15/11/2.
//  Copyright © 2015年 andy. All rights reserved.
//

#import "YHNewsCoverCell.h"


#define IDENTIFIER @"coverCell"
#define XIB_WIDTH 600

@interface YHNewsCoverCell()

@property (weak, nonatomic) IBOutlet UIButton *cover;
@property (weak, nonatomic) IBOutlet UIButton *avata;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *slogan;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarLeading;
@property (strong, nonatomic) YHUser *user;

@end

@implementation YHNewsCoverCell

+ (YHNewsCoverCell *)newsCoverCellWithUser:(YHUser *)user {
    YHNewsCoverCell *cell = [[NSBundle mainBundle] loadNibNamed:@"YHNewsCoverCell" owner:nil options:nil][0];
    cell.user = user;
    return cell;
}

- (IBAction)changeCover:(id)sender {
    
    [_delegate coverTouched];
    
}

+ (NSString *)identifier {
    return IDENTIFIER;
}

- (void)setUser:(YHUser *)user {
    _user = user;
    //set data
    [_cover setBackgroundImage:[UIImage imageNamed:_user.cover] forState:UIControlStateNormal];
    _name.text = _user.name;
    _slogan.text = _user.slogan;
    [_avata setBackgroundImage:[UIImage imageNamed:_user.avatar] forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    //adjust layout
    _avatarTop.constant = _avatarTop.constant * [UIScreen mainScreen].bounds.size.width / XIB_WIDTH;
    _avatarLeading.constant = _avatarLeading.constant * [UIScreen mainScreen].bounds.size.width / XIB_WIDTH;
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSLog(@"%@", self.reuseIdentifier);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
