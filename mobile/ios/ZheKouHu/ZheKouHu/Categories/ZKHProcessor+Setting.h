//
//  ZKHProcessor+Setting.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-28.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHProcessor.h"
#import "ZKHEntity.h"

@interface ZKHProcessor (Setting)

//获取设置条目
typedef void (^SettingsResponseBlock)(NSMutableArray* settings);
- (void) settings: (SettingsResponseBlock) settingsBlock
     errorHandler:(RestResponseErrorBlock) errorBlock;

typedef void (^SettingResponseBlock)(ZKHSettingEntity* setting);
- (void) setting:(NSString *)code userId:(NSString *)userId completionHandler:(SettingResponseBlock) settingBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) radarSetting:(NSString *)userId withDefaultValue:(Boolean)withDefaultValue completionHandler:(SettingResponseBlock) settingBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) saveSetting:(ZKHSettingEntity *)setting completionHandler:(BooleanResultResponseBlock) settingBlock errorHandler:(RestResponseErrorBlock) errorBlock;

@end
