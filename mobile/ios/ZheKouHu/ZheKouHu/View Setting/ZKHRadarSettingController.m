//
//  ZKHRadarSettingViewController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-22.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHRadarSettingController.h"
#import "ZKHSwitchCell.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)saveRadarConf:(id)sender
{
    
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

    if (indexPath.section == 0) {
        ZKHSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:switchCellIdentifier];
        if (indexPath.row == 0) {
            cell.cellLabel.text = @"活动";
            saleSwitch = cell.cellSwitch;
        }else{
            cell.cellLabel.text = @"商铺";
            shopSwitch = cell.cellSwitch;
        }
        return cell;
    }else{
        ZHKPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:pickerCellIdentifier];
        cell.distancePicker.dataSource = self;
        cell.distancePicker.delegate = self;
        if (distancePicker == nil) {
            distancePicker = cell.distancePicker;
            [distancePicker selectRow:2000 inComponent:0 animated:NO];
        }
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