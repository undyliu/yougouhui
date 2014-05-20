//
//  ZKHNetworkEngine.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-19.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "MKNetworkEngine.h"
#import "ZKHEntity.h"

@interface ZKHProcessor : MKNetworkEngine

- (id)initWithDefaultSettings;

typedef void (^ModulesResponseBlock)(NSMutableArray* modules);
- (void) modulesForType: (NSString *) type completionHandler:(ModulesResponseBlock) modulesBlock errorHandler:(MKNKErrorBlock) errorBlock;

typedef void (^ChannelsResponseBlock)(NSMutableArray* channels);
- (void) channels: (NSString *)parentId completionHandler:(ChannelsResponseBlock) channelsBlock
     errorHandler:(MKNKErrorBlock) errorBlock;

typedef void (^LoginResponseBlock)(NSMutableDictionary *authObj);
- (void) login: (NSString *) phone pwd:(NSString *)pwd completionHandler:(LoginResponseBlock) loginBlock errorHandler:(MKNKErrorBlock) errorBlock;
@end
