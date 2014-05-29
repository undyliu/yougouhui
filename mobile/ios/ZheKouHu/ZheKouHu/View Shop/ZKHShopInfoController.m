//
//  ZKHShopInfoController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-22.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHShopInfoController.h"
#import "ZKHImageLabelCell.h"
#import "ZKHImageLoader.h"
#import "ZKHChangeShopPwdController.h"
#import "ZKHChangeShopTradesController.h"
#import "ZKHAppDelegate.h"
#import "ZKHProcessor+Shop.h"
#import "NSDate+Utils.h"
#import "ZKHContext.h"
#import "ZKHViewUtils.h"

static NSString *CellIdentifier = @"ImageLabelCell";

@implementation ZKHShopInfoController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"店铺-基本信息";
    self.readonly = true;
    
    UINib *nib = [UINib nibWithNibName:@"ZKHImageLabelCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    [ZKHViewUtils setTableViewExtraCellLineHidden:self.tableView];
    
    [ApplicationDelegate.zkhProcessor checkShopEmp:self.shop.uuid userId:[ZKHContext getInstance].user.uuid completionHandler:^(Boolean result) {
        if (result) {
            self.readonly = false;
        }
    } errorHandler:^(NSError *error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHImageLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    int row = indexPath.row;
    switch (row) {
        case 0:
            cell.nameLabel.text = @"商铺名称";
            cell.valueLabel.text = self.shop.name;
            cell.photoView.hidden = true;
            cell.valueLabel.hidden = false;
            break;
        case 1:
        {
            cell.nameLabel.text = @"店面图片";
            cell.valueLabel.hidden = true;
            cell.photoView.hidden = false;
            NSString *shopImg = self.shop.shopImg;
            if ([shopImg length] > 0) {
                [ZKHImageLoader showImageForName:shopImg imageView:cell.photoView];
            }else{
                cell.photoView.image = [UIImage imageNamed:@"default_pic.png"];
            }
        }
            break;
        case 2:
            cell.nameLabel.text = @"地址";
            cell.valueLabel.text = self.shop.addr;
            cell.photoView.hidden = true;
            cell.valueLabel.hidden = false;
            break;
        case 3:
            {
                cell.nameLabel.text = @"主营业务";
                NSMutableString *trades = [NSMutableString stringWithCapacity:50];
                for (ZKHShopTradeEntity *shopTrade in self.shop.trades) {
                    [trades appendFormat:@"%@, ", shopTrade.trade.name];
                }
                
                cell.valueLabel.text = [trades substringToIndex:([trades length] - 2)];
                cell.photoView.hidden = true;
                cell.valueLabel.hidden = false;
            }
            break;
        case 4:
        {
            cell.nameLabel.text = @"营业执照";
            cell.valueLabel.hidden = true;
            cell.photoView.hidden = false;
            NSString *busiLicense = self.shop.busiLicense;
            if ([busiLicense length] > 0) {
                [ZKHImageLoader showImageForName:busiLicense imageView:cell.photoView];
            }else{
                cell.photoView.image = [UIImage imageNamed:@"default_pic.png"];
            }
        }
            break;
        case 5:
            cell.nameLabel.text = @"简介";
            cell.valueLabel.text = self.shop.desc;
            cell.photoView.hidden = true;
            cell.valueLabel.hidden = false;
            break;
        case 6:
            cell.nameLabel.text = @"密码";
            cell.valueLabel.text = @"......";
            cell.photoView.hidden = true;
            cell.valueLabel.hidden = false;
            break;
        case 7:
        {
            cell.nameLabel.text = @"二维码";
            cell.valueLabel.hidden = true;
            cell.photoView.hidden = false;
            NSString *barcode = self.shop.barcode;
            if ([barcode length] > 0) {
                [ZKHImageLoader showImageForName:barcode imageView:cell.photoView];
            }else{
                cell.photoView.image = [UIImage imageNamed:@"default_pic.png"];
            }
        }
            break;
        default:
            break;
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.readonly || ![ZKHContext getInstance].shopLogined) {
        return;
    }
    
    UIViewController *controller;
    switch (indexPath.row) {
        case 0:
            controller = [[ZKHChangeShopNameController alloc] init];
            ((ZKHChangeShopNameController *)controller).shop = self.shop;
            break;
        case 1:
            controller = [[ZKHChangeShopImageController alloc] init];
            ((ZKHChangeShopImageController *)controller).shop = self.shop;
            break;
        case 3:
            controller = [[ZKHChangeShopTradesController alloc] init];
            ((ZKHChangeShopTradesController *)controller).shop = self.shop;
            break;
        case 4:
            controller = [[ZKHChangeBusiLicenseController alloc] init];
            ((ZKHChangeBusiLicenseController *)controller).shop = self.shop;
            break;
        case 5:
            controller = [[ZKHChangeShopDescController alloc] init];
            ((ZKHChangeShopDescController *)controller).shop = self.shop;
            break;
        case 6:
            controller = [[ZKHChangeShopPwdController alloc] init];
            ((ZKHChangeShopPwdController *)controller).shop = self.shop;
            break;
        default:
            break;
    }
    
    if (controller != nil) {
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

@end


@implementation ZKHChangeShopNameController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"店铺-修改名称";
}


- (NSString *)getOriginalTextFieldValue
{
    return self.shop.name;
}

- (void)doSave:(NSString *)newValue
{
    [ApplicationDelegate.zkhProcessor changeShopName:self.shop.uuid newName:newValue completionHandler:^(Boolean result) {
        if (result) {
            self.shop.name = newValue;
            [self.navigationController popViewControllerAnimated:YES];
        }
    } errorHandler:^(NSError *error) {
        
    }];
}

@end

@implementation ZKHChangeShopDescController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"店铺-修改简介";
}


- (NSString *)getOriginalTextFieldValue
{
    return self.shop.desc;
}

- (void)doSave:(NSString *)newValue
{
    [ApplicationDelegate.zkhProcessor changeShopDesc:self.shop.uuid newDesc:newValue completionHandler:^(Boolean result) {
        if (result) {
            self.shop.desc = newValue;
            [self.navigationController popViewControllerAnimated:YES];
        }
    } errorHandler:^(NSError *error) {
        
    }];
}
@end

@implementation ZKHChangeShopImageController

- (ZKHFileEntity *)getOriginalImageFile
{
    ZKHFileEntity *imageFile = [[ZKHFileEntity alloc] init];
    imageFile.aliasName = self.shop.shopImg;
    return imageFile;
}

- (void)save:(id)sender
{
    UIImage *image = self.imageView.image;
    NSString *aliasName = [NSString stringWithFormat:@"shopImage_%@.png", [NSDate currentTimeString]];
    NSString *filePath = [ZKHImageLoader saveImage:image fileName:aliasName];
    
    ZKHFileEntity *file = [[ZKHFileEntity alloc] init];
    file.aliasName = aliasName;
    file.fileUrl = filePath;
    
    [ApplicationDelegate.zkhProcessor changeShopImage:self.shop.uuid shopImage:file completionHandler:^(Boolean result) {
        if (result) {
            [ZKHImageLoader removeImageWithName:self.shop.shopImg];//删除原有的照片
            self.shop.shopImg = aliasName;
            [self.navigationController popViewControllerAnimated:YES];
        }
    } errorHandler:^(NSError *error) {
        [ZKHImageLoader removeImageWithName:aliasName];
    }];
}
@end

@implementation ZKHChangeBusiLicenseController
- (ZKHFileEntity *)getOriginalImageFile
{
    ZKHFileEntity *imageFile = [[ZKHFileEntity alloc] init];
    imageFile.aliasName = self.shop.busiLicense;
    return imageFile;
}

- (void)save:(id)sender{
    UIImage *image = self.imageView.image;
    NSString *aliasName = [NSString stringWithFormat:@"busiLicense_%@.png", [NSDate currentTimeString]];
    NSString *filePath = [ZKHImageLoader saveImage:image fileName:aliasName];
    
    ZKHFileEntity *file = [[ZKHFileEntity alloc] init];
    file.aliasName = aliasName;
    file.fileUrl = filePath;
    
    [ApplicationDelegate.zkhProcessor changeBusiLicense:self.shop.uuid busiLicense:file completionHandler:^(Boolean result) {
        if (result) {
            [ZKHImageLoader removeImageWithName:self.shop.busiLicense];//删除原有的照片
            self.shop.busiLicense = aliasName;
            [self.navigationController popViewControllerAnimated:YES];
        }
    } errorHandler:^(NSError *error) {
        [ZKHImageLoader removeImageWithName:aliasName];
    }];
}

@end
