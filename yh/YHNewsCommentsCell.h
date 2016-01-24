//
//  YHNewsCommentsCell.h
//  yh
//
//  Created by andy on 15/12/12.
//  Copyright © 2015年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHNewsCommentsCellDelegate
@required

- (void)commentKeyBoardWillPopWithLoc:(CGPoint) loc commentDic:(NSMutableDictionary*) comment;

@end

@interface YHNewsCommentsCell : UITableViewCell

@property (weak, nonatomic) id<YHNewsCommentsCellDelegate> delegate;

+ (NSString *)identifier;
- (void)initWithComments:(NSMutableArray*) comments;
- (instancetype)initWithCommentsCount:(NSInteger) count;
- (void)setupWithComments:(NSMutableArray*) comments;

@end
