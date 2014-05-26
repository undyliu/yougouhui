//
//  ZKHImagePreviewController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-26.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHEntity.h"

@interface ZKHImagePreviewController : UIViewController

@property (strong, nonatomic) ZKHFileEntity *imageFile;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
