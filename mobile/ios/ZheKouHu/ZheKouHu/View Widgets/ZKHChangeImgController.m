//
//  ZKHChangeImgController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-26.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHChangeImgController.h"
#import "ZKHImageLoader.h"
#import "ZKHImagePreviewController.h"
#import "ZKHViewUtils.h"

#define kImageViewTag 0
#define kDelImageViewTag 1
#define kPreviewImageViewTag 2

@implementation ZKHChangeImgController

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
    
    [[NSBundle mainBundle] loadNibNamed:@"ZKHChangeImgController" owner:self options:nil];
    
    self.imageView.userInteractionEnabled = TRUE;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)] ];
    
    self.delImageView.userInteractionEnabled = TRUE;
    [self.delImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(delImageClick:)]];
    
    self.previewImageView.userInteractionEnabled = TRUE;
    [self.previewImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(previewImageClick:)]];
    
    ZKHFileEntity *imageFile = [self getOriginalImageFile];
    if (imageFile != nil) {
        [ZKHImageLoader showImageForName:imageFile.aliasName imageView:self.imageView];
    }
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ZKHFileEntity *)getOriginalImageFile
{
    return nil;
}

- (void)save:(id)sender
{
    if (!self.imageSelected) {
        [ZKHViewUtils showTipView:self.imageView message:@"请先选择图片." dismissTapAnywhere:true autoDismissInvertal:false];
        return;
    }
    
    [self doSave];
}

- (void)doSave
{
    
}

- (void)imageClick:(UIImage *)sender
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

- (void)delImageClick:(id)sender
{
    self.imageView.image = [UIImage imageNamed:@"add_camera.png"];
    self.imageSelected = false;
}

- (void)previewImageClick:(id)sender
{
    ZKHImagePreviewController *controller = [[ZKHImagePreviewController alloc] init];
    controller.image = self.imageView.image;
    [self.navigationController pushViewController:controller animated:YES];
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
    self.imageView.image = selectedImage;
    self.imageSelected = true;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
