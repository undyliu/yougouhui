//
//  ZKHFriendShareListCell.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-9.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHEntity.h"

@interface ZKHFriendShareListCell : UITableViewCell
{
    UINib *pictureCellNib;
    UINib *commentCellNib;
}

@property (weak, nonatomic) IBOutlet UIImageView *userPhotoView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyStatusLabel;

@property(strong, nonatomic) UILabel *contentLabel;
@property(strong, nonatomic) UICollectionView *imagesView;
@property(strong, nonatomic) UILabel *publishDateLabel;
@property(strong, nonatomic) UIButton *commentImageView;
@property(strong, nonatomic) UITableView *commentTableView;
@property(strong, nonatomic) UILabel *shopGradeLabel;
@property(strong, nonatomic) UILabel *shopReplyLabel;

@property (strong, nonatomic) UIViewController *parentController;
@property (nonatomic) Boolean showShopReplyInfo;

+ (CGFloat) cellHeight:(ZKHShareEntity *)share;
+ (CGFloat) shopReplyHeight:(ZKHShareEntity *)share;

- (void)updateViews:(ZKHShareEntity *)share shareListPicController:(id)shareListPicController commentsController:(id)commentsController;

@end
