//
//  ZKHShareListPicController.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-9.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHShareListPicsController.h"
#import "ZKHImageLoader.h"
#import "ZKHShareListImageCell.h"
#import "ZKHImageListPreviewController.h"

static NSString *CellIdentifier = @"ShareListImageCell";


@implementation ZKHShareListPicsController


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.share.imageFiles count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHShareListImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    ZKHFileEntity *file = self.share.imageFiles[indexPath.row];
    [ZKHImageLoader showImageForName:file.aliasName imageView:cell.imageView];
    cell.imageView.tag = indexPath.row;
    
    cell.imageView.userInteractionEnabled = true;
    [cell.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showImageView:)]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(50, 50);
    return size;
}

- (void) showImageView:(UITapGestureRecognizer *)tap
{
    int row = tap.view.tag;
    
    ZKHImageListPreviewController *controller = [[ZKHImageListPreviewController alloc] init];
    controller.imageFiles = self.share.imageFiles;
    controller.currentIndex = row;
    [self.parentController.navigationController pushViewController:controller animated:YES];
}

@end
