//
//  ZKHRegiserUserController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-20.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHRegiserUserController.h"
#import "ZKHAppDelegate.h"
#import "ZKHProcessor+User.h"
#import "ZKHContext.h"
#import "NSDate+Utils.h"
#import "ZKHImageLoader.h"
#import "ZKHConst.h"

@interface ZKHRegiserUserController ()

@end

@implementation ZKHRegiserUserController

- (id)init
{
    if (self = [super init]) {
        self.title = NSLocalizedString(@"LABEL_REGISTER_USER", @"register user");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(registerUser:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    self.photoView.userInteractionEnabled = TRUE;
    [self.photoView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoViewClick:)]];
    self.delPhotoView.userInteractionEnabled = TRUE;
    [self.delPhotoView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(delPhotoViewClick:)]];
    self.delPhotoView.hidden = true;
    
    [self.mainView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroupTap:)]];
    
    self.phoneField.popMessageWhenEmptyText = @"手机号不能为空.";
    self.nameField.popMessageWhenEmptyText = @"昵称不能为空.";
    self.pwdField.popMessageWhenEmptyText = @"密码不能为空.";
    self.pwdConfField.popMessageWhenEmptyText = @"密码确认不能为空.";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backgroupTap:(id)sender
{
    [self.phoneField resignFirstResponder];
    [self.nameField resignFirstResponder];
    [self.pwdField resignFirstResponder];
    [self.pwdConfField resignFirstResponder];
}

- (void)delPhotoViewClick:(id)sender
{
    self.photoView.image = [UIImage imageNamed:@"add_camera.png"];
    self.delPhotoView.hidden = true;
}

- (void)photoViewClick:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedImage = info[UIImagePickerControllerOriginalImage];
    self.photoView.image = selectedImage;
    self.delPhotoView.hidden = false;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerUser:(id)sender
{
    [self backgroupTap:nil];
    
    NSString *phone = self.phoneField.text;
    NSString *name = self.nameField.text;
    NSString *pwd = self.pwdField.text;
    NSString *pwdConf = self.pwdConfField.text;
    
    Boolean cancel = false;
    
    if ([phone length] == 0) {
        [self.phoneField showTipView];
        cancel = true;
    }else if ([phone length] != 11) {
        [self.phoneField showTipView:@"请输入11位手机号."];
        cancel = true;
    }
    
    if ([name length] == 0) {
        [self.nameField showTipView];
        cancel = true;
    }else if ([name length] > 30){
        [self.nameField showTipView:@"昵称字数太多啦."];
        cancel = true;
    }
    
    if ([pwd length] == 0) {
        [self.pwdField showTipView];
        cancel = true;
    }else if([pwd length] < 4){
        [self.pwdField showTipView:@"密码至少4位."];
        cancel = true;
    }
    
    if ([pwdConf length] == 0) {
        [self.pwdConfField showTipView];
        cancel = true;
    }else if([pwdConf length] < 4){
        [self.pwdConfField showTipView:@"密码至少4位."];
        cancel = true;
    }
    
    if (![pwd isEqualToString:pwdConf]) {
        [self.pwdConfField showTipView:@"密码不一致."];
        cancel = true;
    }
    
    if (cancel) {
        return;
    }
    
    ZKHUserEntity *user = [[ZKHUserEntity alloc] init];
    user.phone = phone;
    user.pwd = pwd;
    user.name = name;
    user.type = VAL_TYPE_USER_APP;
    
    if (!self.delPhotoView.hidden) {
        NSString *aliasName = [NSString stringWithFormat:@"%@_%@.png", user.phone, [NSDate currentTimeString]];
        NSString *filePath = [ZKHImageLoader saveImage:self.photoView.image fileName:aliasName];
        
        user.photo = [[ZKHFileEntity alloc] init];
        user.photo.aliasName = aliasName;
        user.photo.fileUrl = filePath;
    }
    
    [ApplicationDelegate.zkhProcessor registerUser:user completionHandler:^(ZKHUserEntity *result) {
        if (result != nil) {
            [ZKHContext getInstance].user = result;
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [ZKHImageLoader removeImageWithName:user.photo.aliasName];
        }
    } errorHandler:^(ZKHErrorEntity *error) {
        [ZKHImageLoader removeImageWithName:user.photo.aliasName];
    }];
}
@end
