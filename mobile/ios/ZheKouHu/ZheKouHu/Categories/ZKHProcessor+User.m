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
#import "NSString+Utils.h"

@implementation ZKHProcessor (User)

//登录
#define LOGIN_URL @"/login"
- (void)login:(NSString *)phone pwd:(NSString *)pwd completionHandler:(LoginResponseBlock)loginBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHUserData *data = [[ZKHUserData alloc] init];
    ZKHUserEntity *user = [data user:phone];
    if ([pwd isEqualToString:user.pwd]) {
        [self friends:user.uuid completionHandler:^(NSMutableArray *friends) {
            user.friends = friends;
        } errorHandler:^(NSError *error) {
            
        }];
        
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
            [ZKHContext getInstance].sessionId = cookieValue;
        }
        
        NSMutableDictionary *authedObj = [[NSMutableDictionary alloc] init];
        Boolean authed = [[jsonObject valueForKey:KEY_AUTHED] boolValue];
        switch (authed) {
            case 1:
            {
                NSDictionary *userJson = [jsonObject valueForKey:KEY_USER];
                
                ZKHUserEntity *user = [[ZKHUserEntity alloc] initWithJsonObject:userJson noPwd:false];
                
                [[[ZKHUserData alloc] init] save:@[user]];
                
                [authedObj setObject:user forKey:KEY_USER];
                [authedObj setObject:@"true" forKey:KEY_AUTHED];
                
                [ZKHContext getInstance].shouldRelogin = false;
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
    return [[[ZKHEnvData alloc] init] loginEnv:phone];
}

- (NSMutableDictionary *)getLastLoginEnv
{
    return [[[ZKHEnvData alloc] init] lastLoginEnv];
}

- (void)deleteLoginEnv:(NSString *)phone
{
    [[[ZKHEnvData alloc] init] deleteLoginEnv:phone];
}

//修改昵称
#define UPDATE_USER_NAME_URL @"/updateUserName"
- (void)changeUserName:(ZKHUserEntity *)user newName:(NSString *)newName completionHandler:(BooleanResultResponseBlock)changeNameBlock errorHandler:(RestResponseErrorBlock)errorBlock
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
- (void)changeUserPwd:(ZKHUserEntity *)user newPwd:(NSString *)newPwd completionHander:(BooleanResultResponseBlock)changePwdBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = UPDATE_USER_PWD_URL;
    request.method = METHOD_PUT;
    request.params = @{KEY_UUID: user.uuid, KEY_PWD :newPwd};
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        if ([[jsonObject valueForKey:KEY_UUID] length] > 0) {
            [[[ZKHUserData alloc] init] updateUserPwd:user.uuid pwd:newPwd];
            
            ZKHEnvData *envData = [[ZKHEnvData alloc] init];            
            NSMutableDictionary *env = [envData loginEnv:user.phone];
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

//修改头像
#define UPDATE_USER_PHOTO_URL @"/saveUserPhoto"
- (void)changeUserPhoto:(ZKHUserEntity *)user newPhoto:(ZKHFileEntity *)newPhoto completionHander:(BooleanResultResponseBlock)changePhotoBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = UPDATE_USER_PHOTO_URL;
    request.method = METHOD_POST;
    request.files = @[newPhoto];
    request.params = @{KEY_UUID: user.uuid, KEY_PHOTO: newPhoto.aliasName};
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        if ([[jsonObject valueForKey:KEY_UUID] length] > 0) {
            [[[ZKHUserData alloc] init] updateUserPhoto:user.uuid photo:newPhoto.aliasName];
            changePhotoBlock(true);
        }else{
            changePhotoBlock(false);
        }
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

//会员注册
#define REGISTER_USER_URL @"/registerUser"
- (void)registerUser:(ZKHUserEntity *)user completionHandler:(RegisterUserResponseBlock)resgisterUserBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.method = METHOD_POST;
    request.urlString = REGISTER_USER_URL;
    
    if (user.photo != nil) {
        request.files = @[user.photo];
    }
    
    request.params = @{KEY_PHONE: user.phone, KEY_NAME: user.name, KEY_PWD: user.pwd, KEY_TYPE: user.type};
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSString *uuid = [jsonObject valueForKey:KEY_UUID];
        if (uuid != nil) {
            user.uuid = uuid;
            user.registerTime = [jsonObject valueForKey:KEY_REGISTER_TIME];
            
            [[[ZKHUserData alloc] init] save:@[user]];
            
            resgisterUserBlock(user);
        }else{
            resgisterUserBlock(nil);
        }
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

//获取朋友列表
#define GET_FRIENDS_URL(__USER_ID__) [NSString stringWithFormat:@"/getFriends/%@", __USER_ID__]
- (void)friends:(NSString *)userId completionHandler:(FriendsResponseBlock) friendsBlock errorHandler:(RestResponseErrorBlock) errorBlock
{
    ZKHUserData *userData = [[ZKHUserData alloc] init];
    NSMutableArray *friends = [userData friends:userId];
    if ([friends count] > 0) {
        friendsBlock(friends);
        return;
    }
    
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.method = METHOD_GET;
    request.urlString = GET_FRIENDS_URL(userId);
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSMutableArray *userFriends = [[NSMutableArray alloc] init];
        if ([jsonObject count] > 0) {
            for (id jsonUserFriend in jsonObject) {
                ZKHUserFriendsEntity *userFriend = [[ZKHUserFriendsEntity alloc] init];
                userFriend.uuid = [jsonUserFriend valueForKey:KEY_UUID];

                id userJson = [jsonUserFriend valueForKey:KEY_USER];
                ZKHUserEntity *user = [[ZKHUserEntity alloc] initWithJsonObject:userJson noPwd:true];
                
                userFriend.friend = user;
                
                [userFriends addObject:userFriend];
            }
            
            [userData saveFriends:userId friends:[userFriends copy]];
        }
        friendsBlock(userFriends);
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

//搜索用户
#define SEARCH_USERS_URL @"/searchUsers"
- (void)searchUsers:(NSString *)searchWord completionHandler:(FriendsResponseBlock)friendsBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = SEARCH_USERS_URL;
    request.method = METHOD_POST;
    request.params = @{KEY_SEARCH_WORD: searchWord};
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSMutableArray *users = [[NSMutableArray alloc] init];
        for (id userJson in jsonObject) {
            ZKHUserEntity *user = [[ZKHUserEntity alloc] initWithJsonObject:userJson noPwd:true];
            
            [users addObject:user];
        }
        friendsBlock(users);
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

//添加朋友
#define ADD_FRIEND_URL @"/addFriend"
- (void)addFriend:(ZKHUserEntity *)user uFriend:(ZKHUserEntity *)uFriend completionHander:(BooleanResultResponseBlock)addFriendBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = ADD_FRIEND_URL;
    request.method = METHOD_POST;
    request.params = @{KEY_FRIEND_ID: uFriend.uuid, KEY_USER_ID: user.uuid};
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSString *uuid = [jsonObject valueForKey:KEY_UUID];
        if (uuid != nil) {
            ZKHUserFriendsEntity *userFriend = [[ZKHUserFriendsEntity alloc] init];
            userFriend.uuid = uuid;
            userFriend.friend = uFriend;
            
            [[[ZKHUserData alloc] init] saveFriends:user.uuid friends:@[userFriend]];
            [user.friends addObject:userFriend];
            
            addFriendBlock(true);
        }else{
            addFriendBlock(false);
        }
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

//删除朋友
#define DEL_FRIEND_URL @"/deleteFriend"
- (void)deleteFriend:(NSString *)userId friendId:(NSString *)friendId completionHander:(BooleanResultResponseBlock)delFriendBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = [NSString stringWithFormat:@"%@/%@/%@", DEL_FRIEND_URL, [userId mk_urlEncodedString], [friendId mk_urlEncodedString]];
    request.method = METHOD_DELETE;
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSString *uuid = [jsonObject valueForKey:KEY_UUID];
        if ([NSString isNull:uuid]) {
            delFriendBlock(false);
        }else{
            [[[ZKHUserData alloc] init] deleteFriend:userId friendId:friendId];
            delFriendBlock(true);
        }
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

@end
