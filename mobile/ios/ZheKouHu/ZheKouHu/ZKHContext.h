//
//  ZKHContext.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-21.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZKHEntity.h"

@interface ZKHContext : NSObject

+ (ZKHContext *) getInstance;

- (Boolean) isAnonymousUserLogined;

@property (strong, nonatomic) ZKHUserEntity *user;
@property (strong, nonatomic) NSString *sessionId;
@property Boolean shopLogined;
@property Boolean shouldRelogin;
@end
