//
//  ZKHModuleListController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-19.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHModuleListController.h"
#import "ZKHEntity.h"
#import "ZKHSettingsController.h"
#import "ZKHAppDelegate.h"

#define kModuleFriends @"friends"
#define kModuleSettings @"settings"

static NSString *CellIdentifier = @"Cell";

@interface ZKHModuleListController ()

@end

@implementation ZKHModuleListController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    NSString *type = [self getModuleType];
    if(type != nil){
        [ApplicationDelegate.zkhProcessor modulesForType:type
                               completionHandler:^(NSMutableArray *modules) {
                                   self.modules = modules;
                                   [self.tableView reloadData];
                               }
                                    errorHandler:^(NSError *error) {
                                        
                                    }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSString *)getModuleType
{
    return nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.modules count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    ZKHModuleEntity *module = self.modules[indexPath.row];
    cell.textLabel.text = module.name;
    if (module.icon != nil && [module.icon length] > 0) {
        cell.imageView.image = [UIImage imageNamed:module.icon];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"default_pic.png"];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHModuleEntity *module = self.modules[indexPath.row];
    NSString *code = module.code;
    if ([code isEqualToString:kModuleFriends]) {
        ;
    }else if([code isEqualToString:kModuleSettings]){
        ZKHSettingsController *controller = [[ZKHSettingsController alloc] init];
        controller.title = module.name;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end


@implementation ZKHDiscoverListController
- (NSString *)getModuleType
{
    return @"discover";
}
@end

@implementation ZKHProfileListController
- (NSString *)getModuleType
{
    return @"me";
}
@end

