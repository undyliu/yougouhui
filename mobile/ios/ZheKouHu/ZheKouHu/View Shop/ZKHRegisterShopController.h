//
//  ZKHRegisterShopController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-21.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ViewPagerController.h"

@interface ZKHRegisterShopController : ViewPagerController
{
    NSArray *pageTabs;
}
@property (strong, nonatomic) IBOutlet UIViewController *licenseController;
@property (strong, nonatomic) IBOutlet UIViewController *baseInfoController;
@property (strong, nonatomic) IBOutlet UIViewController *ownerController;

- (void)registerShop:(id)sender;

@end
