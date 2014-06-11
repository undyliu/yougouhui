//
//  ZKHShareShopReplyCell.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-11.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHShareShopReplyCell.h"
#import "ZKHImageLoader.h"

@implementation ZKHShareShopReplyCell

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
    CGFloat height = 40;
    if ([share.imageFiles count] > 0) {
        height += 60;
    }else{
        height += [ZKHShareShopReplyCell contentLabelHeight:share] + [ZKHShareShopReplyCell disCountLabelHeight];
    }
    height += 15;
    
    return height;
}

+ (CGFloat) cellRightWidth
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (currentOrientation == UIInterfaceOrientationPortrait || currentOrientation == UIInterfaceOrientationPortraitUpsideDown){//竖屏
        return screenBounds.size.width - 10;
    }else{
        return screenBounds.size.height - 10;
    }
}

+ (CGFloat) contentLabelHeight:(ZKHShareEntity *)share
{
    int fontSize = 14;
    CGFloat cellRightWidth = [ZKHShareShopReplyCell cellRightWidth];
    if ([share.imageFiles count] > 0) {
        cellRightWidth = cellRightWidth - 60;
    }
    
    int mod = (fontSize *share.content.length) % [[[NSDecimalNumber alloc]initWithFloat:cellRightWidth] intValue];
    int rows = fontSize *share.content.length / cellRightWidth;
    if (rows == 0) {
        rows = 1;
    }else{
        if (mod > 0) {
            rows++;
        }
    }
    
    return rows * 16;
}

+ (CGFloat) disCountLabelHeight
{
    return 16;
}

- (void)updateViews:(ZKHShareEntity *)share
{
    [self updateImageView:share];
    [self updateContentLabel:share];
    [self updatePublishDateLabel:share];
    [self updateDisCountLabel:share];
}

- (void)updateImageView:(ZKHShareEntity *)share
{
    if (!self.shareImageView) {
        self.shareImageView = [[UIImageView alloc] init];
        [self addSubview:self.shareImageView];
    }
    
    if ([share.imageFiles count] > 0) {
        CGRect pFrame = self.photoView.frame;
        self.shareImageView.frame = CGRectMake(pFrame.origin.x, pFrame.origin.y + pFrame.size.height + 5, 60, 60);
        ZKHFileEntity *file = share.imageFiles[0];
        [ZKHImageLoader showImageForName:file.aliasName imageView:self.shareImageView];
    }else{
        self.shareImageView.frame = CGRectMake(0, 0, 0, 0);
    }
}

- (void)updateContentLabel:(ZKHShareEntity *)share
{
    if (!self.contentLabel) {
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:self.contentLabel];
    }
    
    CGRect pFrame = self.photoView.frame;
    if ([share.imageFiles count] > 0) {
        CGFloat width = [ZKHShareShopReplyCell cellRightWidth] - 70;
        CGFloat height = [ZKHShareShopReplyCell contentLabelHeight:share];
        self.contentLabel.frame = CGRectMake(pFrame.origin.x + 70, pFrame.origin.y + pFrame.size.height + 5, width, height);
    }else{
        CGFloat width = [ZKHShareShopReplyCell cellRightWidth];
        CGFloat height = [ZKHShareShopReplyCell contentLabelHeight:share];
        self.contentLabel.frame = CGRectMake(pFrame.origin.x, pFrame.origin.y + pFrame.size.height + 5, width, height);
    }
    self.contentLabel.text = share.content;
}

- (void)updatePublishDateLabel:(ZKHShareEntity *)share
{
    if (!self.publishDateLabel) {
        self.publishDateLabel = [[UILabel alloc] init];
        self.publishDateLabel.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:self.publishDateLabel];
    }
    
    CGRect cFrame = self.contentLabel.frame;
    CGFloat height = [ZKHShareShopReplyCell disCountLabelHeight];
    CGFloat y = 0;
    if (cFrame.size.height + height < self.shareImageView.frame.size.height) {
        y = self.shareImageView.frame.size.height + self.shareImageView.frame.origin.y - height;
    }else{
        y = cFrame.origin.y + cFrame.size.height + 5;
    }
    
    self.publishDateLabel.frame = CGRectMake(cFrame.origin.x, y , 100, height);
    self.publishDateLabel.text = share.publishDate;
}

- (void)updateDisCountLabel:(ZKHShareEntity *)share
{
    if (!self.disCountLabel) {
        self.disCountLabel = [[UILabel alloc] init];
        self.disCountLabel.font = [UIFont systemFontOfSize:12];
        self.disCountLabel.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:self.disCountLabel];
    }
    
    CGRect pFrame = self.publishDateLabel.frame;
    CGFloat x = [ZKHShareShopReplyCell cellRightWidth] - 80;
    CGFloat height = [ZKHShareShopReplyCell disCountLabelHeight];
    self.disCountLabel.frame = CGRectMake(x, pFrame.origin.y, 80, height);

    self.disCountLabel.text = [NSString stringWithFormat:@"共%d条评论", [share.comments count]];
}
@end
