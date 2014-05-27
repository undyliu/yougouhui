//
//  NSString+JSON.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-21.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (NSDictionary *)toJSONObject
{
    NSError *error;
    return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding]  options:NSJSONReadingMutableLeaves error:&error];
}

+ (NSString *)stringWithJSONObject:(NSDictionary *)jsonObject
{
    NSError *error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (Boolean)isTrue
{
    return [self isEqualToString:@"true"] || [self isEqualToString:@"1"];
}

- (Boolean)isNull
{
    return self == nil || [self isKindOfClass:[NSNull class]] || [self length] == 0;
}

@end
