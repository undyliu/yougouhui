//
//  ZKHChangeShopPwdController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-26.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHChangeShopPwdController.h"

@interface ZKHChangeShopPwdController ()

@end

@implementation ZKHChangeShopPwdController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    // Dispose of any resources that can be recreated.
}

@end
