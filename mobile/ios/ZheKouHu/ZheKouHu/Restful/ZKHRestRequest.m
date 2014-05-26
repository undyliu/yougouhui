//
//  ZKHRestRequest.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-23.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHRestRequest.h"

@implementation ZKHRestRequest

- (void)addHeader:(NSString *)key value:(NSString *)value
{
    if (_headers == nil) {
        _headers = [[NSMutableDictionary alloc] init];
    }
    
    [_headers setValue:value forKey:key];
}

@end
