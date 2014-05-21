//
//  ZKHProcessor+Sync.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-21.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHProcessor+Sync.h"
#import "ZKHData.h"

@implementation ZKHProcessor (Sync)

- (ZKHSyncEntity *)getSyncEntity:(NSString *)tableName itemId:(NSString *)itemId
{
    return [[[ZKHSyncData alloc] init] getSyncEntity:tableName itemId:itemId];
}

@end
