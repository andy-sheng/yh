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
#import "YHConfig.h"

#define IDENTIFIER @"commentsCell"



@interface YHNewsCommentsCell()

@property (assign, nonatomic) NSInteger newsId;
@property (strong, nonatomic) UIImageView *tranImage;
@property (weak, nonatomic) NSMutableArray *comments;
@property (strong,nonatomic) NSMutableArray *commentLabels;
@end

@implementation YHNewsCommentsCell

+ (NSString*)identifier {
    return IDENTIFIER;
}


- (void)initWithComments:(NSMutableArray*) comments {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.comments = nil;
    self.comments = comments;
    [self updateConstraints];
}

- (instancetype)initWithCommentsCount:(NSInteger)count {
    NSLog(@"count:%ld", count);
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%@-%ld", IDENTIFIER, count]];
    
    if (count > 0) {
        self.tranImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tra.png"]];
        [self.contentView addSubview:self.tranImage];
    }
    for (NSInteger i = 0 ; i < count; i++) {
        // init comment label
        UILabel *commentLabel = [[UILabel alloc] init];
        commentLabel.text                    = @"评论";
        commentLabel.userInteractionEnabled  = YES;
        commentLabel.numberOfLines           = 0;
        commentLabel.lineBreakMode           = NSLineBreakByWordWrapping;
        commentLabel.preferredMaxLayoutWidth = self.contentView.frame.size.width;
        commentLabel.backgroundColor         = COMMENT_LABEL_COLOR;
        commentLabel.tag                     = [[self.comments[i] objectForKey:@"cid"] integerValue];
        commentLabel.font                    = [UIFont systemFontOfSize:COMMENT_LABEL_FONT_SIZE];
        [commentLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentLabelTouched:)]];
        [commentLabel addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(commentLabelPressed:)]];
        [self.commentLabels addObject:commentLabel];
        [self.contentView addSubview:commentLabel];
        NSLog(@"set label:%ld", i + 1);
        
    }
    
    [self updateConstraints];
    return self;
}

- (void)setupWithComments:(NSMutableArray *)comments{
    if ([comments count] > 0) {
        self.newsId = [[comments[0] objectForKey:@"nid"] integerValue];
    }
    for (NSInteger i = 0; i < [comments count]; i++) {
        UILabel *label = [self.contentView.subviews objectAtIndex:i+1];
        if (![[comments[i] objectForKey:@"to"]  isEqual: @""]) {
            [label setText:[NSString stringWithFormat:@"%@回复%@:%@", [comments[i] objectForKey:@"from"], [comments[i] objectForKey:@"to"], [comments[i] objectForKey:@"content"]]];
        } else {
            [label setText:[NSString stringWithFormat:@"%@:%@", [comments[i] objectForKey:@"from"], [comments[i] objectForKey:@"content"]]];
        }
    }
}

- (void)updateConstraints {
    NSLog(@"update");
    for (NSInteger i = 0; i < [self.contentView.subviews count]; i++) {
        UIView *tmp = [self.contentView.subviews objectAtIndex:i];
        if (i == 0) {
            NSLog(@"imageview");
            [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@10);
                make.height.equalTo(@10);
                make.top.equalTo(self.contentView.mas_top);
                make.leading.equalTo(@50);
            }];
        } else {
            [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
                UIView *lastView = [self.contentView.subviews objectAtIndex:i - 1];
                make.top.equalTo(lastView.mas_bottom);
                make.trailing.equalTo(self.contentView.mas_trailingMargin);
                make.leading.equalTo(lastView.mas_leading);
            }];
        }
    }
    [[self.contentView.subviews lastObject] mas_remakeConstraints:^(MASConstraintMaker *make) {
        UIView *lastView = [self.contentView.subviews objectAtIndex:[self.contentView.subviews count] - 2];
        make.top.equalTo(lastView.mas_bottom);
        make.trailing.equalTo(self.contentView.mas_trailingMargin);
        make.bottom.equalTo(self.contentView.mas_bottomMargin);
        make.leading.equalTo(lastView.mas_leading);
    }];
    [super updateConstraints];
}


- (void) commentLabelTouched:(UITapGestureRecognizer *)recognizer{
    NSLog(@"%ld-comment touched", recognizer.view.tag);
    CGPoint loc = CGPointMake(0, recognizer.view.frame.origin.y + recognizer.view.frame.size.height + self.frame.origin.y);
    NSMutableDictionary *comment = [[NSMutableDictionary alloc] init];
    [comment setObject:[NSString stringWithFormat:@"%ld", self.newsId] forKey:@"nid"];
    [comment setObject:@"100" forKey:@"cid"];
    [comment setObject:@"" forKey:@"from"];
    [comment setObject:@"haha" forKey:@"to"];
    [self.delegate commentKeyBoardWillPopWithLoc:loc commentDic:comment];
}

- (void) commentLabelPressed:(UILongPressGestureRecognizer *)recognizer{
    NSLog(@"%ld-comment pressed", recognizer.view.tag);
}

@end
