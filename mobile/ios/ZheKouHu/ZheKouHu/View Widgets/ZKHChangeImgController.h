//
//  ZKHChangeImgController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-26.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHEntity.h"

@interface ZKHChangeImgController : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *delImageView;
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;

- (IBAction)imageClick:(UIImage *)sender;
- (IBAction)delImageClick:(id)sender;
- (IBAction)previewImageClick:(id)sender;

- (IBAction)save:(id)sender;

- (ZKHFileEntity *) getOriginalImageFile;

@end
