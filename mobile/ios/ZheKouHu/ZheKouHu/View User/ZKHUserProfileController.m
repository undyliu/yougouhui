//
//  ZKHUserProfileController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-22.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHUserProfileController.h"
#import "ZKHImageLabelCell.h"
#import "ZKHEntity.h"
#import "ZKHContext.h"
#import "ZKHImageLoader.h"
#import "ZKHAppDelegate.h"
#import "ZKHProcessor+User.h"
#import "ZKHImageLoader.h"
#import "NSDate+Utils.h"
#import "ZKHProcessor+User.h"
#import "ZKHViewUtils.h"

static NSString *CellIdentifier = @"ImageLabelCell";

@implementation ZKHUserProfileController

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
    
    self.title = @"个人信息";
    
    UINib *nib = [UINib nibWithNibName:@"ZKHImageLabelCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    [ZKHViewUtils setTableViewExtraCellLineHidden:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHUserEntity *user = [ZKHContext getInstance].user;
    ZKHImageLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    int row = indexPath.row;
    switch (row) {
        case 0:
        {
            cell.nameLabel.text = @"头像";
            NSString *photo = user.photo.aliasName;
            if ([photo length] > 0) {
                [ZKHImageLoader showImageForName:photo imageView:cell.photoView];
            }else{
                cell.photoView.image = [UIImage imageNamed:@"default_user_photo.png"];
            }
            cell.photoView.hidden = false;
            cell.valueLabel.hidden = true;
        }
            break;
        case 1:
            cell.nameLabel.text = @"手机号";
            cell.imageView.hidden = true;
            cell.valueLabel.hidden = false;
            cell.valueLabel.text = user.phone;
            break;
        case 2:
            cell.nameLabel.text = @"昵称";
            cell.imageView.hidden = true;
            cell.valueLabel.hidden = false;
            cell.valueLabel.text = user.name;
            break;
        case 3:
            cell.nameLabel.text = @"密码";
            cell.imageView.hidden = true;
            cell.valueLabel.hidden = false;
            cell.valueLabel.text = @"......";
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[ZKHContext getInstance] isAnonymousUserLogined]) {//匿名用户不允许修改
        return;
    }
    
    UIViewController *controller;
    switch (indexPath.row) {
        case 0:
            controller = [[ZKHChangeUserPhotoController alloc] init];
            break;
        case 2:
            controller = [[ZKHChangeUserNameController alloc] init];
            break;
        case 3:
            controller = [[ZKHChangeUserPwdController alloc] init];
        default:
            break;
    }
    
    if (controller != nil) {
        [self.navigationController pushViewController:controller animated:YES];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}
@end


@implementation ZKHChangeUserNameController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"修改昵称";
}

- (NSString *)getOriginalTextFieldValue
{
    return [ZKHContext getInstance].user.name;
}

- (void)doSave:(NSString *)newValue
{
    ZKHUserEntity *user = [ZKHContext getInstance].user;
    [ApplicationDelegate.zkhProcessor changeUserName:user newName:newValue completionHandler:^(Boolean result) {
        if (result) {
            user.name = newValue;
            [self.navigationController popViewControllerAnimated:YES];
        }
    } errorHandler:^(ZKHErrorEntity *error) {
        
    }];
}

@end


@implementation ZKHChangeUserPwdController

- (NSString *) getOriginalPwd{
    return [ZKHContext getInstance].user.pwd;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.itemValueLabel.text = [ZKHContext getInstance].user.name;
}

- (void)doSave:(NSString *)newPwd
{
    ZKHUserEntity *user = [ZKHContext getInstance].user;
    [ApplicationDelegate.zkhProcessor changeUserPwd:user newPwd:newPwd completionHander:^(Boolean result) {
        if (result) {
            user.pwd = newPwd;
            [self.navigationController popViewControllerAnimated:YES];
        }
    } errorHandler:^(ZKHErrorEntity *error) {
        
    }];
}

@end

@implementation ZKHChangeUserPhotoController

- (ZKHFileEntity *)getOriginalImageFile
{
    return [ZKHContext getInstance].user.photo;
}

- (void)save:(id)sender
{
    ZKHUserEntity *user = [ZKHContext getInstance].user;
    UIImage *image = self.imageView.image;
    NSString *aliasName = [NSString stringWithFormat:@"%@_%@.png", user.phone, [NSDate currentTimeString]];
    NSString *filePath = [ZKHImageLoader saveImage:image fileName:aliasName];
    
    ZKHFileEntity *file = [[ZKHFileEntity alloc] init];
    file.aliasName = aliasName;
    file.fileUrl = filePath;
    
    [ApplicationDelegate.zkhProcessor changeUserPhoto:user newPhoto:file completionHander:^(Boolean result) {
        if (result) {
            [ZKHImageLoader removeImageWithName:user.photo.aliasName];//删除原有的照片
            user.photo = file;
            [self.navigationController popViewControllerAnimated:YES];
        }
    } errorHandler:^(ZKHErrorEntity *error) {
        [ZKHImageLoader removeImageWithName:aliasName];
    }];
}
@end
