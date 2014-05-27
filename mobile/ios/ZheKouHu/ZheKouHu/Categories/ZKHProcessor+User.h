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

- (void) changeUserName:(ZKHUserEntity *)user newName:(NSString *)newName completionHandler:(ChangeFieldResponseBlock) changeNameBlock errorHandler:(RestResponseErrorBlock) errorBlock;
- (void) changeUserPwd:(ZKHUserEntity *)user newPwd:(NSString *)newPwd completionHander:(ChangeFieldResponseBlock) changePwdBlock errorHandler:(RestResponseErrorBlock) errorBlock;
- (void) changeUserPhoto:(ZKHUserEntity *)user newPhoto:(ZKHFileEntity *)newPhoto completionHander:(ChangeFieldResponseBlock) changePhotoBlock errorHandler:(RestResponseErrorBlock) errorBlock;

@end
