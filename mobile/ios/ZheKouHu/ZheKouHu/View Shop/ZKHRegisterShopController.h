//
//  ZKHRegisterShopController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-21.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKReverseGeocoder.h>
#import <MapKit/MKPlacemark.h>

#import "ViewPagerController.h"
#import "ZKHTextField.h"
#import "ZKHTextView.h"

@interface ZKHRegisterShopController : ViewPagerController<UITableViewDataSource, UITableViewDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate>
{
    NSArray *pageTabs;
    NSMutableArray *_trades;
    UIImageView *currentImageView;
    
    NSMutableArray *selectedTradeIds;
    
    CLGeocoder *geocoder;
}

@property (strong, nonatomic) IBOutlet UIViewController *licenseController;
@property (strong, nonatomic) IBOutlet UIViewController *baseInfoController;
@property (strong, nonatomic) IBOutlet UIViewController *ownerController;
@property (strong, nonatomic) IBOutlet UITableViewController *tradesController;

@property (weak, nonatomic) IBOutlet UIScrollView *shopInfoView;
@property (weak, nonatomic) IBOutlet ZKHTextField *shopNameField;
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
@property (weak, nonatomic) IBOutlet ZKHTextView *addrField;
@property (weak, nonatomic) IBOutlet UIImageView *busiLicenseView;
@property (weak, nonatomic) IBOutlet ZKHTextView *descField;
@property (weak, nonatomic) IBOutlet UIImageView *delShopImageView;
@property (weak, nonatomic) IBOutlet UIImageView *delBusiLicenseView;

@property (weak, nonatomic) IBOutlet UIView *shopOwnerView;
@property (weak, nonatomic) IBOutlet ZKHTextField *ownerPhoneField;
@property (weak, nonatomic) IBOutlet ZKHTextField *owerNameField;
@property (weak, nonatomic) IBOutlet ZKHTextField *ownerPwdField;
@property (weak, nonatomic) IBOutlet ZKHTextField *ownerPwdConfField;


@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

- (void)registerShop:(id)sender;
- (IBAction)tradeSwitchChanged:(UISwitch *)sender;

@end

