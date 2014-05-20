//
//  ZKHModuleListController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-19.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKHModuleListController : UITableViewController

@property (strong, nonatomic) NSMutableArray *modules;

- (NSString *) getModuleType;

@end

@interface ZKHDiscoverListController : ZKHModuleListController

@end

@interface ZKHProfileListController : ZKHModuleListController

@end
