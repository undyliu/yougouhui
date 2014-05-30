//
//  ZKHShareController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-30.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHEntity.h"
#import "ZKHTextView.h"

@interface ZKHShareController : UIViewController

@property (strong, nonatomic) ZKHShopEntity *shop;
@property (weak, nonatomic) IBOutlet ZKHTextView *contentField;
@property (weak, nonatomic) IBOutlet UITextField *shopField;
@property (weak, nonatomic) IBOutlet UIButton *scanShopButton;

@property (weak, nonatomic) IBOutlet UISwitch *friendSeeSwitch;
@property (weak, nonatomic) IBOutlet UIImageView *addImageView;
@end
