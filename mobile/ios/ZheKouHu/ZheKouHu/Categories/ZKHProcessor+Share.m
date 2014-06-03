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
#import "ZKHProcessor+Sync.h"
#import "ZKHAppDelegate.h"
#import "NSDate+Utils.h"
#import "ZKHContext.h"

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
        if (![NSString isNull:uuid]) {
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

- (ZKHSyncEntity *) shareSyncEntity
{
    ZKHUserEntity *user = [ZKHContext getInstance].user;
    ZKHSyncEntity *sync = [ApplicationDelegate.zkhProcessor getSyncEntity: SHARE_TABLE itemId:user.uuid];
    if (sync == nil) {
        sync = [[ZKHSyncEntity alloc] init];
        NSString *currentTime = [NSDate currentTimeString];
        sync.updateTime = user.registerTime;
        sync.uuid = [currentTime copy];
        sync.tableName = SALE_TABLE;
        sync.itemId = user.uuid;
    }
    return sync;
}

#define  GET_FRIEND_SHARES_URL(__USER_ID__, __UPDATE_TIME__) [NSString stringWithFormat:@"/getFriendShares/%@/%@", __USER_ID__, __UPDATE_TIME__]
- (void)friendShares:(NSString *)userId completionHandler:(SharesResponseBlock)sharesBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHShareData *shareData = [[ZKHShareData alloc] init];
    NSMutableArray *shares = [shareData friendShares:userId];
    if ([shares count] > 0) {
        sharesBlock(shares);
        return;
    }
 
    ZKHSyncEntity *shareSync = [self shareSyncEntity];
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = GET_FRIEND_SHARES_URL([ZKHContext getInstance].user.uuid, shareSync.updateTime);
    request.method = METHOD_GET;
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        if (jsonObject != nil) {
            NSString *updateTime = [jsonObject valueForKey:KEY_UPDATE_TIME];
            
            id jsonShares = [jsonObject valueForKey:KEY_DATA];
            for (id jsonShare in jsonShares) {
                
            }
            
            shareSync.updateTime = updateTime;
        }
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

@end
