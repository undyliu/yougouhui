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
    UINib *nib = [UINib nibWithNibName:@"ZKHImageLabelCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
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
                
                cell.valueLabel.text = trades;
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
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

@end
