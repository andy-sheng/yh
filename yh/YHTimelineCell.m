//
//  YHTimelineCell.m
//  yh
//
//  Created by andy on 16/1/25.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "YHTimelineCell.h"

@interface YHTimelineCell()

@property (weak, nonatomic) YHNews* news;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@end



@implementation YHTimelineCell

- (YHTimelineCell *)initWithNews:(YHNews *)news {
    self.news = news;
    [self setupUI];
    return self;
}


- (void)setupUI {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat       = @"HH:mm";
    
    self.contentLabel.text = self.news.content;
    self.timeLabel.text = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.news.time]];
    
}
@end
