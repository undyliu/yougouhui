//
//  ZKHShareShopReplyCell.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-11.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHEntity.h"

@interface ZKHShareShopReplyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (strong, nonatomic) UIImageView *shareImageView;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UILabel *publishDateLabel;
@property (strong, nonatomic) UILabel *disCountLabel;

+ (CGFloat)cellHeight:(ZKHShareEntity *)share;

- (void) updateViews:(ZKHShareEntity *)share;

@end
