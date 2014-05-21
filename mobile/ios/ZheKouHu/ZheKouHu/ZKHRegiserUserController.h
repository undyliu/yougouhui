//
//  ZKHRegiserUserController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-20.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKHRegiserUserController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UITextField *pwdConfField;

- (IBAction)fieldDoneEdting:(id)sender;

- (IBAction)backgroupTap:(id)sender;

- (void) registerUser: (id)sender;
@end
