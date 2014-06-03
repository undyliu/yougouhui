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
        self.readonly = true;
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
    
    if (!self.readonly) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteImageClick:)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)deleteImageClick:(id)sender
{
    if ([self.images count] > 0) {
        if (self.image) {
            [self.images removeObject:self.image];
            [self.navigationController popViewControllerAnimated:YES];
        }else if (self.imageFile){
            [self.images removeObject:self.imageFile];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
}

@end
