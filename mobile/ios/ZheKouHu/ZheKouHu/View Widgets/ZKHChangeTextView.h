//
//  ZKHChangeFieldView.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-23.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKHChangeTextView : UIView
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

- (IBAction)fieldDoneEditing:(id)sender;

@end
