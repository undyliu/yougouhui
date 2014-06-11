//
//  ZKHShopSaleCell.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-6.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHShopSaleCell.h"

#define DEFAULT_GAP_HEIGHT 2
#define kImageHeight 55

@implementation ZKHShopSaleCell

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
        return screenBounds.size.width - 140;
    }else{
        return screenBounds.size.height - 140;
    }
}

+ (CGFloat)cellHeight:(ZKHSaleEntity *)sale
{
    CGFloat cellHeight = 100;
    CGFloat contentHeight = [ZKHShopSaleCell contentLabelHeight:sale];
    if (contentHeight > kImageHeight) {
        cellHeight = 90 - kImageHeight + contentHeight + [ZKHShopSaleCell countLabelHeight];
    }
    return cellHeight;
}

+ (CGFloat) contentLabelHeight:(ZKHSaleEntity *)sale
{
    int fontSize = 14;
    CGFloat cellRightWidth = [ZKHShopSaleCell cellRightWidth];
    int mod = (fontSize *sale.content.length) % [[[NSDecimalNumber alloc]initWithFloat:cellRightWidth] intValue];
    int rows = fontSize *sale.content.length / cellRightWidth;
    if (rows == 0) {
        rows = 1;
    }else{
        if (mod > 0) {
            rows++;
        }
    }
    
    return rows * 16;
}

+ (CGFloat) countLabelHeight
{
    return 20;
}

- (void)updateViews:(ZKHSaleEntity *)sale
{
    [self updateContentLabel:sale];
    [self updateCountLabel:sale];
}

- (void)updateContentLabel:(ZKHSaleEntity *)sale
{
    CGRect iFrame = self.saleImageView.frame;
    CGRect frame = CGRectMake(iFrame.origin.x + iFrame.size.width + DEFAULT_GAP_HEIGHT, iFrame.origin.y, [ZKHShopSaleCell cellRightWidth], [ZKHShopSaleCell contentLabelHeight:sale]);
    if (!self.contentLabel) {
        self.contentLabel = [[UILabel alloc] init];
        
        self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font=[UIFont systemFontOfSize:14];
        
        [self addSubview:self.contentLabel];
    }
    self.contentLabel.frame = frame;
    self.contentLabel.text = sale.content;
}

-(void)updateCountLabel:(ZKHSaleEntity *)sale
{
    if (!self.countLabel) {
        self.countLabel = [[UILabel alloc] init];
        self.countLabel.font=[UIFont systemFontOfSize:12];
        self.countLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.countLabel];
    }
    
    CGRect cFrame = self.contentLabel.frame;
    NSString *countText = [NSString stringWithFormat:@"共%@位浏览 %@条评论", sale.visitCount, sale.discussCount];
    CGFloat width = [countText length] * 12;
    CGFloat height = [ZKHShopSaleCell countLabelHeight];
    CGFloat x = cFrame.origin.x + [ZKHShopSaleCell cellRightWidth] - width;
    
    CGRect frame;
    CGRect iFrame = self.saleImageView.frame;
    CGFloat contentHeight = [ZKHShopSaleCell contentLabelHeight:sale];
    if (iFrame.size.height > contentHeight + height) {//以图片为参照
        frame = CGRectMake(x, iFrame.origin.y + iFrame.size.height - height, width, height);
    }else{
        
        frame = CGRectMake(x, cFrame.origin.y + cFrame.size.height, width, height);
    }
    
    self.countLabel.frame = frame;
    self.countLabel.text = countText;
}

@end
