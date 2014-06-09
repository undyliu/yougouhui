//
//  ZKHShareController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-30.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHShareController.h"
#import "ZKHPictureCell.h"
#import "ZKHImagePreviewController.h"
#import "ZKHProcessor+Share.h"
#import "ZKHAppDelegate.h"
#import "ZKHEntity.h"
#import "ZKHContext.h"
#import "ZKHImageLoader.h"
#import "NSDate+Utils.h"
#import "ZKHConst.h"
#import "ZKHChooseShopController.h"

#define STRING_SHARE_CONTENT_DEFAULT @"请分享下本次购物的体验吧"

static NSString *CellIdentifier = @"DefaultPictureCell";

@implementation ZKHShareController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        selectedImages = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"晒单";
    
    self.contentField.placeholder = STRING_SHARE_CONTENT_DEFAULT;
    
    UINib *nib = [UINib nibWithNibName:@"ZKHSharePicCell" bundle:nil];
    [self.picViewContainer registerNib:nib forCellWithReuseIdentifier:CellIdentifier];
    self.picViewContainer.backgroundColor = [UIColor whiteColor];
    
    if (self.shop) {
        self.shopField.text = [NSString stringWithFormat:@"商家：%@", self.shop.name];
        //self.scanShopButton.hidden = true;
    }
    
    [self.scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroupTap:)]];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveShare:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.picViewContainer reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseShop:(UIButton *)sender {
    ZKHChooseShopController *controller = [[ZKHChooseShopController alloc] init];
    controller.actionDelegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)addPicViewClick:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"从图库选择",@"拍照",
                                  nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}

- (void)previewPic:(id)sender
{
    UITapGestureRecognizer *rec = (UITapGestureRecognizer *)sender;
    UIView *view = rec.view;
    if (view) {
        int tag = view.tag;
        UIImage *image = tag < [selectedImages count] ? selectedImages[tag] : nil;
        if (image) {
            ZKHImagePreviewController *controller = [[ZKHImagePreviewController alloc] init];
            controller.readonly = false;
            controller.images = selectedImages;
            controller.image = image;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}

- (void)backgroupTap:(id)sender
{
    [self.contentField resignFirstResponder];
}

- (void)saveShare:(id)sender
{
    ZKHShareEntity *share = [[ZKHShareEntity alloc] init];
    share.content = self.contentField.text;
    share.publisher = [ZKHContext getInstance].user;
    share.shop = self.shop;
    share.imageFiles = [self getImageFiles];
    share.accessType = self.friendSeeSwitch.isOn ? VAL_SHARE_ACCESS_FRIENDS: VAL_SHARE_ACCESS_ALL;
    
    [ApplicationDelegate.zkhProcessor publishShare:share completionHandler:^(Boolean result) {
        if (result) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self deleteImageFiles:share.imageFiles];
        }
    } errorHandler:^(NSError *error) {
        
    }];
}

- (NSMutableArray *) getImageFiles
{
    ZKHUserEntity *user = [ZKHContext getInstance].user;
    NSMutableArray *files = [[NSMutableArray alloc] init];
    
    for (UIImage *image in selectedImages) {
        NSString *aliasName = [NSString stringWithFormat:@"%@_share_%@.png", user.phone, [NSDate currentTimeString]];
        NSString *filePath = [ZKHImageLoader saveImage:image fileName:aliasName];
        
        ZKHFileEntity *file = [[ZKHFileEntity alloc] init];
        file.aliasName = aliasName;
        file.fileUrl = filePath;
        
        [files addObject:file];
    }
    return files;
}

- (void) deleteImageFiles:(NSMutableArray *)files
{
    for (ZKHFileEntity *file in files) {
        [ZKHImageLoader removeImageWithName:file.aliasName];
    }
}

- (void)confirm:(ZKHShopEntity *)shop viewController:(UIViewController *)viewController
{
    if (shop) {
        self.shop = shop;
        self.shopField.text = [NSString stringWithFormat:@"商家：%@", self.shop.name];
        [viewController.navigationController popViewControllerAnimated:YES];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [selectedImages count] + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    int row = indexPath.row;
    
    UIImage *image = row < [selectedImages count] ? selectedImages[row] : nil;
    if (image) {
        cell.imageView.image = image;
        cell.imageView.userInteractionEnabled = true;
        cell.imageView.tag = row;
        [cell.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(previewPic:)]];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"add_camera.png"];
        cell.imageView.userInteractionEnabled = TRUE;
        [cell.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addPicViewClick:)]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger sourceType;
    switch (buttonIndex) {
        case 0://选择图片
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case 1://拍照
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        default:
            return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedImage = info[UIImagePickerControllerOriginalImage];
    [selectedImages addObject:selectedImage];
    [self.picViewContainer reloadData];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
