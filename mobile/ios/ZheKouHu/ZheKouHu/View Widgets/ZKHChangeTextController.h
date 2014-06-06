//
//  ZKHChangeTextController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-23.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHTextField.h"

@interface ZKHChangeTextController : UIViewController
{
    NSString *orginalValue;
}
@property (weak, nonatomic) IBOutlet ZKHTextField *inputTextField;

- (NSString *) getOriginalTextFieldValue;

- (IBAction)save:(id)sender;
- (void) doSave:(NSString *) newValue;

- (IBAction)backgroupTap:(id)sender;

@end
