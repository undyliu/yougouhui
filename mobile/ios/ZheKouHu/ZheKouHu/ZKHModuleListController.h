//
//  ZKHModuleListController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-19.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHTableViewController.h"

@interface ZKHModuleListController : ZKHTableViewController

@property (strong, nonatomic) NSMutableArray *modules;

- (NSString *) getModuleType;

@end

@interface ZKHDiscoverListController : ZKHModuleListController

@end

@interface ZKHProfileListController : ZKHModuleListController

@end

@interface ZKHModuleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *forbiddenLabel;

@end
