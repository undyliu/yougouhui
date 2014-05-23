//
//  ZKHRestClient.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-23.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHRestClient.h"
#import "ZKHConst.h"

@implementation ZKHRestClient

- (id)initWithDefaultSettings
{
    if(self = [super initWithHostName:SERVER_BASE_URL customHeaderFields:@{@"x-client-identifier" : @"iOS"}]) {
    }
    return self;
}

- (void)executeRestRequest:(ZKHRestRequest *)request completionHandler:(RestResponseBlock)responseBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    NSString *urlString = request.urlString;
    //TODO:对urlString进行判断：是否是path或者url
    MKNetworkOperation *op = [self operationWithPath:urlString params:request.params httpMethod:request.method];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            responseBlock(jsonObject);
        }];
    } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];
}

@end
