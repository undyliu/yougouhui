//
//  ZKHChangeShopPwdController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-26.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHChangeShopPwdController.h"
#import "ZKHAppDelegate.h"
#import "ZKHProcessor+Shop.h"
#import "ZKHContext.h"

@implementation ZKHChangeShopPwdController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"店铺-修改密码";
    
    self.itemValueLabel.text = self.shop.name;
    self.itemNameLable.text = @"店铺名称";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSString *)getOriginalPwd
{
    return nil;
}

- (void)doSave:(NSString *)oldPwd newPwd:(NSString *)newPwd
{
    NSString *userId = [ZKHContext getInstance].user.uuid;
    [ApplicationDelegate.zkhProcessor changeShopEmpPwd:self.shop.uuid userId:userId oldPwd:oldPwd newPwd:newPwd completionHandler:^(Boolean result) {
        if (result) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } errorHandler:^(ZKHErrorEntity *error) {
        
    }];
}

@end
