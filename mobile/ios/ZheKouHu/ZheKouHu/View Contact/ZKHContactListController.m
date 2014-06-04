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
#import "ZKHFriendProfileController.h"
#import "NSString+Utils.h"

static NSString *CellIdentifier = @"ContactListCell";

@implementation ZKHContactListController

- (id)init
{
    if (self = [super init]) {
        [[NSBundle mainBundle] loadNibNamed:@"ZKHGroupedTableView" owner:self options:nil];
        selectedIndexes = [[NSMutableArray alloc] init];
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
            user.friends = friends;
            [self initializeData:friends];
            [self.tableView reloadData];
        } errorHandler:^(NSError *error) {
            [self initializeData:nil];
            [self.tableView reloadData];
        }];
    }
    
    [self initializeNavigationItem];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self initializeData:[ZKHContext getInstance].user.friends];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)updateNavToolBarFrame
{
    navToolBar.frame = CGRectMake(0, 0, 90, self.navigationController.navigationBar.frame.size.height + 1);
}

- (void)initializeNavigationItem
{
    if (self.readonly) {
        UIBarButtonItem *addFriendButton = [[UIBarButtonItem alloc] initWithTitle:@"添加新朋友" style:UIBarButtonItemStyleBordered target:self action:@selector(addFriendClick:)];
        self.navigationItem.rightBarButtonItem = addFriendButton;
    }else{
        navToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 90, self.navigationController.navigationBar.frame.size.height + 1)];
    
        [navToolBar setTintColor:[self.navigationController.navigationBar tintColor]];
        [navToolBar setAlpha:[self.navigationController.navigationBar alpha]];
        NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:3];
    
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonClick:)];
        UIBarButtonItem *confButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(confButtonClick:)];
        
        [buttons addObject:addButton];
        [buttons addObject:confButton];
    
        [navToolBar setItems:buttons animated:NO];
    
        UIBarButtonItem *myBtn = [[UIBarButtonItem alloc] initWithCustomView:navToolBar];
        self.navigationItem.rightBarButtonItem = myBtn;
    }
}

- (void) initializeData:(NSMutableArray *)data
{
    _indexKeys = @[@"@", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M"
            , @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", @"#"];
    _friends = [[NSMutableDictionary alloc] init];
        
    for (ZKHUserFriendsEntity *userFriend in data) {
        ZKHUserEntity *user = userFriend.friend;
        
        if (!self.readonly && [self.selectedUsers containsObject:user]) {
            continue;
        }
        
        NSString *yinpinName = user.pinyinName;
        NSString *key = [yinpinName substringToIndex:1];
        
        NSMutableArray *values = _friends[key];
        if (values == nil) {
            values = [[NSMutableArray alloc] init];
        }
        
        [values addObject:[user copy]];
        
        [_friends setObject:[values sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] forKey:key];
    }
    
    //排序处理
    _sortedKeys = [[[_friends allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] mutableCopy];
    
    if (self.readonly) {
        ZKHUserEntity *user = [[ZKHUserEntity alloc] init];
        user.name = @"服务号";
        user.phone = @"-999";
        user.photo = [[ZKHFileEntity alloc] init];
        user.photo.aliasName = @"receptionist.png";
        
        [_friends setObject:@[user] forKey:@"@"];
        
        [_sortedKeys insertObject:@"@" atIndex:0];
    }
    
}

- (Boolean) isReceptionist:(ZKHUserEntity *)user
{
    return [@"-999" isEqualToString:user.phone];
}

- (void)addFriendClick:(id)sender
{
    ZKHAddFriendController *controller = [[ZKHAddFriendController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)addButtonClick:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"搜索新朋友",
                                   nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.navigationController.view];
}

- (void)confButtonClick:(id)sender
{
    NSMutableArray *users = [[NSMutableArray alloc] init];
    for (NSIndexPath *indexPath in selectedIndexes) {
        NSString *key = _sortedKeys[indexPath.section];
        ZKHUserEntity *friend = [_friends[key][indexPath.row] copy];
        friend.pwd = nil;
        [users addObject:friend];
    }
    
    if (self.actionDelegate != nil) {
        [self.actionDelegate confirm:users viewController:self];
    }else{
        [self.selectedUsers addObjectsFromArray:users];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)cellSwitchChanged:(id)sender
{
    ZKHSwitch *cellSwitch = sender;
    NSIndexPath *NSIndexPath = cellSwitch.indexPath;
    if ([cellSwitch isOn]) {
        [selectedIndexes addObject:NSIndexPath];
    }else{
        [selectedIndexes removeObject:NSIndexPath];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0://add friend
            [self addFriendClick:nil];
        default:
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_friends count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = _sortedKeys[section];
    return [_friends[key] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHContactListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    NSString *key = _sortedKeys[indexPath.section];
    ZKHUserEntity *friend = _friends[key][indexPath.row];
    
    cell.cellLabel.text = friend.name;
    ZKHFileEntity *photo = friend.photo;
    
    if ([self isReceptionist:friend]) {
        cell.cellImageView.image = [UIImage imageNamed:photo.aliasName];
    }else{
        if (photo == nil || [NSString isNull:photo.aliasName]) {
            cell.cellImageView.image = [UIImage imageNamed:@"default_user_photo.png"];
        }else{
            [ZKHImageLoader showImageForName:photo.aliasName imageView:cell.cellImageView];
        }
    }
    
    if (self.readonly) {
        cell.cellSwitch.hidden = true;
    }else{
        cell.cellSwitch.hidden = false;
        cell.cellSwitch.indexPath = indexPath;
        [cell.cellSwitch addTarget:self action:@selector(cellSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sortedKeys[section];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = _sortedKeys[indexPath.section];
    ZKHUserEntity *friend = _friends[key][indexPath.row];
    
    if ([self isReceptionist:friend]) {
        
    }else{
        ZKHFriendProfileController *controller = [[ZKHFriendProfileController alloc] init];
        controller.user = friend;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _indexKeys;
}

@end
