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
#import "ZKHContext.h"
#import "ZKHRestRequest.h"

@implementation ZKHProcessor

- (id)init
{
    if (self = [super init]) {
        restClient = [[ZKHRestClient alloc] initWithDefaultSettings];
    }
    return self;
}

 - (void)imageAtURL:(NSURL *)url completionHandler:(ZKHImageResponseBlock)imageFetchedBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    [restClient imageAtURL:url completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
        imageFetchedBlock(fetchedImage);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        ZKHErrorEntity *entity = [[ZKHErrorEntity alloc] init];
        entity.type = VAL_ERROR_TYPE_NETWORK;
        entity.message = error.description;
        errorBlock(entity);
    }];
}

//获取module数据
#define GET_MODULES_URL(__TYPE__) [NSString stringWithFormat:@"/getModules/%@", __TYPE__]
- (void)modulesForType:(NSString *)type completionHandler:(ModulesResponseBlock)modulesBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHModuleData *data = [[ZKHModuleData alloc] init];
    NSMutableArray * modules = [data modules:type];
    if ([modules count] > 0) {
        modulesBlock(modules);
        return;
    }
    
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.method = METHOD_GET;
    request.urlString = GET_MODULES_URL([type mk_urlEncodedString]);
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSMutableArray * modules = [[NSMutableArray alloc] initWithCapacity:10];
        if (jsonObject != nil) {
            for (NSDictionary *json in jsonObject) {
                ZKHModuleEntity *module = [[ZKHModuleEntity alloc] init];
                module.uuid = [json valueForKey:KEY_UUID];
                module.code = [json valueForKey:KEY_CODE];
                module.name = [json valueForKey:KEY_NAME];
                module.icon = [json valueForKey:KEY_ICON];
                module.url = [json valueForKey:KEY_URL];
                module.type = type;
                module.ordIndex =[json valueForKey:KEY_ORD_INDEX];
                
                [modules addObject:module];
            }
        }
        //TODO:使用委托代理的方式处理?
        
        [data save:modules];
        
        modulesBlock(modules);
    } errorHandler:^(ZKHErrorEntity *error) {
        errorBlock(error);
    }];
}

//获取栏目数据
#define GET_CHANNELS_URL @"/getChannels"
#define GET_SUB_CHANNELS_URL(__PARENT_ID__) [NSString stringWithFormat:@"%@/%@", GET_CHANNELS_URL, __PARENT_ID__]
- (void)channels:(NSString *)parentId completionHandler:(ChannelsResponseBlock)channelsBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHChannelData *data = [[ZKHChannelData alloc] init];
    NSMutableArray *channels = [data channels];
    if ([channels count] > 0) {
        channelsBlock(channels);
        return;
    }
    
    NSString *path = GET_CHANNELS_URL;
    if (parentId != nil) {
        path = GET_SUB_CHANNELS_URL ([parentId mk_urlEncodedString]);
    }
    
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = path;
    request.method = METHOD_GET;
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
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
    } errorHandler:^(ZKHErrorEntity *error) {
        errorBlock(error);
    }];
}

@end
