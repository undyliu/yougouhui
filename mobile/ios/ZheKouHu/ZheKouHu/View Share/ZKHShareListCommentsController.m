//
//  ZKHShareListCommentsController.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-9.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHShareListCommentsController.h"
#import "ZKHEntity.h"
#import "ZKHSaleDiscussListCell.h"
#import "ZKHContext.h"
#import "ZKHProcessor+Share.h"
#import "ZKHAppDelegate.h"

static NSString *CellIdentifier = @"SaleDiscussListCell";

@implementation ZKHShareListCommentsController

- (void) deleteComment:(UITapGestureRecognizer *)tap
{
    int index = tap.view.tag;
    ZKHShareCommentEntity *comment = self.comments[index];
    [ApplicationDelegate.zkhProcessor deleteComment:comment completionHandler:^(Boolean result) {
        if (result) {
            [self.comments removeObject:comment];
            
            if (self.commentDelegate) {
                [self.commentDelegate updateComments:self.comments];
            }
        }
    } errorHandler:^(ZKHErrorEntity *error) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.comments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHSaleDiscussListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    ZKHShareCommentEntity *comment = self.comments[indexPath.row];
    ZKHUserEntity *publisher = comment.pulisher;
    NSString *content = [NSString stringWithFormat:@"%@ 回复:%@", publisher.name, comment.content];
    cell.contentLabel.text = content;
    
    cell.delelteImageView.tag = indexPath.row;
    if ([comment.pulisher isEqual:[ZKHContext getInstance].user]) {
        cell.delelteImageView.hidden = false;
        
        cell.delelteImageView.userInteractionEnabled = true;
        [cell.delelteImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteComment:)]];
    }else{
        cell.delelteImageView.hidden = true;
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0;
}

@end
