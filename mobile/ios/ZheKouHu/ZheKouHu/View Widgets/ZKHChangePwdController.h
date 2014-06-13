//
//  ZKHChangePwdController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-26.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHTextField.h"

@interface ZKHChangePwdController : UIViewController
{
    NSString *orginalPwd;
}

@property (weak, nonatomic) IBOutlet UILabel *itemNameLable;
@property (weak, nonatomic) IBOutlet UILabel *itemValueLabel;
@property (weak, nonatomic) IBOutlet ZKHTextField *oldPwdField;
@property (weak, nonatomic) IBOutlet ZKHTextField *pwdNewField;
@property (weak, nonatomic) IBOutlet ZKHTextField *pwdNewConfField;

- (NSString *) getOriginalPwd;

- (IBAction)save:(id)sender;
- (void) doSave:(NSString *)oldPwd newPwd:(NSString *) newPwd;
- (IBAction)backgroupTap:(id)sender;

@end
