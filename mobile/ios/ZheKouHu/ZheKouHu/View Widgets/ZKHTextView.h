//
//  ZKHTextView.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-30.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMPopTipView.h"

@interface ZKHTextView : UITextView
{
    UILabel *placeHolderLabel;
    CMPopTipView *popTipView;
}

@property (strong, nonatomic) NSString *popMessageWhenEmptyText;
@property(nonatomic, retain) NSString *placeholder;
@property(nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

- (void)setBorderColor:(UIColor *)color;
- (void)showTipView;
- (void)showTipView:(NSString *)message;

@end
