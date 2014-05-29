//
//  ZKHImageLoader.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-23.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHImageLoader.h"
#import "ZKHAppDelegate.h"
#import "ZKHConst.h"

#define KEY_IMAGES_DIR @"Images"

#define GET_IMAGE_FILE_URL(__FILE_NAME__) [NSString stringWithFormat:@"http://%@/%@/%@", SERVER_BASE_URL, @"getImageFile", __FILE_NAME__]

@implementation ZKHImageLoader

+ (NSString *) getImageFilePath:(NSString *) fileName
{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *imageDir = [[docDir stringByAppendingPathComponent:KEY_CACHES] stringByAppendingPathComponent:KEY_IMAGES_DIR];
    BOOL dirExist = [[NSFileManager defaultManager] fileExistsAtPath:imageDir];
    if (!dirExist) {
        BOOL result = [[NSFileManager defaultManager] createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
        NSAssert(result, @"创建目录失败.");
    }
    
    return [imageDir stringByAppendingPathComponent:fileName];
}

+ (NSString*) saveImage:(UIImage *)image fileName:(NSString *) fileName
{
    NSData *data = UIImagePNGRepresentation(image);
    if (data == nil) {
        data = UIImageJPEGRepresentation(image, 1);
    }
    NSString *filePath = [ZKHImageLoader getImageFilePath:fileName];
    [data writeToFile:filePath options:NSAtomicWrite error:nil];
    return  filePath;
}

+ (void)removeImageWithName:(NSString *)fileName
{
    [ZKHImageLoader removeImageWithPath:[ZKHImageLoader getImageFilePath:fileName]];
}

+ (void)removeImageWithPath:(NSString *)filePath
{
    BOOL result = [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    NSAssert(result, @"删除文件失败", filePath);
}

+ (UIImage *) loadImageLocal:(NSString *) fileName
{
    return [UIImage imageWithContentsOfFile:[ZKHImageLoader getImageFilePath:fileName]];
}

+ (void)loadImageForName:(NSString *)fileName completionHandler:(ImageResponseBlock)imageBlock errorHandler:(MKNKErrorBlock)errorBlock
{
    UIImage *image = [ZKHImageLoader loadImageLocal:fileName];
    if (image != nil) {
        imageBlock(image);
        return;
    }
    
    NSURL *imageUrl = [NSURL URLWithString: GET_IMAGE_FILE_URL(fileName)];    
    [ApplicationDelegate.zkhProcessor imageAtURL:imageUrl completionHandler:^(UIImage *fetchedImage) {
        [ZKHImageLoader saveImage:fetchedImage fileName:fileName];
        imageBlock(fetchedImage);
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

+ (void)showImageForName:(NSString *)fileName imageView:(UIImageView *)imageView
{
    [ZKHImageLoader loadImageForName:fileName completionHandler:^(UIImage *loadedImage) {
        imageView.image = loadedImage;
    } errorHandler:^(NSError *error) {
        
    }];
}

@end
