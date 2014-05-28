//
//  ZKHRadarSettingViewController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-22.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHRadarSettingController.h"
#import "ZKHSwitchCell.h"
#import "ZKHAppDelegate.h"
#import "ZKHProcessor+Setting.h"
#import "ZKHConst.h"
#import "ZKHContext.h"
#import "NSString+Utils.h"

static NSString *switchCellIdentifier = @"SwitchCell";
static NSString *pickerCellIdentifier = @"PickerCell";

@implementation ZKHRadarSettingController

- (id)init
{
    if (self = [super init]) {
        [[NSBundle mainBundle] loadNibNamed:@"ZKHGroupedTableView" owner:self options:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveRadarConf:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    UINib *nib = [UINib nibWithNibName:@"ZKHSwitchCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:switchCellIdentifier];
    
    UINib *nib2 = [UINib nibWithNibName:@"ZKHPickerCell" bundle:nil];
    [self.tableView registerNib:nib2 forCellReuseIdentifier:pickerCellIdentifier];
    
    if (self.radarSetting == nil) {
        [ApplicationDelegate.zkhProcessor setting:SETTING_CODE_RADAR userId:[ZKHContext getInstance].user.uuid completionHandler:^(ZKHSettingEntity *setting) {
            if (setting) {
                self.radarSetting = setting;
                [self checkAndinitializeSettingValue];
                [self.tableView reloadData];
            }
        } errorHandler:^(NSError *error) {
            
        }];
    }else{
        [self checkAndinitializeSettingValue];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)checkAndinitializeSettingValue
{
    NSString *value = self.radarSetting.value;
    if ([value isNull]) {
        NSDictionary *tmp = @{RADAR_VAL_FIELD_DISTANCE: @"2000", RADAR_VAL_FIELD_SALE : @"true", RADAR_VAL_FIELD_SHOP: @"true" };
        self.radarSetting.value = [NSString stringWithJSONObject:tmp];
    }
}

- (void)saveRadarConf:(id)sender
{
    NSMutableDictionary *value = [[self.radarSetting.value toJSONObject] mutableCopy];
    [value setObject:[saleSwitch isOn]? @"true" : @"false" forKey:RADAR_VAL_FIELD_SALE];
    [value setObject:[shopSwitch isOn]? @"true" : @"false" forKey:RADAR_VAL_FIELD_SHOP];
    [value setObject:[NSString stringWithFormat:@"%d", [distancePicker selectedRowInComponent:0]] forKey:RADAR_VAL_FIELD_DISTANCE];
    self.radarSetting.value = [NSString stringWithJSONObject:value];
    
    [ApplicationDelegate.zkhProcessor saveSetting:self.radarSetting completionHandler:^(Boolean result) {
        
    } errorHandler:^(NSError *error) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 2 : 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return  section == 0 ? @"扫描目标" : @"扫描范围（米）";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *value = [self.radarSetting.value toJSONObject];
    if (indexPath.section == 0) {
        ZKHSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:switchCellIdentifier];
        if (indexPath.row == 0) {
            cell.cellLabel.text = @"活动";
            saleSwitch = cell.cellSwitch;
            if ([[value valueForKey:RADAR_VAL_FIELD_SALE] isTrue]) {
                [saleSwitch setOn:TRUE];
            }else{
                [saleSwitch setOn:FALSE];
            }
        }else{
            cell.cellLabel.text = @"商铺";
            shopSwitch = cell.cellSwitch;
            if ([[value valueForKey:RADAR_VAL_FIELD_SHOP] isTrue]) {
                [shopSwitch setOn:TRUE];
            }else{
                [shopSwitch setOn:FALSE];
            }
        }
        return cell;
    }else{
        ZHKPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:pickerCellIdentifier];
        cell.distancePicker.dataSource = self;
        cell.distancePicker.delegate = self;
        if (distancePicker == nil) {
            distancePicker = cell.distancePicker;
        }
        NSString *distance = [value valueForKey:RADAR_VAL_FIELD_DISTANCE];
        [distancePicker selectRow:[distance intValue] inComponent:0 animated:NO];
        return cell;
    }
 
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%d", row];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 10000;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 44 : 220;
}

@end


@implementation ZHKPickerCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];
    
}
@end