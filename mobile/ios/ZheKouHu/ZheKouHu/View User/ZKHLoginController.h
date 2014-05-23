//
//  ZKHLoginController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-20.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKHLoginController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *pwdText;
@property (weak, nonatomic) IBOutlet UISwitch *rememberPwdSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;

- (IBAction)pwdFieldDoneEditing:(id)sender;
- (IBAction)phoneFieldDoneEditing:(id)sender;
- (IBAction)autoLoginChanged:(UISwitch *)sender;
- (IBAction)backgroupTap:(id)sender;
- (IBAction)rememberPwdChanged:(UISwitch *)sender;
- (IBAction)phoneFieldEditingEnd:(id)sender;

- (IBAction)login;
- (IBAction)registerUser;

@end
