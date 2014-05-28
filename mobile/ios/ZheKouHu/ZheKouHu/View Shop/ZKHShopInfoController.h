//
//  ZKHShopInfoController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-22.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHEntity.h"
#import "ZKHTableViewController.h"
#import "ZKHChangeTextController.h"
#import "ZKHChangePwdController.h"
#import "ZKHChangeImgController.h"

@interface ZKHShopInfoController : ZKHTableViewController

@property (strong, nonatomic) ZKHShopEntity *shop;
@property (nonatomic) Boolean readonly;

@end

@interface ZKHChangeShopNameController : ZKHChangeTextController
@property (strong, nonatomic) ZKHShopEntity *shop;
@end

@interface ZKHChangeShopDescController : ZKHChangeTextController
@property (strong, nonatomic) ZKHShopEntity *shop;
@end

@interface ZKHChangeShopImageController :  ZKHChangeImgController
@property (strong, nonatomic) ZKHShopEntity *shop;
@end

@interface ZKHChangeBusiLicenseController :  ZKHChangeImgController
@property (strong, nonatomic) ZKHShopEntity *shop;
@end
