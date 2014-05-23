//
//  ZKHRestClient.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-23.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "MKNetworkEngine.h"
#import "ZKHRestRequest.h"

#define METHOD_GET @"GET"
#define METHOD_POST @"POST"
#define METHOD_PUT @"PUT"
#define METHOD_DELETE @"DELETE"

@interface ZKHRestClient : MKNetworkEngine

- (id)initWithDefaultSettings;

typedef void (^RestResponseBlock)(id jsonObject);
typedef void (^RestResponseErrorBlock)(NSError* error);
- (void) executeRestRequest:(ZKHRestRequest *)request completionHandler:(RestResponseBlock) responseBlock errorHandler:(RestResponseErrorBlock) errorBlock;

@end
