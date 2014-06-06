//
//  ZKHShopSaleListCell.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-6.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHShopSaleListCell.h"
#import "ZKHShopSaleCell.h"
#import "ZKHEntity.h"
#import "ZKHImageLoader.h"
#import "ZKHSaleEditController.h"
#import "ZKHContext.h"
#import "ZKHSaleDetailController.h"

static NSString *SubCellIdentifier = @"ShopSaleCell";

@implementation ZKHShopSaleListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSaleList:(NSMutableArray *)saleList
{
    if (!shopSaleSubItemNib) {
        shopSaleSubItemNib = [UINib nibWithNibName:@"ZKHShopSaleCell" bundle:nil];
    }
    
    _saleList = saleList;
    
    CGRect frame  = self.itemTagView.frame;
    if (itemTableView) {
        itemTableView.frame = frame;
    }else{
        //NSUInteger  l = self.publishDateLabel.text.length;
        CGFloat offsetW  = 10;//self.publishDateLabel.frame.size.width;//why?
        itemTableView = [[UITableView alloc] init];
        itemTableView.frame = CGRectMake(frame.origin.x + offsetW, frame.origin.y, frame.size.width - offsetW, frame.size.height);
        [itemTableView registerNib:shopSaleSubItemNib forCellReuseIdentifier:SubCellIdentifier];
        
        [self addSubview:itemTableView];
        itemTableView.delegate = self;
        itemTableView.dataSource = self;
    }
    
    [itemTableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.saleList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHShopSaleCell *cell = [tableView dequeueReusableCellWithIdentifier:SubCellIdentifier forIndexPath:indexPath];
    
    ZKHSaleEntity *sale = self.saleList[indexPath.row];
    cell.titleLabel.text = sale.title;
    
    NSString *status = sale.status;
    if ([status isEqualToString:@"1"]) {
        cell.statusLabel.text = @"已审核";
    }else if ([status isEqualToString:@"2"]) {
        cell.statusLabel.text = @"已作废";
    }else{
        cell.statusLabel.hidden = true;
    }
    
    cell.contentLabel.text = sale.content;
    cell.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.contentLabel.numberOfLines = 0;
    
    cell.countLabel.text = [NSString stringWithFormat:@"共%@位浏览 %@条评论", sale.visitCount, sale.discussCount];
    
    [ZKHImageLoader showImageForName:sale.img imageView:cell.saleImageView];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHSaleEntity *sale = self.saleList[indexPath.row];
    Boolean shopLogined = [ZKHContext getInstance].shopLogined;
    ZKHUserEntity *user = [ZKHContext getInstance].user;
    if (shopLogined && ([self.shop.owner isEqualToString:user.uuid] || [sale.publisher.uuid isEqualToString:user.uuid])) {
        ZKHSaleEditController *controller = [[ZKHSaleEditController alloc] init];
        controller.sale = sale;
        [self.parentController.navigationController pushViewController:controller animated:YES];
    }else{
        ZKHSaleDetailController *controller = [[ZKHSaleDetailController alloc] init];
        controller.sale = sale;
        [self.parentController.navigationController pushViewController:controller animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0;
}

@end
