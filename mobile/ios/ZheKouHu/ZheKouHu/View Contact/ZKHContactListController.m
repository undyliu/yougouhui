//
//  ZKHContactListController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-27.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHContactListController.h"
#import "ZKHEntity.h"
#import "ZKHContext.h"
#import "ZKHContactListCell.h"
#import "ZKHImageLoader.h"
#import "ZKHAppDelegate.h"
#import "ZKHProcessor+User.h"
#import "ZKHAddFriendController.h"

static NSString *CellIdentifier = @"ContactListCell";

@interface ZKHContactListController ()

@end

@implementation ZKHContactListController

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
    
    self.title = @"通讯录";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"ZKHContactListCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    ZKHUserEntity *user = [ZKHContext getInstance].user;
    NSMutableArray *friends = user.friends;
    if ([friends count] > 0) {
        [self initializeData:friends];
    }else{
        [ApplicationDelegate.zkhProcessor friends:user.uuid completionHandler:^(NSMutableArray *friends) {
            [self initializeData:friends];
            [self.tableView reloadData];
        } errorHandler:^(NSError *error) {
            [self initializeData:nil];
            [self.tableView reloadData];
        }];
    }
    
    UIBarButtonItem *addFriendButton = [[UIBarButtonItem alloc] initWithTitle:@"添加新朋友" style:UIBarButtonItemStyleDone target:self action:@selector(addFriendClick:)];
    self.navigationItem.rightBarButtonItem = addFriendButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) initializeData:(NSMutableArray *)data
{
    _indexKeys = @[@"@", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M"
            , @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", @"#"];
    _friends = [[NSMutableDictionary alloc] init];
    
    ZKHUserEntity *user = [[ZKHUserEntity alloc] init];
    user.name = @"服务号";
    user.phone = @"-999";
    user.photo = [[ZKHFileEntity alloc] init];
    user.photo.aliasName = @"receptionist.png";
    
    [_friends setObject:@[user] forKey:@"@"];
    
    for (ZKHUserFriendsEntity *userFriend in data) {
        ZKHUserEntity *user = userFriend.friend;
        NSString *yinpinName = user.pinyinName;
        NSString *key = [yinpinName substringToIndex:1];
        
        NSMutableArray *values = _friends[key];
        if (values == nil) {
            values = [[NSMutableArray alloc] init];
        }
        
        [values addObject:user];
        
        [_friends setObject:values forKey:key];
    }
}

- (void)addFriendClick:(id)sender
{
    ZKHAddFriendController *controller = [[ZKHAddFriendController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_friends count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [_friends allKeys][section];
    return [_friends[key] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHContactListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    NSString *key = [_friends allKeys][indexPath.section];
    ZKHUserEntity *friend = _friends[key][indexPath.row];
    
    cell.cellLabel.text = friend.name;
    ZKHFileEntity *photo = friend.photo;
    
    if ([@"-999" isEqualToString:friend.phone]) {
        cell.cellImageView.image = [UIImage imageNamed:photo.aliasName];
    }else{
        if (photo == nil || photo.aliasName == nil) {
            cell.cellImageView.image = [UIImage imageNamed:@"default_user_photo.png"];
        }else{
            [ZKHImageLoader showImageForName:photo.aliasName imageView:cell.cellImageView];
        }
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_friends allKeys][section];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _indexKeys;
}

@end
