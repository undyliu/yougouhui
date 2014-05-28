//
//  ZKHRadarScanController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-28.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>

#import "ViewPagerController.h"
#import "ZKHScanSaleListController.h"
#import "ZKHScanShopListController.h"

@interface ZKHRadarScanController : ViewPagerController<CLLocationManagerDelegate>
{
    NSArray *pageTabs;
}
@property (weak, nonatomic) IBOutlet UILabel *hitLabel;

@property (strong, nonatomic) ZKHScanSaleListController *saleListController;
@property (strong, nonatomic) ZKHScanShopListController *shopListController;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

@end
