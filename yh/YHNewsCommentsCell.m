//
//  YHNewsCommentsCell.m
//  yh
//
//  Created by andy on 15/12/12.
//  Copyright © 2015年 andy. All rights reserved.
//

#import "YHNewsCommentsCell.h"
#import <Masonry.h>

#define IDENTIFIER @"commentsCell"
@interface YHNewsCommentsCell()

@property (weak, nonatomic) IBOutlet UIImageView *tranImage;
@property (strong,nonatomic) NSMutableArray *comments;
@end

@implementation YHNewsCommentsCell

+ (NSString*)identifier {
    return IDENTIFIER;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)initWithComments {
    
    [self updateConstraints];
}

- (void)updateConstraints {
    UILabel *comment1 = [[UILabel alloc] init];
    comment1.numberOfLines = 0;
    comment1.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    comment1.text = @"评论评论";
    [self.contentView addSubview:comment1];
    
    
    [comment1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tranImage.mas_bottom);
        make.leading.equalTo(self.tranImage.mas_leading);
        make.trailing.equalTo(comment1.superview.mas_trailingMargin);
        //make.bottom.equalTo(comment1.superview.mas_bottomMargin);
    }];
    
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.top.equalTo(comment1.mas_bottom).with.offset(8);
        make.leading.equalTo(line.superview.mas_leadingMargin);
        make.trailing.equalTo(line.superview.mas_trailingMargin);
        make.bottom.equalTo(line.superview.mas_bottomMargin);
    }];
    
    [super updateConstraints];
}



@end
