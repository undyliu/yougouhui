//
//  ZKHMyShareCell.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-11.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHEntity.h"

@interface ZKHMyShareCell : UITableViewCell

@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIImageView *shareImageView;

+ (CGFloat) cellHeight:(ZKHShareEntity *)share;

- (void) updateViews:(ZKHShareEntity *)share;

@end
