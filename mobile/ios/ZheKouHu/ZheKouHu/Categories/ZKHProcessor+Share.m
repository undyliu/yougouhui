//
//  ZKHProcessor+Share.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-3.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHProcessor+Share.h"
#import "ZKHConst.h"
#import "NSString+Utils.h"
#import "ZKHData.h"

@implementation ZKHProcessor (Share)

//发布分享
#define PUBLISH_SHARE_URL @"/saveShare"
- (void)publishShare:(ZKHShareEntity *)share completionHandler:(BooleanResultResponseBlock)publishShareBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.method = METHOD_POST;
    request.urlString = PUBLISH_SHARE_URL;
    request.params = @{KEY_CONTENT: share.content, KEY_PUBLISHER:share.publisher.uuid, KEY_SHOP_ID: (share.shop !=nil ? share.shop.uuid : @""), KEY_ACCESS_TYPE: share.accessType};
    request.files = share.imageFiles;
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSString *uuid = jsonObject[KEY_UUID];
        if (![uuid isNull]) {
            share.uuid = uuid;
            share.publishTime = jsonObject[KEY_PUBLISH_TIME];
            share.publishDate = jsonObject[KEY_PUBLISH_DATE];
            
            NSMutableArray *files = [[NSMutableArray alloc] init];
            id jsonImages = jsonObject[KEY_IMAGES];
            for (id jsonImage in jsonImages) {
                ZKHFileEntity *file = [[ZKHFileEntity alloc] init];
                file.uuid = jsonImage[KEY_UUID];
                file.aliasName = jsonImage[KEY_IMG];
                [files addObject:file];
            }
            share.imageFiles = files;
            
            [[[ZKHShareData alloc] init] save:@[share]];
            
            publishShareBlock(true);
        }else{
            publishShareBlock(false);
        }
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

@end
