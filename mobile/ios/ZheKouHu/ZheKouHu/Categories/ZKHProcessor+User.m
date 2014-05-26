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
#import "ZKHContext.h"

#define KET_SET_COOKIE @"Set-Cookie"

@implementation ZKHProcessor (User)

//登录
#define LOGIN_URL @"/login"
- (void)login:(NSString *)phone pwd:(NSString *)pwd completionHandler:(LoginResponseBlock)loginBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHUserData *data = [[ZKHUserData alloc] init];
    ZKHUserEntity *user = [data getUser:phone];
    if ([pwd isEqualToString:user.pwd]) {
        loginBlock([[NSMutableDictionary alloc] initWithDictionary: @{KEY_USER: user, KEY_AUTHED: @"true"}]);
        return;
    }
    
    [self remoteLogin:phone pwd:pwd completionHandler:^(NSMutableDictionary *authObj) {
        loginBlock(authObj);
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)remoteLogin:(NSString *)phone pwd:(NSString *)pwd completionHandler:(LoginResponseBlock)loginBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    NSDictionary *params = @{KEY_PHONE : phone, KEY_PWD : pwd};
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = LOGIN_URL;
    request.params = params;
    request.method = METHOD_POST;
    
    [restClient execute:request completionHandler:^(NSHTTPURLResponse *response, id jsonObject) {
        NSString *cookieValue = [[response allHeaderFields] valueForKey:KET_SET_COOKIE];
        if (cookieValue != nil) {
            //NSString *cookieVal = (NSString *)cookieValues[0];
            [ZKHContext getInstance].sessionId = cookieValue;
        }
        
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
                
                [[[ZKHUserData alloc] init] save:@[user]];
                
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
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];

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

//修改昵称
#define UPDATE_USER_NAME_URL @"/updateUserName"
- (void)changeName:(ZKHUserEntity *)user newName:(NSString *)newName completionHandler:(ChangeFieldResponseBlock)changeNameBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    NSDictionary *params = @{KEY_UUID : user.uuid, KEY_NAME : newName};
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = UPDATE_USER_NAME_URL;
    request.params = params;
    request.method = METHOD_PUT;
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        if ([[jsonObject valueForKey:KEY_UUID] length] > 0) {
            [[[ZKHUserData alloc] init] updateUserName:user.uuid name:newName];
            changeNameBlock(true);
        }else{
            changeNameBlock(false);
        }
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

//修改密码
#define UPDATE_USER_PWD_URL @"/updateUserPwd"
- (void)changePwd:(ZKHUserEntity *)user newPwd:(NSString *)newPwd completionHander:(ChangeFieldResponseBlock)changePwdBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = UPDATE_USER_PWD_URL;
    request.method = METHOD_PUT;
    request.params = @{KEY_UUID: user.uuid, KEY_PWD :newPwd};
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        if ([[jsonObject valueForKey:KEY_UUID] length] > 0) {
            [[[ZKHUserData alloc] init] updateUserPwd:user.uuid pwd:newPwd];
            
            ZKHEnvData *envData = [[ZKHEnvData alloc] init];            
            NSMutableDictionary *env = [envData getLoginEnv:user.phone];
            [env setValue:newPwd forKey:KEY_PWD];
            [envData saveLoginEnv:user.phone value:env];
            
            changePwdBlock(true);
        }else{
            changePwdBlock(false);
        }
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

@end
