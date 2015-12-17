//
//  YHNewsCommentsCell.m
//  yh
//
//  Created by andy on 15/12/12.
//  Copyright © 2015年 andy. All rights reserved.
//

#import "YHNewsCommentsCell.h"
#import <TTTAttributedLabel.h>
#import <Masonry.h>

#define IDENTIFIER @"commentsCell"
@interface YHNewsCommentsCell()

@property (strong, nonatomic) UIImageView *tranImage;
@property (strong, nonatomic) NSMutableArray *comments;
@property (strong,nonatomic) NSMutableArray *commentLabels;
@end

@implementation YHNewsCommentsCell

+ (NSString*)identifier {
    return IDENTIFIER;
}


- (void)initWithComments:(NSMutableArray*) comments{
    self.comments = nil;
    self.comments = comments;
    if (!self.tranImage) {
        self.tranImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tra.png"]];
        [self.contentView addSubview:self.tranImage];
        [self.tranImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@10);
            make.height.equalTo(@10);
            make.top.equalTo(self.tranImage.superview.mas_top);
            make.leading.equalTo(@50);
        }];
    }
    [self updateConstraints];
}

- (void)updateConstraints {
    
    self.commentLabels = nil;
    
    self.commentLabels = [[NSMutableArray alloc] init];
    NSUInteger commentsCount = [self.comments count];
    
    
    for(NSUInteger i = 0; i < commentsCount; i++) {
        UILabel *commentLabel = [[UILabel alloc] init];
        //初始化label
        commentLabel.userInteractionEnabled = YES;
        commentLabel.numberOfLines          = 0;
        commentLabel.backgroundColor        = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
        commentLabel.tag                    = [[self.comments[i] objectForKey:@"cid"] integerValue];
        [commentLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentLabelTouched:)]];
        [commentLabel addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(commentLabelPressed:)]];
        
        if (![[self.comments[i] objectForKey:@"to"]  isEqual: @""]) {
            commentLabel.text = [NSString stringWithFormat:@"%@回复%@:%@", [self.comments[i] objectForKey:@"from"], [self.comments[i] objectForKey:@"to"], [self.comments[i] objectForKey:@"content"]];
        } else {
            commentLabel.text = [NSString stringWithFormat:@"%@:%@", [self.comments[i] objectForKey:@"from"], [self.comments[i] objectForKey:@"content"]];
        }
        
        [self.contentView addSubview:commentLabel];
        if (i == 0) {
            [commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.tranImage.mas_bottom);
                make.leading.equalTo(self.tranImage.mas_leading);
                make.trailing.equalTo(commentLabel.superview.mas_trailingMargin);
            }];
        } else {
            [commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                UILabel *lastLabel = (UILabel *)self.commentLabels[i - 1];
                make.top.equalTo(lastLabel.mas_bottom);
                make.leading.equalTo(lastLabel.mas_leading);
                make.trailing.equalTo(lastLabel.mas_trailing);
            }];
        }
        [self.commentLabels addObject:commentLabel];
        
    }
    if (commentsCount != 0) {
        [self.commentLabels[commentsCount - 1] mas_updateConstraints:^(MASConstraintMaker *make) {
            UILabel *lastLabel = self.commentLabels[commentsCount - 1];
            make.bottom.equalTo(lastLabel.superview.mas_bottomMargin);
        }];
    }
    
    [super updateConstraints];
}


- (void) commentLabelTouched:(UITapGestureRecognizer *)recognizer{
    NSLog(@"%ld-comment touched", recognizer.view.tag);
}

- (void) commentLabelPressed:(UILongPressGestureRecognizer *)recognizer{
    NSLog(@"%ld-comment pressed", recognizer.view.tag);
}

@end
