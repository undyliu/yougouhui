//
//  ZKHProcessor+User.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-21.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHProcessor.h"
#import "ZKHEntity.h"

@interface ZKHProcessor (User)

typedef void (^LoginResponseBlock)(NSMutableDictionary *authObj);
- (void) login: (NSString *) phone pwd:(NSString *)pwd completionHandler:(LoginResponseBlock) loginBlock errorHandler:(RestResponseErrorBlock) errorBlock;
- (void) remoteLogin: (NSString *) phone pwd:(NSString *)pwd completionHandler:(LoginResponseBlock) loginBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) saveLoginEnv:(NSString *)phone value:(NSMutableDictionary *) value;
- (NSMutableDictionary *) getLoginEnv:(NSString *)phone;
- (NSMutableDictionary *) getLastLoginEnv;
- (void) deleteLoginEnv: (NSString *)phone;

- (void) changeUserName:(ZKHUserEntity *)user newName:(NSString *)newName completionHandler:(BooleanResultResponseBlock) changeNameBlock errorHandler:(RestResponseErrorBlock) errorBlock;
- (void) changeUserPwd:(ZKHUserEntity *)user newPwd:(NSString *)newPwd completionHander:(BooleanResultResponseBlock) changePwdBlock errorHandler:(RestResponseErrorBlock) errorBlock;
- (void) changeUserPhoto:(ZKHUserEntity *)user newPhoto:(ZKHFileEntity *)newPhoto completionHander:(BooleanResultResponseBlock) changePhotoBlock errorHandler:(RestResponseErrorBlock) errorBlock;

typedef void (^RegisterUserResponseBlock)(ZKHUserEntity *user);
- (void) registerUser:(ZKHUserEntity *)user completionHandler:(RegisterUserResponseBlock) resgisterUserBlock errorHandler:(RestResponseErrorBlock) errorBlock;

typedef void (^FriendsResponseBlock)(NSMutableArray *friends);
- (void) friends:(NSString *) userId completionHandler:(FriendsResponseBlock) friendsBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) searchUsers:(NSString *) searchWord completionHandler:(FriendsResponseBlock) friendsBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) addFriend:(ZKHUserEntity *)user uFriend:(ZKHUserEntity *)uFriend completionHander:(BooleanResultResponseBlock) addFriendBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) deleteFriend:(NSString *)userId friendId:(NSString *)friendId completionHander:(BooleanResultResponseBlock) delFriendBlock errorHandler:(RestResponseErrorBlock) errorBlock;

@end
