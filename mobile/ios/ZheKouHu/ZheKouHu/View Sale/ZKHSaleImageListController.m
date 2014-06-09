//
//  ZKHSaleImageListController.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-6.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHSaleImageListController.h"
#import "ZKHPictureCell.h"
#import "ZKHEntity.h"
#import "NSString+Utils.h"
#import "ZKHImageLoader.h"

static NSString *CellIdentifier = @"DefaultPictureCell";

@implementation ZKHSaleImageListController

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
    
    self.title = @"活动图片";
    
    UINib *nib = [UINib nibWithNibName:@"ZKHPictureCell" bundle:nil];
    [self.mainView registerNib:nib forCellWithReuseIdentifier:CellIdentifier];
    self.mainView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.imageFiles count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    int row = indexPath.row;
    ZKHFileEntity *file = self.imageFiles[row];
    NSString *name = file.aliasName;
    if (![NSString isNull:name]) {
        [ZKHImageLoader showImageForName:name imageView:cell.imageView];
        cell.imageView.userInteractionEnabled = true;
//        cell.imageView.tag = row;
//        [cell.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(previewPic:)]];
    }
    
    return cell;
}

@end
