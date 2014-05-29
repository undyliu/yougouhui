//
//  ZKHUserProfileController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-22.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHChangeTextController.h"
#import "ZKHChangePwdController.h"
#import "ZKHChangeImgController.h"

@interface ZKHUserProfileController : UITableViewController

@end

@interface ZKHChangeUserNameController : ZKHChangeTextController

@end

@interface ZKHChangeUserPwdController : ZKHChangePwdController

@end

@interface ZKHChangeUserPhotoController : ZKHChangeImgController

@end
