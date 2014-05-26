//
//  ZKHRegisterShopController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-21.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ViewPagerController.h"

@interface ZKHRegisterShopController : ViewPagerController<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *pageTabs;
    NSMutableArray *_trades;
}

@property (strong, nonatomic) IBOutlet UIViewController *licenseController;
@property (strong, nonatomic) IBOutlet UIViewController *baseInfoController;
@property (strong, nonatomic) IBOutlet UIViewController *ownerController;
@property (strong, nonatomic) IBOutlet UITableViewController *tradesController;

- (void)registerShop:(id)sender;

@end

