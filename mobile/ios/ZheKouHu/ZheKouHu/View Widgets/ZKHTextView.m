//
//  ZKHTextView.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-30.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ZKHTextView.h"
#import "NSString+Utils.h"

@implementation ZKHTextView

- (void)awakeFromNib

{
    [super awakeFromNib];
    
    [self setPlaceholder:@""];
    
    [self setPlaceholderColor:[UIColor lightGrayColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setPlaceholder:@""];
        
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textChanged:(NSNotification *)notification
{
    if([[self placeholder] length] == 0)
    {
        return;
    }
    
    if([[self text] length] == 0)
    {
        [[self viewWithTag:999] setAlpha:1];
        [self showTipView];
    }else
    {
        [[self viewWithTag:999] setAlpha:0];
        
        [self hideTipView];
    }
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
    
}

- (void)drawRect:(CGRect)rect
{
    [self setBorderColor:[UIColor grayColor]];
    
    if( [[self placeholder] length] > 0 )
    {
        if (placeHolderLabel == nil )
        {
            placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,8,self.bounds.size.width - 16,0)];
            placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            placeHolderLabel.numberOfLines = 0;
            placeHolderLabel.font = self.font;
            placeHolderLabel.backgroundColor = [UIColor clearColor];
            placeHolderLabel.textColor = self.placeholderColor;
            placeHolderLabel.alpha = 0;
            placeHolderLabel.tag = 999;
            
            [self addSubview:placeHolderLabel];
            
        }
     
        placeHolderLabel.text = self.placeholder;
        
        [placeHolderLabel sizeToFit];
        
        [self sendSubviewToBack:placeHolderLabel];
        
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [[self viewWithTag:999] setAlpha:1];
    }

    [super drawRect:rect];
    
}

- (void)setBorderColor:(UIColor *)color
{
    self.layer.borderColor = color.CGColor;
    
    self.layer.borderWidth =1.0;
    
    self.layer.cornerRadius =5.0;
}

- (BOOL)becomeFirstResponder
{
    [self hideTipView];
    return [super becomeFirstResponder];
}

- (void)hideTipView
{
    if (popTipView) {
        [popTipView dismissAnimated:YES];
        [self setBorderColor:[UIColor grayColor]];
    }
}

- (void)showTipView
{
    [self showTipView:self.popMessageWhenEmptyText];
}

- (void)showTipView:message
{
    if (popTipView.targetObject) {
        return;
    }
    if (!popTipView) {
        popTipView = [[CMPopTipView alloc] initWithMessage:message];
        popTipView.animation = arc4random() % 2;
        popTipView.has3DStyle = (BOOL)(arc4random() % 2);
        //popTipView.dismissTapAnywhere = YES;
    }else{
        popTipView.message = message;
    }
    
    [popTipView presentPointingAtView:self inView:self.superview animated:YES];
    
    NSString *value = self.text;
    if ([NSString isNull:value]) {
        [self setBorderColor:[UIColor redColor]];
    }else{
        [self setBorderColor:[UIColor orangeColor]];
    }
}

@end
