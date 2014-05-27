//
//  ZKHImagePreviewController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-26.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHImagePreviewController.h"
#import "ZKHImageLoader.h"

@interface ZKHImagePreviewController ()

@end

@implementation ZKHImagePreviewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"图片预览";
    
    if (self.image != nil) {
        self.imageView.image = self.image;
    }else if (self.imageFile != nil) {
        [ZKHImageLoader showImageForName:self.imageFile.aliasName imageView:self.imageView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
