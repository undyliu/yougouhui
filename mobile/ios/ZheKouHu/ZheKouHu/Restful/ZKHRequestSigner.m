//
//  ZKHRequestSigner.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-26.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHRequestSigner.h"
#import "ZKHContext.h"
#import "ZKHProcessor+User.h"
#import "ZKHConst.h"
#import "ZKHAppDelegate.h"
#import "ZKHEntity.h"
#import "NSString+Utils.h"

@implementation ZKHRequestSigner

- (void)authorize:(ZKHRestRequest *)request completionHandler:(authResponseBlock)authorizeBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    NSString *method = request.method;
    NSString *urlString = request.urlString;
    if (([method isEqualToString:METHOD_GET]
        //&& [[ZKHContext getInstance] isAnonymousUserLogined]
         )
         || [urlString hasSuffix:@"/login"]
        || [urlString hasSuffix:@"/registerUser"]
        || [urlString hasPrefix:@"/loginShop"]
        || [urlString hasSuffix:@"/registerShop"]) {
        authorizeBlock(request);
        return;
    }
    
    ZKHContext *context = [ZKHContext getInstance];
    NSString *sessionId = context.sessionId;
    if (sessionId == nil) {
        ZKHUserEntity *user = context.user;
        [ApplicationDelegate.zkhProcessor remoteLogin:user.phone pwd:user.pwd completionHandler:^(NSMutableDictionary *authObj) {
            NSString *sessionId = context.sessionId;
            if (sessionId != nil) {
                [request addHeader:@"cookie" value:sessionId];
                authorizeBlock(request);
            }else{
                //TODO:
            }
        } errorHandler:^(NSError *error) {
            errorBlock(error);
        }];
    }else{
        authorizeBlock(request);
    }
}

@end
