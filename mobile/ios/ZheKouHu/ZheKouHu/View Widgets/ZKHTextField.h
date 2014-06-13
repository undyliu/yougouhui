//
//  ZKHTextField.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-26.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMPopTipView.h"

@interface ZKHTextField : UITextField
{
    CMPopTipView *popTipView;
}

@property (strong, nonatomic) NSString *popMessageWhenEmptyText;

- (IBAction)fieldEditingDidDone:(id)sender;
- (IBAction)fieldEditingDidBegin:(id)sender;
- (IBAction)fieldDoneEditing:(id)sender;

- (void) setBorderColor:(UIColor *)color;
- (void)showTipView;
- (void)showTipView:(NSString *)message;
@end
