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
        path = GET_SUB_CHANNELS_URL ([parentId mk_urlEncodedString]);
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


//获取设置条目
#define GET_SETTINS_URL @"/getSettings"
- (void)settings:(SettingsResponseBlock)settingsBlock errorHandler:(MKNKErrorBlock)errorBlock
{
    
    if (![[ZKHContext getInstance] isAnonymousUserLogined]) {
        ZKHUserEntity *user = [ZKHContext getInstance].user;
        ZKHSettingData *data = [[ZKHSettingData alloc] init];
        NSMutableArray * settings = [data getSettings:user.uuid];
        if ([settings count] > 0) {
            settingsBlock(settings);
            return;
        }
    }
    
    MKNetworkOperation *op = [self operationWithPath:GET_SETTINS_URL];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            NSMutableArray * settings = [[NSMutableArray alloc] initWithCapacity:10];
            if (jsonObject != nil) {
                for (NSDictionary *json in jsonObject) {
                    ZKHSettingEntity *setting = [[ZKHSettingEntity alloc] init];
                    setting.uuid = [json valueForKey:KEY_UUID];
                    setting.code = [json valueForKey:KEY_CODE];
                    setting.name = [json valueForKey:KEY_NAME];
                    setting.img = [json valueForKey:KEY_IMG];
                    setting.ordIndex =[json valueForKey:KEY_ORD_INDEX];
                    setting.userId = [ZKHContext getInstance].user.uuid;
                    setting.value = @"";
                    
                    [settings addObject:setting];
                }
            }
            ZKHSettingData *data = [[ZKHSettingData alloc] init];
            [data save:settings];
            
            settingsBlock(settings);
        }];
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
}

#define GET_TRADES_URL @"/getTrades"
- (void)trades:(TradesResponseBlock)tradesBlock errorHandler:(MKNKErrorBlock)errorBlock
{
    ZKHTradeData *data = [[ZKHTradeData alloc] init];
    NSMutableArray *trades = [data getTrades];
    if ([trades count] > 0) {
        tradesBlock(trades);
        return;
    }
    
    MKNetworkOperation *op = [self operationWithPath:GET_TRADES_URL];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            NSMutableArray * trades = [[NSMutableArray alloc] initWithCapacity:10];
            if (jsonObject != nil) {
                for (NSDictionary *json in jsonObject) {
                    ZKHTradeEntity *trade = [[ZKHTradeEntity alloc] init];
                    trade.uuid = [json valueForKey:KEY_UUID];
                    trade.code = [json valueForKey:KEY_CODE];
                    trade.name = [json valueForKey:KEY_NAME];
                    trade.ordIndex =[json valueForKey:KEY_ORD_INDEX];
                    
                    [trades addObject:trade];
                }
            }
         [data save:trades];
         
         tradesBlock(trades);
        }];
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
}
@end
