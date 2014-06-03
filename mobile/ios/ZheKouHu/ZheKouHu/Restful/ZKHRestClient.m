//
//  ZKHRestClient.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-23.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHRestClient.h"
#import "ZKHConst.h"
#import "ZKHEntity.h"

@implementation ZKHRestClient

- (id)initWithDefaultSettings
{
    if(self = [super initWithHostName:SERVER_BASE_URL customHeaderFields:@{@"x-client-identifier" : @"iOS"}]) {
        signer = [[ZKHRequestSigner alloc] init];
    }
    return self;
}

- (MKNetworkOperation *) createMKNetworkOperation:(ZKHRestRequest *)request
{
    NSArray *files = request.files;
    NSMutableString *fileNames = [NSMutableString stringWithString:@""];
    for (ZKHFileEntity *file in files) {
        [fileNames appendFormat:@"%@|", file.aliasName];
    }
    
    NSMutableDictionary *params = [request.params mutableCopy];
    [params setObject:fileNames forKey:KEY_FILE_NAME_LIST];
    
    NSString *urlString = [request.urlString lowercaseString];
    MKNetworkOperation *op = nil;
    if ([urlString hasPrefix:@"http://"] || [urlString hasPrefix:@"https://"]) {
        op = [self operationWithURLString:request.urlString params:params httpMethod:request.method];
    }else{
        op = [self operationWithPath:request.urlString params:params httpMethod:request.method];
    }
    
    if (op != nil) {
        NSMutableDictionary *headers = request.headers;
        [op addHeaders:[NSDictionary dictionaryWithDictionary:headers]];
    }
    return op;
}

- (void) addFiles:(MKNetworkOperation *)op NSArray:(NSArray *)files
{
    for (ZKHFileEntity *file in files) {
        [op addFile:file.fileUrl forKey:file.aliasName];
    }
}

- (void)executeWithJsonResponse:(ZKHRestRequest *)request completionHandler:(JsonResponseBlock)responseBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    if (hud == nil) {
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        hud.labelText = @"正在处理...";
    }else{
        [hud show:YES];
    }
    
    [signer authorize:request completionHandler:^(ZKHRestRequest *request) {
        MKNetworkOperation *op = [self createMKNetworkOperation:request];
        if (op == nil) {
            return;
        }
        
        [self addFiles:op NSArray:request.files];
        
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
                [hud hide:YES];
                responseBlock(jsonObject);
            }];
        } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
            [hud hide:YES];
            errorBlock(error);
        }];
        
        [self enqueueOperation:op];
    } errorHandler:^(NSError *error) {
        
    }];
    
}

- (void)execute:(ZKHRestRequest *)request completionHandler:(RestResponseBlock)responseBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    [signer authorize:request completionHandler:^(ZKHRestRequest *request) {
        MKNetworkOperation *op = [self createMKNetworkOperation:request];
        if (op == nil) {
            return;
        }
        
        [self addFiles:op NSArray:request.files];
        
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
                responseBlock([completedOperation readonlyResponse], jsonObject);
            }];
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            errorBlock(error);
        }];
        
        [self enqueueOperation:op];
    } errorHandler:^(NSError *error) {
        
    }];
}
@end
