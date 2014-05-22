//
//  ZKHChannelSaleMainController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-19.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHChannelSaleListController.h"

@interface ZKHChannelSaleMainController : UIViewController

@property (strong, nonatomic) NSMutableArray *channels;
@property (strong, nonatomic) ZKHChannelSaleListController *saleListController;

@property (weak, nonatomic) IBOutlet UIToolbar *channelBar;
- (IBAction)changeChannel:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UITableView *saleListView;

@end
