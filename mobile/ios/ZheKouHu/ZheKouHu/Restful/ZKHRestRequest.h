//
//  ZKHRestRequest.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-23.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKHRestRequest : NSObject

@property (strong, nonatomic) NSString *method;
@property (strong, nonatomic) NSString *urlString;
@property (strong, nonatomic) NSDictionary *params;
@property (strong, nonatomic) NSMutableDictionary *headers;

- (void) addHeader:(NSString *)key value:(NSString *)value;

@end
