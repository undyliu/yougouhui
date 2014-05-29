//
//  ZKHRadarSettingViewController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-22.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHEntity.h"

@interface ZKHRadarSettingController : UITableViewController<UIPickerViewDelegate, UIPickerViewDataSource>
{
    UISwitch *saleSwitch;
    UISwitch *shopSwitch;
    UIPickerView *distancePicker;
}
@property (strong, nonatomic) ZKHSettingEntity *radarSetting;

- (IBAction)saveRadarConf:(id)sender;

@end

@interface ZHKPickerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIPickerView *distancePicker;

@end