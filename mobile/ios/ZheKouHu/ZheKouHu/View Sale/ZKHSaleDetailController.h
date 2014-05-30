//
//  ZKHSaleDetailController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-29.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHEntity.h"
#import "ZKHSaleDiscussListController.h"

@interface ZKHSaleDetailController : UIViewController
{
    ZKHSaleDiscussListController *discussListController;
    UIBarButtonItem *shareItem;
    UIBarButtonItem *favoritItem;
    UIBarButtonItem *cancelFavoritItem;
    UIToolbar *navToolbar;
}

@property (strong, nonatomic) ZKHSaleEntity *sale;

@property (weak, nonatomic) IBOutlet UIImageView *saleImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *discusslabel;
@property (weak, nonatomic) IBOutlet UIImageView *disImageView;
@property (weak, nonatomic) IBOutlet PullTableView *disTableView;

- (IBAction)shopLabelClick:(id)sender;
- (IBAction)discussLabelClick:(id)sender;
- (IBAction)imagePreview:(id)sender;
- (IBAction)favoritClick:(id)sender;
- (IBAction)cancelFavoritClick:(id)sender;
- (IBAction)shareClick:(id)sender;

@end
