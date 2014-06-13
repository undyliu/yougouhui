//
//  ZKHRestClient.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-23.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "MKNetworkEngine.h"
#import "ZKHRestRequest.h"
#import "MBProgressHUD.h"
#import "ZKHRequestSigner.h"

typedef void (^JsonResponseBlock)(id jsonObject);
typedef void (^RestResponseBlock)(NSHTTPURLResponse* response, id jsonObject);

@interface ZKHRestClient : MKNetworkEngine
{
    MBProgressHUD *hud;
    ZKHRequestSigner *signer;
}

- (id)initWithDefaultSettings;


- (void) executeWithJsonResponse:(ZKHRestRequest *)request completionHandler:(JsonResponseBlock) responseBlock;

//带有reponse的远程服务访问，目前主要用于登录
- (void) execute:(ZKHRestRequest *)request completionHandler:(RestResponseBlock) responseBlock;

@end
