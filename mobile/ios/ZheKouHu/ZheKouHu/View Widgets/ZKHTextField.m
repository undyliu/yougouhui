//
//  ZKHTextField.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-26.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ZKHTextField.h"

@implementation ZKHTextField

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.returnKeyType = UIReturnKeyDone;
        
        [self addTarget:self action:@selector(fieldEditingDidDone:) forControlEvents:UIControlEventEditingDidEnd];
        [self addTarget:self action:@selector(fieldEditingDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
        [self addTarget:self action:@selector(fieldDoneEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}

- (void)fieldEditingDidDone:(id)sender
{
    NSString *value = self.text;
    if (value == nil || [value length] == 0) {
        self.layer.cornerRadius = 8.0f;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [[UIColor redColor] CGColor];
        self.layer.borderWidth = 2.0f;
        
        if ([self.popMessageWhenEmptyText length] > 0) {
            [self showTipView];
        }
    }
}

- (void)fieldEditingDidBegin:(id)sender
{
    self.layer.cornerRadius = 8.0f;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [[UIColor grayColor] CGColor];
    self.layer.borderWidth = 2.0f;
    
    if (popTipView) {
        [popTipView dismissAnimated:YES];
    }
}

- (void)fieldDoneEditing:(id)sender
{
    [self resignFirstResponder];
}

- (void)showTipView
{
    if (popTipView.targetObject) {
        return;
    }
    if (!popTipView) {
        popTipView = [[CMPopTipView alloc] initWithMessage:self.popMessageWhenEmptyText];
        popTipView.animation = arc4random() % 2;
        popTipView.has3DStyle = (BOOL)(arc4random() % 2);
        //popTipView.dismissTapAnywhere = YES;
    }else{
        popTipView.message = self.popMessageWhenEmptyText;
    }
    
    [popTipView presentPointingAtView:self inView:self.superview animated:YES];
}
@end
