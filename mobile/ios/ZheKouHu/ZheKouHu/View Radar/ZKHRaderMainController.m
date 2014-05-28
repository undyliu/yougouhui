//
//  ZKHRaderMainController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-22.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHRaderMainController.h"
#import "ZKHRadarSettingController.h"
#import "ZKHContext.h"
#import "ZKHRadarScanController.h"

@implementation ZKHRaderMainController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (![[ZKHContext getInstance] isAnonymousUserLogined]) {
        UIBarButtonItem *settingButton = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(radarSetting:)];
        self.navigationItem.rightBarButtonItem = settingButton;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)radarSetting:(id)sender
{
    [self.navigationController pushViewController:[[ZKHRadarSettingController alloc] init] animated:YES];
}

- (IBAction)radarScan:(id)sender {
    ZKHRadarScanController *controller = [[ZKHRadarScanController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
