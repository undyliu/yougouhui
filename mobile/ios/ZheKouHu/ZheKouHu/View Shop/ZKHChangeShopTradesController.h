//
//  ZKHShopTradesController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-26.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHEntity.h"

@interface ZKHChangeShopTradesController : UITableViewController
{
    NSMutableArray* _trades;
    NSMutableArray* switches;
}

@property (strong, nonatomic) ZKHShopEntity *shop;

- (IBAction)save:(id)sender;

@end
