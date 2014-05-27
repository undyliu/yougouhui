//
//  ZKHContext.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-21.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHContext.h"
#import "ZKHConst.h"

static ZKHContext *instance;

@implementation ZKHContext

+ (ZKHContext *)getInstance
{
    if (instance == nil) {
        instance = [[ZKHContext alloc] init];
    }
    return instance;
}

- (Boolean)isAnonymousUserLogined
{
    return _user == nil || [self.user.type isEqualToString:VAL_TYPE_USER_ANONYMOUS];
}

- (ZKHUserEntity *) user
{
    if (_user == nil) {
        _user = [[ZKHUserEntity alloc] init];
        _user.name = NSLocalizedString(@"LABEL_ANONYMOUS", @"ANONYMOUS");
        _user.type = VAL_TYPE_USER_ANONYMOUS;
    }
    return _user;
}

@end
