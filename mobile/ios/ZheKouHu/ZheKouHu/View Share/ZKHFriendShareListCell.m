//
//  ZKHFriendShareListCell.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-9.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHFriendShareListCell.h"
#import "ZKHViewUtils.h"

#define DEFAULT_GAP_HEIGHT 2

static NSString *SaleDiscussCellIdentifier = @"SaleDiscussListCell";

@implementation ZKHFriendShareListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeight:(ZKHShareEntity *)share
{
    CGFloat height =  20 + DEFAULT_GAP_HEIGHT + [ZKHFriendShareListCell contentLabelHeight:share] + DEFAULT_GAP_HEIGHT + [ZKHFriendShareListCell imagesViewHeight:share] + DEFAULT_GAP_HEIGHT
    + [ZKHFriendShareListCell publishDateHeight] + [ZKHFriendShareListCell commentsViewHeight:share] + 15;
    
    return height;
}

+ (CGFloat) cellRightWidth
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (currentOrientation == UIInterfaceOrientationPortrait || currentOrientation == UIInterfaceOrientationPortraitUpsideDown){//竖屏
        return screenBounds.size.width - 60;
    }else{
        return screenBounds.size.height - 60;
    }
    
}

+ (CGFloat) contentLabelHeight:(ZKHShareEntity *)share
{
    int fontSize = 14;
    CGFloat cellRightWidth = [ZKHFriendShareListCell cellRightWidth];
    int mod = (fontSize *share.content.length) % [[[NSDecimalNumber alloc]initWithFloat:cellRightWidth] intValue];
    int rows = fontSize *share.content.length / cellRightWidth;
    if (rows == 0) {
        rows = 1;
    }else{
        if (mod > 0) {
            rows++;
        }
    }
    
    return rows * 18;
}

+ (CGFloat) publishDateHeight
{
    return 24;
}

+ (CGFloat) imagesViewHeight:(ZKHShareEntity *)share
{
    if ([share.imageFiles count] > 0) {
        int count = [share.imageFiles count];
        int tmp = [[[NSDecimalNumber alloc]initWithFloat:[ZKHFriendShareListCell cellRightWidth]] intValue] / 55;
        tmp = count % tmp != 0 || count / tmp == 0? count / tmp + 1: count / tmp;
        return  tmp * 55;
    }else{
        return 0;
    }
}

+ (CGFloat) commentsViewHeight:(ZKHShareEntity *)share
{
    return [share.comments count] * 32;
}

+ (CGFloat) shopReplyHeight:(ZKHShareEntity *)share
{
    CGFloat height = 0;
    ZKHShareShopReplyEntity *reply = share.shopReply;
    if (reply) {
        return 40;
    }
    return height;
}

- (void)updateViews:(ZKHShareEntity *)share shareListPicController:(id)shareListPicController commentsController:(id)commentsController
{
    [self updateContentLabel:share];
    [self updateImagesView:share shareListPicController:shareListPicController];
    [self updatePublishDateLabel:share];
    [self updateCommentImageView:share];
    
    if (self.showShopReplyInfo) {
        [self updateShopReplyLabel:share];
    }
    
    [self updateCommentTableView:share commentsController:commentsController];
    }

- (void) updateContentLabel:(ZKHShareEntity *)share 
{
    CGRect userNameFrame = self.userNameLabel.frame;
    
    CGFloat width = [ZKHFriendShareListCell cellRightWidth];//self.tagView.frame.size.width;
    CGFloat height = [ZKHFriendShareListCell contentLabelHeight:share];
    
    //添加content
    CGRect contentFrame = CGRectMake(userNameFrame.origin.x, userNameFrame.origin.y + userNameFrame.size.height + DEFAULT_GAP_HEIGHT, width, height);
    //TODO根据content内容动态设置高度
    
    if (!self.contentLabel) {
        self.contentLabel  = [[UILabel alloc] init];

        self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font=[UIFont systemFontOfSize:14];
        
        [self addSubview:self.contentLabel];
    }
    self.contentLabel.frame = contentFrame;
    self.contentLabel.text = share.content;
}

- (void) updateImagesView:(ZKHShareEntity *)share shareListPicController:(id)shareListPicController

{
    if ([share.imageFiles count] > 0) {
        CGRect cFrame = self.contentLabel.frame;
        CGFloat height = [ZKHFriendShareListCell imagesViewHeight:share];
        CGRect frame = CGRectMake(cFrame.origin.x, cFrame.origin.y + cFrame.size.height + DEFAULT_GAP_HEIGHT, cFrame.size.width, height);
        
        if (!self.imagesView) {
            UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            self.imagesView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
            if (!pictureCellNib) {
                pictureCellNib = [UINib nibWithNibName:@"ZKHShareListImageCell" bundle:nil];
            }
            NSString *CellIdentifier = @"ShareListImageCell";
            [self.imagesView registerNib:pictureCellNib forCellWithReuseIdentifier:CellIdentifier];
            self.imagesView.backgroundColor = [UIColor clearColor];
            
            [self addSubview:self.imagesView];
        }else{
            self.imagesView.frame = frame;
        }
    }else{
        if (self.imagesView) {
            CGRect frame = self.imagesView.frame;
            self.imagesView.frame = CGRectMake(frame.origin.x, frame.origin.y, 0, 0);
        }
    }
    
    if (self.imagesView) {
        self.imagesView.delegate = shareListPicController;
        self.imagesView.dataSource = shareListPicController;
        
        [self.imagesView reloadData];
    }
}

- (void) updatePublishDateLabel:(ZKHShareEntity *)share
{
    CGRect iFrame;
    if (self.imagesView) {
        iFrame = self.imagesView.frame;
        if (iFrame.size.height == 0 || iFrame.size.width == 0) {
            iFrame = self.contentLabel.frame;
        }
    }else{
        iFrame = self.contentLabel.frame;
    }
    
    CGFloat height = [ZKHFriendShareListCell publishDateHeight];
    CGRect frame = CGRectMake(iFrame.origin.x, iFrame.origin.y + iFrame.size.height + DEFAULT_GAP_HEIGHT + 8, iFrame.size.width, height);
    if (!self.publishDateLabel) {
        self.publishDateLabel = [[UILabel alloc] init];
        self.publishDateLabel.font=[UIFont systemFontOfSize:12];
        
        [self addSubview:self.publishDateLabel];
    }
    
    self.publishDateLabel.frame = frame;
    self.publishDateLabel.text = share.publishDate;
    
}

-(void)updateCommentImageView:(ZKHShareEntity *)share
{
    CGRect iFrame;
    if (self.imagesView) {
        iFrame = self.imagesView.frame;
        if (iFrame.size.height == 0 || iFrame.size.width == 0) {
            iFrame = self.contentLabel.frame;
        }
    }else{
        iFrame = self.contentLabel.frame;
    }
    
//    if (self.showShopReplyInfo && share.shopReply) {
//        self.commentImageView.frame = CGRectMake(0, 0, 0, 0);
//        return;
//    }
    
    CGFloat x = [ZKHFriendShareListCell cellRightWidth] + iFrame.origin.x - 24;
    CGRect frame = CGRectMake(x, iFrame.origin.y + iFrame.size.height + DEFAULT_GAP_HEIGHT, 24, 24);
    if (!self.commentImageView) {
        self.commentImageView = [[UIButton alloc] init];
        [self.commentImageView setBackgroundImage:[UIImage imageNamed:@"b_comment.png"] forState:UIControlStateNormal];
        [self addSubview:self.commentImageView];
    }
    
    self.commentImageView.frame = frame;
}

-(void)updateCommentTableView:(ZKHShareEntity *)share commentsController:(id)commentsController
{
    CGRect pFrame ;
    if (self.showShopReplyInfo && share.shopReply) {
        pFrame = self.shopReplyLabel.frame;
    }else{
        pFrame = self.publishDateLabel.frame;
    }
    
    if ([share.comments count] > 0) {
        CGFloat height = [ZKHFriendShareListCell commentsViewHeight:share];
        CGRect frame = CGRectMake(pFrame.origin.x, pFrame.origin.y + pFrame.size.height + DEFAULT_GAP_HEIGHT, [ZKHFriendShareListCell cellRightWidth], height);
        if (self.commentTableView) {
            self.commentTableView.frame = frame;
        }else{
            self.commentTableView = [[UITableView alloc] initWithFrame:frame];
            if (!commentCellNib) {
                commentCellNib = [UINib nibWithNibName:@"ZKHSaleDiscussListCell" bundle:nil];
            }
            [self.commentTableView registerNib:commentCellNib forCellReuseIdentifier:SaleDiscussCellIdentifier];
            [ZKHViewUtils setTableViewExtraCellLineHidden:self.commentTableView];
            
            [self addSubview:self.commentTableView];
        }
    }else{
        if (self.commentTableView) {
            self.commentTableView.frame = CGRectMake(pFrame.origin.x, pFrame.origin.y + pFrame.size.height + DEFAULT_GAP_HEIGHT, 0, 0);
        }
    }
    
    if (self.commentTableView) {
        self.commentTableView.dataSource = commentsController;
        self.commentTableView.delegate = commentsController;
        
        [self.commentTableView reloadData];
    }
}

- (void)updateShopReplyLabel:(ZKHShareEntity *)share
{
    if (!share.shopReply) {
        self.shopGradeLabel.frame = CGRectMake(0, 0, 0, 0);
        self.shopReplyLabel.frame = CGRectMake(0, 0, 0, 0);
        return;
    }
    
    if (!self.shopGradeLabel) {
        self.shopGradeLabel = [[UILabel alloc] init];
        self.shopGradeLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:self.shopGradeLabel];
    }
    
    if (!self.shopReplyLabel) {
        self.shopReplyLabel = [[UILabel alloc] init];
        self.shopReplyLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:self.shopReplyLabel];
    }
    
    ZKHShareShopReplyEntity *reply = share.shopReply;
    CGFloat width = [ZKHFriendShareListCell cellRightWidth];
    CGRect pFrame = self.publishDateLabel.frame;
    self.shopGradeLabel.frame = CGRectMake(pFrame.origin.x, pFrame.origin.y + [ZKHFriendShareListCell publishDateHeight], width, 20);
    self.shopGradeLabel.text = [NSString stringWithFormat:@"商户： 奖励 %d 积分", reply.grade];
    
    CGRect gFrame = self.shopGradeLabel.frame;
    self.shopReplyLabel.frame = CGRectMake(gFrame.origin.x, gFrame.origin.y + gFrame.size.height, width, 20);  
    self.shopReplyLabel.text = [NSString stringWithFormat:@"            回复：%@", reply.content];
}
@end

