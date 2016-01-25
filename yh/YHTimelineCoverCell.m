//
//  YHTimelineCoverCell.m
//  yh
//
//  Created by andy on 16/1/25.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "YHTimelineCoverCell.h"
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>

#define IDENTIFY @"timelinecell"
@interface YHTimelineCoverCell()

@property (weak, nonatomic) YHUser *user;
@property (weak, nonatomic) IBOutlet UILabel *newsCount;
@property (weak, nonatomic) IBOutlet UIImageView *coverImg;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sloganLabel;


@end

@implementation YHTimelineCoverCell

+ (NSString*)identify {
    return IDENTIFY;
}

- (YHTimelineCoverCell *)initWithUser:(YHUser *)user {
    self.user = user;
    [self setupUI];
    return self;
}


- (void)setupUI {
    
    self.newsCount.text = [NSString stringWithFormat:@"%ld条动态", [self.user.newsList count]];
    self.nameLabel.text = self.user.name;
    self.sloganLabel.text = self.user.slogan;
    
    [self.avatarImg setImageWithURL:[NSURL URLWithString:self.user.avatar]];
    [self.coverImg setImageWithURL:[NSURL URLWithString:self.user.cover]];
}

@end
