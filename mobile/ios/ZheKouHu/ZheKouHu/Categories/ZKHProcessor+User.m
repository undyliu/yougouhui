//
//  ZKHProcessor+User.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-21.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHProcessor+User.h"
#import "ZKHData.h"
#import "ZKHConst.h"

@implementation ZKHProcessor (User)

//登录
#define LOGIN_URL @"/login"
- (void)login:(NSString *)phone pwd:(NSString *)pwd completionHandler:(LoginResponseBlock)loginBlock errorHandler:(MKNKErrorBlock)errorBlock
{
    ZKHUserData *data = [[ZKHUserData alloc] init];
    ZKHUserEntity *user = [data getUser:phone];
    if ([pwd isEqualToString:user.pwd]) {
        loginBlock([[NSMutableDictionary alloc] initWithDictionary: @{KEY_USER: user, KEY_AUTHED: @"true"}]);
        return;
    }
    
    NSDictionary *params = @{KEY_PHONE : phone, KEY_PWD : pwd};
    MKNetworkOperation *op = [self operationWithPath:LOGIN_URL params:params httpMethod:METHOD_POST];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            NSMutableDictionary *authedObj = [[NSMutableDictionary alloc] init];
            Boolean authed = [[jsonObject valueForKey:KEY_AUTHED] boolValue];
            switch (authed) {
                case 1:
                {
                    NSDictionary *userJson = [jsonObject valueForKey:KEY_USER];
                    
                    ZKHUserEntity *user = [[ZKHUserEntity alloc] init];
                    user.uuid = [userJson valueForKey:KEY_UUID];
                    user.name = [userJson valueForKey:KEY_NAME];
                    user.pwd = [userJson valueForKey:KEY_PWD];
                    user.type = [userJson valueForKey:KEY_TYPE];
                    user.phone = [userJson valueForKey:KEY_PHONE];
                    user.photo = [userJson valueForKey:KEY_PHOTO];
                    user.registerTime = [userJson valueForKey:KEY_REGISTER_TIME];
                    
                    [data save:@[user]];
                    
                    [authedObj setObject:user forKey:KEY_USER];
                    [authedObj setObject:@"true" forKey:KEY_AUTHED];
                }
                    break;
                    
                default:
                {
                    [authedObj setObject:[jsonObject valueForKey:KEY_ERROR_TYPE] forKey:KEY_ERROR_TYPE];
                    [authedObj setObject:@"false" forKey:KEY_AUTHED];
                }
                    break;
            }

            loginBlock(authedObj);
        }];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
}

- (void)saveLoginEnv:(NSString *)phone value:(NSMutableDictionary *)value
{
    [[[ZKHEnvData alloc] init] saveLoginEnv:phone value:value];
}

- (NSMutableDictionary *)getLoginEnv:(NSString *)phone
{
    return [[[ZKHEnvData alloc] init] getLoginEnv:phone];
}

- (NSMutableDictionary *)getLastLoginEnv
{
    return [[[ZKHEnvData alloc] init] getLastLoginEnv];
}

- (void)deleteLoginEnv:(NSString *)phone
{
    [[[ZKHEnvData alloc] init] deleteLoginEnv:phone];
}
@end
