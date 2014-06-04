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
    return [NSDate milliSeconds:[NSDate date]];
}

+ (NSString *)milliSeconds:(NSDate *)datetime
{
//    NSDateFormatter *nsdf2 = [[NSDateFormatter alloc] init];
//    [nsdf2 setDateStyle: NSDateFormatterShortStyle];
//    [nsdf2 setDateFormat: @"YYYYMMddHHmmssSSSS"];
//    return [nsdf2 stringFromDate:date];
    
     NSTimeInterval interval = [datetime timeIntervalSince1970];
    //NSLog(@"interval=%f",interval);
    long long totalMilliseconds = interval*1000 ;
    //NSLog(@"totalMilliseconds=%llu",totalMilliseconds);
    return [NSString stringWithFormat:@"%llu", totalMilliseconds];
}

+ (id)dateWithMilliSeconds:(long long)milliSeconds
{
    return [NSDate dateWithTimeIntervalSince1970:milliSeconds/1000.0];
}

- (NSString *)toyyyyMMddString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:self];
}
@end
