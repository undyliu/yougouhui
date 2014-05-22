//
//  ZKHShopLoginController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-21.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKHShopLoginController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
- (IBAction)fieldDonEditing:(UITextField *)sender;
- (IBAction)shopLogin:(UIButton *)sender;

- (IBAction)registerShop:(UIButton *)sender;

- (IBAction)backgroupTap:(id)sender;

@end
