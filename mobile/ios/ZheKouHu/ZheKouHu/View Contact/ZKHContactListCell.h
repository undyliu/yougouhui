//
//  ZKHContactListCell.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-27.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZKHSwitch;
@interface ZKHContactListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet ZKHSwitch *cellSwitch;

@end

@interface ZKHSwitch : UISwitch
@property (nonatomic) NSIndexPath *indexPath;
@end