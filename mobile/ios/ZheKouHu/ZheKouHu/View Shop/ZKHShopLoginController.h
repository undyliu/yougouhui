//
//  ZKHShopLoginController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-21.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHTextField.h"

@interface ZKHShopLoginController : UIViewController

@property (weak, nonatomic) IBOutlet ZKHTextField *phoneField;
@property (weak, nonatomic) IBOutlet ZKHTextField *pwdField;

- (IBAction)fieldDonEditing:(UITextField *)sender;
- (IBAction)shopLogin:(UIButton *)sender;

- (IBAction)registerShop:(UIButton *)sender;

- (IBAction)backgroupTap:(id)sender;

@end
