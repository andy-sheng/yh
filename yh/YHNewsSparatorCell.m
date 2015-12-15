//
//  YHNewsSparator.m
//  yh
//
//  Created by andy on 15/12/15.
//  Copyright © 2015年 andy. All rights reserved.
//

#import "YHNewsSparatorCell.h"
#import "YHConfig.h"
#import <Masonry.h>

#define IDENTIFIER @"sparatorCell"

@interface YHNewsSparatorCell()
@property (strong, nonatomic) UIImageView *line;

@end

@implementation YHNewsSparatorCell

+ (NSString *)identifier {
    return IDENTIFIER;
}

- (YHNewsSparatorCell *)init {
    self = [super init];
    if (!self.line) {
        UITableViewCell *tmp = [super init];
        [tmp setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        self.line = [[UIImageView alloc] init];
        self.line.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
        [tmp.contentView addSubview:self.line];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@NEWS_SPARATOR_HEIGHT);
            make.top.equalTo(self.line.superview.mas_top);
            make.trailing.equalTo(self.line.superview.mas_trailing);
            make.bottom.equalTo(self.line.superview.mas_bottom);
            make.leading.equalTo(self.line.superview.mas_leading);
        }];
    }
    return self;
}


@end
