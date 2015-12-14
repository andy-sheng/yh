//
//  YHChartCell.m
//  hi
//
//  Created by lixiangqian on 15/11/13.
//  Copyright © 2015年 lixiangqian. All rights reserved.
//

#import "YHChartCell.h"
#import "YHStatus.h"

#define  IDENTIFIER @"chartCell"
@interface YHChartCell()


@end
@implementation YHChartCell

@synthesize userImage=_userImage;
@synthesize userName=_userName;
@synthesize userMessage=_userMessage;
@synthesize userTimer=_userTimer;
@synthesize userSource=_userSource;
- (void)awakeFromNib {
    // Initialization code
    [self updateConstraints];

}

-(void)updateConstraints{
    [super updateConstraints];
    //[NSLayoutConstraint constraintWithItem:_userImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:0 constant:8];
    
    //[NSLayoutConstraint constraintWithItem:_userImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:0 constant:8];
    
    //[NSLayoutConstraint constraintWithItem:_userMessage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:0 constant:40];
}

+(NSString *)identifier{
    return IDENTIFIER;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
