//
//  ZKHShopEmpSettingController.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-3.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHEntity.h"
#import "ZKHContactListActionDelegate.h"

@interface ZKHShopEmpSettingController : UITableViewController<ZKHContactListActionDelegate>
{
    NSMutableArray *shopEmps;
    UIToolbar *navToolBar;
}

@property (strong, nonatomic) ZKHShopEntity *shop;

- (IBAction)addFriendClick:(id)sender;

@end

@interface ZKHShopEmpSettingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pwdHitLabel;

@end
