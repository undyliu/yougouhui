//
//  ZKHNetworkEngine.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-19.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHProcessor.h"
#import "ZKHConst.h"
#import "ZKHData.h"

#define SERVER_BASE_URL  @"192.168.253.1:3000"

@implementation ZKHProcessor

- (id)initWithDefaultSettings
{
    if(self = [super initWithHostName:SERVER_BASE_URL customHeaderFields:@{@"x-client-identifier" : @"iOS"}]) {
    }
    return self;
}

//获取module数据
#define GET_MODULES_URL(__TYPE__) [NSString stringWithFormat:@"/getModules/%@", __TYPE__]
- (void)modulesForType:(NSString *)type completionHandler:(ModulesResponseBlock)modulesBlock errorHandler:(MKNKErrorBlock)errorBlock
{
    ZKHModuleData *data = [[ZKHModuleData alloc] init];
    NSMutableArray * modules = [data getModules:type];
    if ([modules count] > 0) {
        modulesBlock(modules);
        return;
    }
    
    MKNetworkOperation *op = [self operationWithPath:GET_MODULES_URL([type mk_urlEncodedString])];    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            NSMutableArray * modules = [[NSMutableArray alloc] initWithCapacity:10];
            if (jsonObject != nil) {
                for (NSDictionary *json in jsonObject) {
                    ZKHModuleEntity *module = [[ZKHModuleEntity alloc] init];
                    module.uuid = [json valueForKey:KEY_UUID];
                    module.code = [json valueForKey:KEY_CODE];
                    module.name = [json valueForKey:KEY_NAME];
                    module.icon = [json valueForKey:KEY_ICON];
                    module.type = type;
                    module.ordIndex =[json valueForKey:KEY_ORD_INDEX];
                    
                    [modules addObject:module];
                }
            }
            //TODO:使用委托代理的方式处理?
            
            [data save:modules];
            
            modulesBlock(modules);
        }];
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
}

//获取栏目数据
#define GET_CHANNELS_URL @"/getChannels"
#define GET_SUB_CHANNELS_URL(__PARENT_ID__) [NSString stringWithFormat:@"%@/%@", GET_CHANNELS_URL, __PARENT_ID__]
- (void)channels:(NSString *)parentId completionHandler:(ChannelsResponseBlock)channelsBlock errorHandler:(MKNKErrorBlock)errorBlock
{
    ZKHChannelData *data = [[ZKHChannelData alloc] init];
    NSMutableArray *channels = [data getChannels];
    if ([channels count] > 0) {
        channelsBlock(channels);
        return;
    }
    
    NSString *path = GET_CHANNELS_URL;
    if (parentId != nil) {
        path = GET_SUB_CHANNELS_URL([parentId mk_urlEncodedString]);
    }
    
    MKNetworkOperation *op = [self operationWithPath:path params:nil httpMethod:METHOD_GET];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            NSMutableArray *channels = [[NSMutableArray alloc] initWithCapacity:10];
            if (jsonObject != nil) {
                for (NSDictionary *json in jsonObject) {
                    ZKHChannelEntity *channel = [[ZKHChannelEntity alloc] init];
                    channel.uuid = [json valueForKey:KEY_UUID];
                    channel.code = [json valueForKey:KEY_CODE];
                    channel.name = [json valueForKey:KEY_NAME];
                    channel.parentId = [json valueForKey:KEY_PARENT_ID];
                    channel.ordIndex = [json valueForKey:KEY_ORD_INDEX];
                    
                    [channels addObject: channel];
                }
            }
            [data save:channels];
            
            channelsBlock(channels);
        }];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];
}

@end
