//
//  ZKHProcessor+Sync.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-21.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHProcessor.h"
#import "ZKHEntity.h"

@interface ZKHProcessor (Sync)

- (ZKHSyncEntity *) getSyncEntity:(NSString *)tableName itemId:(NSString *)itemId;

@end
