//
//  ZKHRadarScanController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-28.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHRadarScanController.h"
#import "ZKHProcessor+Setting.h"
#import "ZKHAppDelegate.h"
#import "ZKHEntity.h"
#import "ZKHConst.h"
#import "ZKHContext.h"
#import "NSString+Utils.h"

@interface ZKHRadarScanController ()<ViewPagerDataSource, ViewPagerDelegate>

@end

@implementation ZKHRadarScanController

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
    
    self.title = @"雷达扫描";
    
    pageTabs = @[@"活动", @"商铺"];
    
    self.saleListController = [[ZKHScanSaleListController alloc] init];
    self.shopListController = [[ZKHScanShopListController alloc] init];
    
    self.dataSource = self;
    self.delegate = self;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager startUpdatingLocation];
    
    [ApplicationDelegate.zkhProcessor radarSetting:[ZKHContext getInstance].user.uuid withDefaultValue:true completionHandler:^(ZKHSettingEntity *setting) {
        NSDictionary *value = [setting.value toJSONObject];
        NSString *disctance = [value valueForKey:RADAR_VAL_FIELD_DISTANCE];
        self.hitLabel.text = [NSString stringWithFormat:@"附近 %@ 米范围内的:", disctance];
    } errorHandler:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Interface Orientation Changes
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    // Update changes after screen rotates
    [self performSelector:@selector(setNeedsReloadOptions) withObject:nil afterDelay:duration];
}

#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return [pageTabs count];
}

- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14.0];
    label.text = pageTabs[index];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    
    return label;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    return index == 0 ? self.saleListController : self.shopListController;
}

#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;
        case ViewPagerOptionCenterCurrentTab:
            return 1.0;
        case ViewPagerOptionTabLocation:
            return 1.0;
        case ViewPagerOptionTabHeight:
            return 49.0;
        case ViewPagerOptionTabOffset:
            return 36.0;
        case ViewPagerOptionTabTopOffset:
            return 50.0;
        case ViewPagerOptionTabWidth:
            return UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ? 128.0 : 96.0;
        case ViewPagerOptionFixFormerTabsPositions:
            return 1.0;
        case ViewPagerOptionFixLatterTabsPositions:
            return 1.0;
        default:
            return value;
    }
}
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
        case ViewPagerTabsView:
            return [[UIColor lightGrayColor] colorWithAlphaComponent:0.32];
        case ViewPagerContent:
            return [[UIColor darkGrayColor] colorWithAlphaComponent:0.32];
        default:
            return color;
    }
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    if (newLocation.verticalAccuracy < 0 || newLocation.horizontalAccuracy < 0) {
        return;
    }
    if (newLocation.verticalAccuracy > 100 || newLocation.horizontalAccuracy > 500) {
        return;
    }

    if (!self.location){
        self.location = newLocation;
    }
}

@end
