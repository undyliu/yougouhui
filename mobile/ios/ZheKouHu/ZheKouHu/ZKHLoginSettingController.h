//
//  ZKHLoginSettingController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-22.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKHLoginSettingController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *rememberPwdSwitch;

- (IBAction)rememberPwdChanged:(UISwitch *)sender;
- (IBAction)autoLoginChanged:(UISwitch *)sender;

- (void)saveLoginEnv:(id)sender;

@end
