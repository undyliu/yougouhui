//
//  ZKHRegiserUserController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-20.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHTextField.h"

@interface ZKHRegiserUserController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet ZKHTextField *phoneField;
@property (weak, nonatomic) IBOutlet ZKHTextField *nameField;
@property (weak, nonatomic) IBOutlet ZKHTextField *pwdField;
@property (weak, nonatomic) IBOutlet ZKHTextField *pwdConfField;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UIImageView *delPhotoView;

@property (weak, nonatomic) IBOutlet UIScrollView *mainView;
- (IBAction)backgroupTap:(id)sender;

- (IBAction)photoViewClick:(id)sender;
- (IBAction)delPhotoViewClick:(id)sender;

- (void) registerUser: (id)sender;
@end
