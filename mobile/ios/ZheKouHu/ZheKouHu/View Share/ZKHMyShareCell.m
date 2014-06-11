//
//  ZKHMyShareCell.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-11.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHMyShareCell.h"
#import "ZKHImageLoader.h"

@implementation ZKHMyShareCell

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

+ (CGFloat) cellRightWidth
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (currentOrientation == UIInterfaceOrientationPortrait || currentOrientation == UIInterfaceOrientationPortraitUpsideDown){//竖屏
        return screenBounds.size.width - 70;
    }else{
        return screenBounds.size.height - 70;
    }
}

+ (CGFloat)cellHeight:(ZKHShareEntity *)share
{
    CGFloat contentHeight = [ZKHMyShareCell contentLabelHeight:share];
    return [share.imageFiles count] > 0 ? 80 : (contentHeight > 55 ? contentHeight :55);
}

+ (CGFloat) contentLabelHeight:(ZKHShareEntity *)share
{
    int fontSize = 14;
    CGFloat cellRightWidth = [ZKHMyShareCell cellRightWidth];
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

- (void)updateViews:(ZKHShareEntity *)share
{
    [self updateContentLabel:share];
    [self updateImageView:share];
}

- (void) updateImageView:(ZKHShareEntity *)share
{
    if (!self.shareImageView) {
        self.shareImageView = [[UIImageView alloc] init];
        
        [self addSubview:self.shareImageView];
    }
    
    if ([share.imageFiles count] > 0) {
        ZKHFileEntity *file = share.imageFiles[0];
        self.shareImageView.frame = CGRectMake(0, 5, 60, 60);
        [ZKHImageLoader showImageForName:file.aliasName imageView:self.shareImageView];
    }else{
        self.shareImageView.frame = CGRectMake(0, 5, 0, 0);
    }
}

- (void) updateContentLabel:(ZKHShareEntity *)share
{
    if (!self.contentLabel) {
        self.contentLabel = [[UILabel alloc] init];
        
        self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font=[UIFont systemFontOfSize:14];
        
        [self addSubview:self.contentLabel];
    }
    
    CGRect frame;
    if ([share.imageFiles count] > 0) {
        frame = CGRectMake(65, 5, [ZKHMyShareCell cellRightWidth] - 65, [ZKHMyShareCell contentLabelHeight:share]);
    }else{
        frame = CGRectMake(0, 5, [ZKHMyShareCell cellRightWidth], [ZKHMyShareCell contentLabelHeight:share]);
    }
    
    self.contentLabel.frame = frame;
    self.contentLabel.text = share.content;
}

@end
