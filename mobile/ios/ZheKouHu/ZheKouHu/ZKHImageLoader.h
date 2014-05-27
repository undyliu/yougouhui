//
//  ZKHImageLoader.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-23.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkOperation.h"

@interface ZKHImageLoader : NSObject

+ (NSString*) saveImage:(UIImage *)image fileName:(NSString *) fileName;
+ (void) removeImageWithName:(NSString *)fileName;
+ (void) removeImageWithPath:(NSString *)filePath;

typedef void (^ImageResponseBlock)(UIImage* loadedImage);
+ (void) loadImageForName: (NSString *)fileName completionHandler:(ImageResponseBlock) imageBlock errorHandler:(MKNKErrorBlock) errorBlock;

+ (void) showImageForName: (NSString *)fileName imageView:(UIImageView *)imageView;

@end
