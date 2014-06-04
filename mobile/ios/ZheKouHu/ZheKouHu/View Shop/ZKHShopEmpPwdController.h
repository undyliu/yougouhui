//
//  ZKHShopEmpPwdController.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-4.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHEntity.h"

@interface ZKHShopEmpPwdController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UITextField *pwdConfField;

@property (strong, nonatomic) ZKHUserEntity *emp;
@property (strong, nonatomic) ZKHShopEntity *shop;

- (IBAction)save:(id)sender;

@end
