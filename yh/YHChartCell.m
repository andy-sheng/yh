//
//  YHChartCell.m
//  hi
//
//  Created by lixiangqian on 15/11/13.
//  Copyright © 2015年 lixiangqian. All rights reserved.
//

#import "YHChartCell.h"
#import "YHStatus.h"
#import "YHConfig.h"
#import "UIImageView+AFNetWorking.h"
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
    //[self setStatus:self.cellstatus];
    //self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
}
-(void)setStatus:(YHStatus *)status{

    _userName.text=status.userNameData;
    _userSource.text=status.userSourceData;
    _userTimer.text=status.userCreateAtData;
    
    self.userImageURL=[NSString stringWithFormat:@"%@%@",SERVER_ADDR,status.userImageData];
    [_userImage setImageWithURL:[NSURL URLWithString:self.userImageURL]];
    _userMessage.text=status.usertextData;
    
}

-(void)updateConstraints{
    [super updateConstraints];

}

+(NSString *)identifier{
    return IDENTIFIER;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
