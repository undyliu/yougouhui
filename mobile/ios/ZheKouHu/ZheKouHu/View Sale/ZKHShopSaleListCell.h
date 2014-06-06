//
//  ZKHShopSaleListCell.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-6.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKHShopSaleListCell : UITableViewCell<UITableViewDataSource, UITableViewDelegate>
{
    UINib *shopSaleSubItemNib;
    UITableView *itemTableView;
}

@property (weak, nonatomic) IBOutlet UILabel *publishDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UIView *itemTagView;
//@property (weak, nonatomic) IBOutlet UITableView *itemTableView;

@property (strong, nonatomic) NSMutableArray *saleList;
@property (strong, nonatomic) UIViewController *parentController;

@end
