//
//  ZKHAddFriendController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-27.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZKHAddFriendResultController;
@interface ZKHAddFriendController : UIViewController
{
    ZKHAddFriendResultController * resultController;
}

@property (weak, nonatomic) IBOutlet UITextField *searchWordField;
@property (weak, nonatomic) IBOutlet UITableView *resultTableVIew;

- (IBAction)doSearch:(id *)sender;
- (IBAction)backgroupTap:(id)sender;

@end

@interface ZKHAddFriendResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *cellActionButton;

@end

@interface ZKHAddFriendResultController : NSObject<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *result;
@property (strong, nonatomic) UINavigationController *navController;

- (IBAction)addFriend:(UIButton *)sender;
@end