//
//  NSDate+Utils.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-21.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "NSDate+Utils.h"

@implementation NSDate (Utils)
+ (NSString *) currentTimeString
{
    NSDateFormatter *nsdf2 = [[NSDateFormatter alloc] init];
    [nsdf2 setDateStyle: NSDateFormatterShortStyle];
    [nsdf2 setDateFormat: @"YYYYMMddHHmmssSSSS"];
    return [nsdf2 stringFromDate:[NSDate date]];
}

@end
