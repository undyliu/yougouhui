//
//  ZKHMyShareListController.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-11.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHMyShareListController.h"
#import "ZKHEntity.h"
#import "NSDate+Utils.h"
#import "ZKHProcessor+Share.h"
#import "ZKHAppDelegate.h"
#import "ZKHContext.h"
#import "ZKHMyShareListCell.h"
#import "ZKHShareController.h"

static NSString *CellIdentifier = @"MyShareListCell";

@implementation ZKHMyShareListController

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

    self.title = @"我的分享";
    
    self.pullTableView.dataSource = self;
    self.pullTableView.pullDelegate = self;
    self.pullTableView.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:@"ZKHMyShareListCell" bundle:nil];
    [self.pullTableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    if (![[ZKHContext getInstance] isAnonymousUserLogined]) {
        UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(shareClick:)];
        self.navigationItem.rightBarButtonItem = shareButton;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [ApplicationDelegate.zkhProcessor sharesGroupByPublishDate:nil userId:[ZKHContext getInstance].user.uuid offset:offset completionHandler:^(NSMutableArray *shares) {
        shareCountList = shares;
        [self.pullTableView reloadData];
    } ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)shareClick:(id)sender
{
    ZKHShareController *controller = [[ZKHShareController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [shareCountList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZKHMyShareListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    ZKHDateIndexedEntity *entity = shareCountList[indexPath.row];
    cell.publishDateLabel.text = [entity.date toddMMString];
    cell.countLabel.text = [NSString stringWithFormat:@"%d笔", entity.count];
    
    cell.parentController = self;
    
    [cell updateViews:entity.items];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZKHDateIndexedEntity *entity = shareCountList[indexPath.row];
    return [ZKHMyShareListCell cellHeight:entity.items];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.pullTableView reloadData];
}

#pragma mark - share changed delegate

- (void)shareDeleted:(ZKHShareEntity *)share
{
    for (ZKHDateIndexedEntity *entity in shareCountList) {
        for (ZKHShareEntity *iShare in entity.items) {
            if ([share isEqual:iShare]) {
                [entity.items removeObject:iShare];
                entity.count = entity.count - 1;
                
                if (entity.count == 0) {
                    [shareCountList removeObject:entity];
                }
                return;
            }
        }
    }
}

@end

