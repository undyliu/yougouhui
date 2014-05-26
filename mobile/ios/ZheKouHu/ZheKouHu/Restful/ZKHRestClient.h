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

@interface ZKHRestClient : MKNetworkEngine
{
    MBProgressHUD *hud;
    ZKHRequestSigner *signer;
}

- (id)initWithDefaultSettings;

typedef void (^JsonResponseBlock)(id jsonObject);
- (void) executeWithJsonResponse:(ZKHRestRequest *)request completionHandler:(JsonResponseBlock) responseBlock errorHandler:(RestResponseErrorBlock) errorBlock;

typedef void (^RestResponseBlock)(NSHTTPURLResponse* response, id jsonObject);
- (void) execute:(ZKHRestRequest *)request completionHandler:(RestResponseBlock) responseBlock errorHandler:(RestResponseErrorBlock) errorBlock;
@end
