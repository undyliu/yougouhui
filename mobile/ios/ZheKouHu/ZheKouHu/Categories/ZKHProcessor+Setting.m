//
//  ZKHProcessor+Setting.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-28.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHProcessor+Setting.h"
#import "ZKHContext.h"
#import "ZKHData.h"
#import "ZKHConst.h"
#import "NSString+Utils.h"

@implementation ZKHProcessor (Setting)

//获取设置条目
#define GET_SETTINS_URL @"/getSettings"
- (void)settings:(SettingsResponseBlock)settingsBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    
    if (![[ZKHContext getInstance] isAnonymousUserLogined]) {
        ZKHUserEntity *user = [ZKHContext getInstance].user;
        ZKHSettingData *data = [[ZKHSettingData alloc] init];
        NSMutableArray * settings = [data settings:user.uuid];
        if ([settings count] > 0) {
            settingsBlock(settings);
            return;
        }
    }
    
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.method = METHOD_GET;
    request.urlString = GET_SETTINS_URL;
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSMutableArray * settings = [[NSMutableArray alloc] initWithCapacity:10];
        if (jsonObject != nil) {
            NSString *userId = [ZKHContext getInstance].user.uuid;
            for (NSDictionary *json in jsonObject) {
                ZKHSettingEntity *setting = [[ZKHSettingEntity alloc] init];
                setting.uuid = [NSString stringWithFormat:@"%@_%@", userId, [json valueForKey:KEY_UUID]];
                setting.code = [json valueForKey:KEY_CODE];
                setting.name = [json valueForKey:KEY_NAME];
                setting.img = [json valueForKey:KEY_IMG];
                setting.ordIndex =[json valueForKey:KEY_ORD_INDEX];
                setting.userId = userId;
                setting.value = @"";
                
                [settings addObject:setting];
            }
        }
        ZKHSettingData *data = [[ZKHSettingData alloc] init];
        [data save:settings];
        
        settingsBlock(settings);
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)radarSetting:(NSString *)userId withDefaultValue:(Boolean)withDefaultValue completionHandler:(SettingResponseBlock)settingBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    [self setting:SETTING_CODE_RADAR userId:userId completionHandler:^(ZKHSettingEntity *setting) {
        if (setting && withDefaultValue) {
            NSString *value = setting.value;
            if ([value isNull]) {
                NSDictionary *tmp = @{RADAR_VAL_FIELD_DISTANCE: @"2000", RADAR_VAL_FIELD_SALE : @"true", RADAR_VAL_FIELD_SHOP: @"true" };
                setting.value = [NSString stringWithJSONObject:tmp];
            }
        }
        settingBlock(setting);
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

-(void)setting:(NSString *)code userId:(NSString *)userId completionHandler:(SettingResponseBlock)settingBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHSettingData *settingData = [[ZKHSettingData alloc] init];
    ZKHSettingEntity *setting = [settingData setting:code userId:userId];
    if (setting != nil) {
        settingBlock(setting);
        return;
    }
    
    [self settings:^(NSMutableArray *settings) {
        for (ZKHSettingEntity *setting in settings) {
            if ([code isEqualToString:setting.code]) {
                settingBlock(setting);
                return ;
            }
        }
     settingBlock(nil);//TODO:进行错误处理
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)saveSetting:(ZKHSettingEntity *)setting completionHandler:(SettingSaveResponseBlock)settingBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    @try {
        [[[ZKHSettingData alloc] init] save:@[setting]];
        settingBlock(true);
    }
    @catch (NSException *exception) {
        settingBlock(false);
    }
    @finally {
    }
}
@end
