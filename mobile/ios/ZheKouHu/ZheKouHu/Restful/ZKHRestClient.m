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
#import "TSMessage.h"

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

- (void)executeWithJsonResponse:(ZKHRestRequest *)request completionHandler:(JsonResponseBlock)responseBlock 
{
    [self doExcute:request jsonResponseBlock:responseBlock restResponseBlock:nil];
}

- (void)execute:(ZKHRestRequest *)request completionHandler:(RestResponseBlock)responseBlock
{
    [self doExcute:request jsonResponseBlock:nil restResponseBlock:responseBlock];
}

- (void) doExcute:(ZKHRestRequest *)request jsonResponseBlock:(JsonResponseBlock)jsonResponseBlock restResponseBlock:(RestResponseBlock)restResponseBlock
{
    [self showHud];
    
    @try {
        [signer authorize:request completionHandler:^(ZKHRestRequest *request) {
            MKNetworkOperation *op = [self createMKNetworkOperation:request];
            if (op == nil) {
                return;
            }
            
            [self addFiles:op NSArray:request.files];
            
            [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
                [self hideHud];
                
                [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
                    if (restResponseBlock) {
                        restResponseBlock([completedOperation readonlyResponse], jsonObject);
                    }else{
                        jsonResponseBlock(jsonObject);
                    }
                }];
            } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
                [self hideHud];
                [self showNetworkErrorMessage];
                //将error放到返回值中
            }];
            
            [self enqueueOperation:op];
        }];
    }
    @catch (NSException *exception) {
        [self showRuntimeErrorMessage];//TODO
        [self hideHud];
    }
    @finally {
    }
}

- (void) showHud 
{
    if (hud == nil) {
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        hud.labelText = @"正在处理...";
    }else if (hud.isHidden){
        [hud show:YES];
    }
}

- (void) hideHud
{
    [hud hide:YES];
}

- (void) showNetworkErrorMessage
{
    [TSMessage showNotificationWithTitle:@"网络错误" subtitle:@"连接远程服务器失败，请检查网络连接." type:TSMessageNotificationTypeError];
}

- (void) showRuntimeErrorMessage
{
    [TSMessage showNotificationWithTitle:@"错误" subtitle:@"系统运行异常." type:TSMessageNotificationTypeError];
}
@end
