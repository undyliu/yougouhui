//
//  ZKHMyShareListCell.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-11.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHMyShareListCell.h"
#import "ZKHMyShareCell.h"
#import "ZKHEntity.h"
#import "ZKHFriendShareListController.h"

static NSString *SubCellIdentifier = @"MyShareCell";

@implementation ZKHMyShareListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeight:(NSMutableArray *)shares
{
    CGFloat height = 0;
    for (ZKHShareEntity *share in shares) {
        height += [ZKHMyShareCell cellHeight:share];
    }
    return height;
}

+ (CGFloat) cellRightWidth
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (currentOrientation == UIInterfaceOrientationPortrait || currentOrientation == UIInterfaceOrientationPortraitUpsideDown){//竖屏
        return screenBounds.size.width - 70;
    }else{
        return screenBounds.size.height - 70;
    }
}

- (void)updateViews:(NSMutableArray *)shares
{
    self.shareList = shares;
    if (!self.subTableView) {
        self.subTableView = [[UITableView alloc] init];
        
        [self.subTableView registerClass:[ZKHMyShareCell class] forCellReuseIdentifier:SubCellIdentifier];
        
        self.subTableView.delegate = self;
        self.subTableView.dataSource = self;
        
        [self addSubview:self.subTableView];
    }
    
    CGRect pFrame = self.publishDateLabel.frame;
    self.subTableView.frame = CGRectMake(70, pFrame.origin.y, [ZKHMyShareListCell cellRightWidth], [ZKHMyShareListCell cellHeight:shares]);
    [self.subTableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.shareList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHMyShareCell *cell = [tableView dequeueReusableCellWithIdentifier:SubCellIdentifier forIndexPath:indexPath];
    
    ZKHShareEntity *share = self.shareList[indexPath.row];
    
    [cell updateViews:share];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHShareEntity *share = self.shareList[indexPath.row];
    ZKHFriendShareListController *controller = [[ZKHFriendShareListController alloc] init];
    controller.shares = [[NSMutableArray alloc] initWithObjects:share, nil];
    controller.popWhenshareDeleted = true;
    controller.shareChangedDelegate = self.parentController;
    controller.publishButtonVisible = false;
    [self.parentController.navigationController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZKHShareEntity *share = self.shareList[indexPath.row];
    return [ZKHMyShareCell cellHeight:share];
}
@end
