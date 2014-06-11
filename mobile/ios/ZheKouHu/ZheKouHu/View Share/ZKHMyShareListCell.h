//
//  ZKHMyShareListCell.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-11.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKHMyShareListCell : UITableViewCell<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *publishDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (strong, nonatomic) UITableView *subTableView;

@property (strong, nonatomic) NSMutableArray *shareList;
@property (strong, nonatomic) UIViewController *parentController;

+ (CGFloat) cellHeight:(NSMutableArray *)shares;

- (void) updateViews:(NSMutableArray *)shares;

@end
