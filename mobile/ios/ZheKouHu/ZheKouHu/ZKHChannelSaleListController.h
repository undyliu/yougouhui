//
//  ZKHChannelSaleListController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-19.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHEntity.h"

@interface ZKHChannelSaleListController : UITableViewController
@property (strong, nonatomic) ZKHChannelEntity *channel;
@property (strong, nonatomic) NSArray *saleList;
@end
