//
//  ZKHSaleEditController.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-6.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHEntity.h"
#import "ZKHSaleDiscussListController.h"

@interface ZKHSaleEditController : UIViewController
{
    UIBarButtonItem *cancelButton;
    ZKHSaleDiscussListController *discussListController;    
}

@property (strong, nonatomic) ZKHSaleEntity *sale;

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *contentField;
@property (weak, nonatomic) IBOutlet UITextField *startDateField;
@property (weak, nonatomic) IBOutlet UITextField *endDateField;
@property (weak, nonatomic) IBOutlet UIView *tradeView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIImageView *disImageView;
@property (weak, nonatomic) IBOutlet PullTableView *disTableView;

- (IBAction)showSaleImages:(id)sender;

- (IBAction)cancelClick:(id)sender;
@end
