//
//  ZKHChangeFieldView.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-23.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHChangeTextView.h"

@implementation ZKHChangeTextView
- (IBAction)fieldDoneEditing:(id)sender{
    [self.inputTextField resignFirstResponder];
}

@end