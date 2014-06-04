//
//  ZKHChooseShopActionDelegate.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-3.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZKHEntity.h"

@protocol ZKHChooseShopActionDelegate <NSObject>

- (void)confirm:(ZKHShopEntity *)shop viewController:(UIViewController *)viewController;

@end
