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
#import "AFNetWorking.h"
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
    //self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
}
-(void)setStatus:(YHStatus *)status{

    _userName.text=status.userNameData;
    _userSource.text=status.userSourceData;
    _userTimer.text=status.userCreateAtData;
    /*
    NSString *path=[NSString stringWithFormat:@"%@%@",SERVER_ADDR,status.userImageData];
    NSURL *url=[NSURL URLWithString:path];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        _userImage.image=responseObject;
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%s","Image in MessageView download error!");
    }];
    [operation start];
     */
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
