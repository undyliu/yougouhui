//
//  ZKHChooseShopController.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-3.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHChooseShopActionDelegate.h"

@interface ZKHChooseShopController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *result;
    NSIndexPath *selectedIndexPath;
}
@property (strong, nonatomic) id<ZKHChooseShopActionDelegate> actionDelegate;

@property (weak, nonatomic) IBOutlet UITextField *searchWordField;
@property (weak, nonatomic) IBOutlet UITableView *resultView;

- (IBAction)search:(id)sender;

- (IBAction)confButtonClick:(id)sender;
- (IBAction)cellSwitchChanged:(id)sender;
@end
