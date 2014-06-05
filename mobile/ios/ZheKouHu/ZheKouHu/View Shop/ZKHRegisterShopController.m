//
//  ZKHRegisterShopController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-21.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHRegisterShopController.h"
#import "ZKHSwitchCell.h"
#import "ZKHAppDelegate.h"
#import "ZKHEntity.h"
#import "ZKHViewUtils.h"
#import "ZKHImageLoader.h"
#import "ZKHContext.h"
#import "NSDate+Utils.h"
#import "ZKHProcessor+Shop.h"
#import "ZKHAppDelegate.h"


#define  kTagShopImage 1
#define  kTagBusiLicense 2

static NSString *switchCellIdentifier = @"SwitchCell";

@interface ZKHRegisterShopController ()<ViewPagerDataSource, ViewPagerDelegate>

@end

@implementation ZKHRegisterShopController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSBundle *bundle = [NSBundle mainBundle];
        [bundle loadNibNamed:@"ZKHRegisterShopLicense" owner:self options:nil];
        [bundle loadNibNamed:@"ZKHRegisterShopTrades" owner:self options:nil];
        [bundle loadNibNamed:@"ZKHRegisterShopInfo" owner:self options:nil];
        [bundle loadNibNamed:@"ZKHRegisterShopOwner" owner:self options:nil];
        
        selectedTradeIds = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"LABEL_REGISTER_SHOP", @"register shop");

    self.dataSource = self;
    self.delegate = self;
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(registerShop:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    self.tradesController.tableView.delegate = self;
    self.tradesController.tableView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"ZKHSwitchCell" bundle:nil];
    [self.tradesController.tableView registerNib:nib forCellReuseIdentifier:switchCellIdentifier];
    
    [ApplicationDelegate.zkhProcessor trades:true completionHandler:^(NSMutableArray *trades) {
        _trades = trades;
        [self.tradesController.tableView reloadData];
    } errorHandler:^(NSError *error) {
        
    }];
    
    [ZKHViewUtils setTableViewExtraCellLineHidden:self.tradesController.tableView];
    
    [self.shopInfoView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroupTap:)]];
    [self.shopOwnerView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroupTap:)]];
    
    self.shopImageView.userInteractionEnabled = true;
    [self.shopImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addPicViewClick:)]];
    self.busiLicenseView.userInteractionEnabled = true;
    [self.busiLicenseView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addPicViewClick:)]];
    
    self.delShopImageView.hidden = true;
    self.delShopImageView.userInteractionEnabled = true;
    [self.delShopImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(delPicViewClick:)]];
    
    self.delBusiLicenseView.hidden = true;
    self.delBusiLicenseView.userInteractionEnabled = true;
    [self.delBusiLicenseView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(delPicViewClick:)]];
    
    //地理位置
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    geocoder = [[CLGeocoder alloc] init];
    
    //设置默认值
    if (![[ZKHContext getInstance] isAnonymousUserLogined]) {
        ZKHUserEntity *user = [ZKHContext getInstance].user;
        self.ownerPhoneField.text = user.phone;
        self.ownerPhoneField.userInteractionEnabled = false;
        
        self.owerNameField.text = user.name;
        self.owerNameField.userInteractionEnabled = false;
    }
    
    self.descField.placeholder = @"描述一下你的店铺吧";

}

- (IBAction)backgroupTap:(id)sender
{
    [self.shopNameField resignFirstResponder];
    [self.addrField resignFirstResponder];
    [self.descField resignFirstResponder];
    
    [self.ownerPhoneField resignFirstResponder];
    [self.ownerPwdField resignFirstResponder];
    [self.ownerPwdConfField resignFirstResponder];
    [self.owerNameField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.locationManager startUpdatingLocation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self stopUpdatingLocation];
    [super viewWillDisappear:animated];
}

- (void) stopUpdatingLocation
{
    [self.locationManager stopUpdatingLocation];
}

- (void) showView
{
    pageTabs = @[NSLocalizedString(@"LABEL_SHOP_LICENSE", @"register shop license info"),
                 NSLocalizedString(@"LABEL_SHOP_INFO", @"register shop base info"),
                 @"主营业务",
                 NSLocalizedString(@"LABEL_SHOP_OWNER", @"register shop owner info")];
    
    [geocoder
     reverseGeocodeLocation:self.location completionHandler:^(NSArray *placemarks, NSError *error) {
         if (error == nil &&[placemarks count] > 0){
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSString *state = [placemark.addressDictionary objectForKey:@"State"];
             NSString *street = [placemark.addressDictionary objectForKey:@"Street"];
             NSLog(@"dic State = %@", state);
             NSLog(@"dic Street = %@", street);
             
             self.addrField.text = [NSString stringWithFormat:@"%@ %@", state, street];
         }
     }];
    
    [self reloadData];
}

- (void)registerShop:(id)sender
{
    NSString *name = self.shopNameField.text;
    NSString *addr = self.addrField.text;
    NSString *desc = self.descField.text;
    
    NSString *phone = self.ownerPhoneField.text;
    NSString *ownerName = self.owerNameField.text;
    NSString *pwd = self.ownerPwdField.text;
    NSString *pwdConf = self.ownerPwdConfField.text;
    
    //TODO:进行检查
    if (![pwd isEqualToString:pwdConf]) {
        return;
    }
    
    ZKHShopEntity *shop = [[ZKHShopEntity alloc] init];
           
    shop.shopImg = [[ZKHFileEntity alloc] init];
    shop.shopImg.aliasName = [NSString stringWithFormat:@"%@_shop_img_%@.png", phone, [NSDate currentTimeString]];
    shop.shopImg.fileUrl = [ZKHImageLoader saveImage:self.shopImageView.image fileName:shop.shopImg.aliasName];
    
    shop.busiLicense = [[ZKHFileEntity alloc] init];
    shop.busiLicense.aliasName = [NSString stringWithFormat:@"%@_busi_license_%@.png", phone, [NSDate currentTimeString]];
    shop.busiLicense.fileUrl = [ZKHImageLoader saveImage:self.busiLicenseView.image fileName:shop.busiLicense.aliasName];
    
    shop.name = name;
    shop.addr = addr;
    shop.desc = desc;
    
    //设置店主信息
    if (![[ZKHContext getInstance] isAnonymousUserLogined]) {
        ZKHUserEntity *user = [ZKHContext getInstance].user;
        shop.owner = user.uuid;
    }
    
    ZKHUserEntity *emp = [[ZKHUserEntity alloc] init];
    emp.phone = phone;
    emp.name = ownerName;
    emp.pwd = pwd;
    
    shop.employees = [@[emp] mutableCopy];
    
    //设置位置信息
    ZKHLocationEntity *location = [[ZKHLocationEntity alloc] init];
    location.latitude = [NSString stringWithFormat:@"%g", self.location.coordinate.latitude];
    location.longitude = [NSString stringWithFormat:@"%g", self.location.coordinate.longitude];
    location.radius = [NSString stringWithFormat:@"%d", 0];
    location.addr = @"";////shop.addr;//需处理中文问题
    shop.location = location;
    
    //设置主营业务
    NSMutableArray *shopTrades = [[NSMutableArray alloc] init];
    for (NSNumber *index in selectedTradeIds) {
        ZKHShopTradeEntity *shopTrade = [[ZKHShopTradeEntity alloc] init];
        shopTrade.trade = _trades[[index intValue]];
        [shopTrades addObject:shopTrade];
    }
    shop.trades = shopTrades;
    
    [ApplicationDelegate.zkhProcessor registerShop:shop completionHandler:^(Boolean result) {
        if (result) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [ZKHImageLoader removeImageWithName:shop.shopImg.aliasName];
            [ZKHImageLoader removeImageWithName:shop.busiLicense.aliasName];
        }
    } errorHandler:^(NSError *error) {
        
    }];
}

- (void)addPicViewClick:(UITapGestureRecognizer *)sender
{
    currentImageView = (UIImageView *)sender.view;
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"从图库选择",@"拍照",
                                  nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}

- (void)delPicViewClick:(UITapGestureRecognizer *)sender
{
    int tag = sender.view.tag;
    if (tag == kTagShopImage) {
        self.shopImageView.image = [UIImage imageNamed:@"add_camera.png"];
        self.delShopImageView.hidden = true;
    }else if (tag == kTagBusiLicense){
        self.busiLicenseView.image = [UIImage imageNamed:@"add_camera.png"];
        self.delBusiLicenseView.hidden = true;
    }
}

- (void)tradeSwitchChanged:(UISwitch *)sender
{
    NSNumber *tag = [NSNumber numberWithInt:sender.tag];
    if ([sender isOn]) {
        [selectedTradeIds addObject:tag];
    }else{
        [selectedTradeIds removeObject:tag];
    }
}

#pragma mark - Interface Orientation Changes
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    // Update changes after screen rotates
    [self performSelector:@selector(setNeedsReloadOptions) withObject:nil afterDelay:duration];
}

#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return [pageTabs count];
}

- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14.0];
    label.text = pageTabs[index];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    
    return label;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    switch (index) {
        case 0:
            return self.licenseController;
        case 1:
            return self.baseInfoController;
        case 2:
            return self.tradesController;
        case 3:
            return self.ownerController;
        default:
            return nil;
    }
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
            return 35.0;
//        case ViewPagerOptionTabOffset:
//            return 20.0;
        case ViewPagerOptionTabWidth:
            return UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ? 128.0 : 96.0;
//        case ViewPagerOptionFixFormerTabsPositions:
//            return 1.0;
//        case ViewPagerOptionFixLatterTabsPositions:
//            return 1.0;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_trades count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:switchCellIdentifier];
    ZKHTradeEntity *trade = _trades[indexPath.row];
    cell.cellLabel.text = trade.name;
    
    cell.cellSwitch.tag = indexPath.row;
    [cell.cellSwitch addTarget:self action:@selector(tradeSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - actionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger sourceType;
    switch (buttonIndex) {
        case 0://选择图片
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case 1://拍照
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        default:
            return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - imagePickerController delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedImage = info[UIImagePickerControllerOriginalImage];
    currentImageView.image = selectedImage;
    if (currentImageView.tag == kTagShopImage) {
        self.delShopImageView.hidden = false;
    }else if (currentImageView.tag == kTagBusiLicense){
        self.delBusiLicenseView.hidden = false;
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - locationManager delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    //[self showLocation:newLocation];
    
//    if (newLocation.verticalAccuracy < 0 || newLocation.horizontalAccuracy < 0) {
//        return;
//    }
//    if (newLocation.verticalAccuracy > 100 || newLocation.horizontalAccuracy > 500) {
//        return;
//    }
    
    if (!self.location){
        self.location = newLocation;
        [self stopUpdatingLocation];
        [self showView];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ( [error code] == kCLErrorDenied ) {
        [manager stopUpdatingHeading];
    } else if ([error code] == kCLErrorHeadingFailure) {
        
    }
}

//- (void) showLocation:(CLLocation *)location
//{
//    [geocoder
//     reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
//         if (error == nil &&[placemarks count] > 0){
//             CLPlacemark *placemark = [placemarks objectAtIndex:0];
//             /* We received the results */
//             NSLog(@"Country = %@", placemark.country);
//             NSLog(@"Postal Code = %@", placemark.postalCode);
//             NSLog(@"Locality = %@", placemark.locality);
//             NSLog(@"dic = %@", placemark.addressDictionary );
//             NSLog(@"dic FormattedAddressLines= %@", [placemark.addressDictionary objectForKey:@"FormattedAddressLines"]);
//             NSLog(@"dic Name = %@", [placemark.addressDictionary objectForKey:@"Name"]);
//             NSLog(@"dic State = %@", [placemark.addressDictionary objectForKey:@"State"]);
//             NSLog(@"dic Street = %@", [placemark.addressDictionary objectForKey:@"Street"]);
//             NSLog(@"dic SubLocality= %@", [placemark.addressDictionary objectForKey:@"SubLocality"]);
//             NSLog(@"dic SubThoroughfare= %@", [placemark.addressDictionary objectForKey:@"SubThoroughfare"]);
//             NSLog(@"dic Thoroughfare = %@", [placemark.addressDictionary objectForKey:@"Thoroughfare"]);
//             
//             
//         }
//         else if (error == nil &&
//                  [placemarks count] == 0){
//             NSLog(@"No results were returned.");
//         }
//         else if (error != nil){
//             NSLog(@"An error occurred = %@", error);
//         }
//     }];
//}
@end
