//
//  ZKHShopLoginController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-21.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHShopLoginController.h"
#import "ZKHRegisterShopController.h"

@interface ZKHShopLoginController ()

@end

@implementation ZKHShopLoginController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerShop:(UIButton *)sender {
    ZKHRegisterShopController *controller = [[ZKHRegisterShopController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
