//
//  ZKHMyFavoritController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-28.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ViewPagerController.h"
#import "ZKHSaleFavoritListController.h"
#import "ZKHShopFavoritListController.h"

@interface ZKHMyFavoritController : ViewPagerController
{
    NSArray *pageTabs;
}
@property (strong, nonatomic) ZKHSaleFavoritListController *saleListController;
@property (strong, nonatomic) ZKHShopFavoritListController *shopListController;
@end
