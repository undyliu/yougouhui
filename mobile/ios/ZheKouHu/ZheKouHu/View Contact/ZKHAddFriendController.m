//
//  ZKHAddFriendController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-27.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHAddFriendController.h"
#import "ZKHAppDelegate.h"
#import "ZKHProcessor+User.h"
#import "ZKHImageLoader.h"
#import "ZKHContext.h"
#import "ZKHFriendProfileController.h"
#import "NSString+Utils.h"
#import "ZKHViewUtils.h"

static NSString *CellIdentifier = @"AddFriendResultCell";

@implementation ZKHAddFriendController

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
    
    self.title = @"添加新朋友";
    [self.searchWordField becomeFirstResponder];
    
    UINib *nib = [UINib nibWithNibName:@"ZKHAddFriendResultCell" bundle:nil];
    [self.resultTableVIew registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    [ZKHViewUtils setTableViewExtraCellLineHidden:self.resultTableVIew];
    
    resultController = [[ZKHAddFriendResultController alloc] init];
    resultController.navController = self.navigationController;
    self.resultTableVIew.delegate = resultController;
    self.resultTableVIew.dataSource = resultController;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.resultTableVIew reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)backgroupTap:(id)sender
{
    [self.searchWordField resignFirstResponder];
}

- (IBAction)doSearch:(id *)sender {
    [self backgroupTap:nil];
    NSString *searchWord = self.searchWordField.text;
    if ([searchWord length] == 0) {
        return;
    }
    
    [ApplicationDelegate.zkhProcessor searchUsers:searchWord completionHandler:^(NSMutableArray *friends) {
        resultController.result = friends;
        [self.resultTableVIew reloadData];
    } errorHandler:^(NSError *error) {
        
    }];
}

@end

@implementation ZKHAddFriendResultCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

@implementation ZKHAddFriendResultController

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.result count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHAddFriendResultCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    ZKHUserEntity *user = self.result[indexPath.row];
    cell.cellNameLabel.text = user.name;
    
    ZKHFileEntity *photo = user.photo;
    if (photo == nil || [NSString isNull:photo.aliasName]) {
        cell.cellImageView.image = [UIImage imageNamed:@"default_user_photo.png"];
    }else{
        [ZKHImageLoader showImageForName:photo.aliasName imageView:cell.cellImageView];
    }
    
    if([[ZKHContext getInstance].user.friends containsObject:user]){
        [cell.cellActionButton setTitle:@"已是朋友" forState:UIControlStateNormal];
        cell.cellActionButton.enabled = false;
    }else{
        [cell.cellActionButton setTitle:@"加为朋友" forState:UIControlStateNormal];
        cell.cellActionButton.enabled = true;
        cell.cellActionButton.tag = indexPath.row;
        [cell.cellActionButton addTarget:self action:@selector(addFriend:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZKHFriendProfileController *controller = [[ZKHFriendProfileController alloc] init];
    controller.user = self.result[indexPath.row];
    [self.navController pushViewController:controller animated:YES];
    
}

- (void)addFriend:(UIButton *)sender
{
    int index = sender.tag;
    ZKHUserEntity *friend = self.result[index];
    
    [ApplicationDelegate.zkhProcessor addFriend:[ZKHContext getInstance].user uFriend:friend completionHander:^(Boolean result) {
        if (result) {
            [sender setTitle:@"已是朋友" forState:UIControlStateNormal];
            sender.enabled =false;
        }
    } errorHandler:^(NSError *error) {
        
    }];
}
@end