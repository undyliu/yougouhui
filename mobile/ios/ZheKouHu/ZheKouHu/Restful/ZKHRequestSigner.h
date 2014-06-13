//
//  ZKHRequestSigner.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-26.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZKHRestRequest.h"

@interface ZKHRequestSigner : NSObject

typedef void (^authResponseBlock)(ZKHRestRequest *request);
typedef void (^RestResponseErrorBlock)(NSError* error);
- (void) authorize:(ZKHRestRequest *)request completionHandler:(authResponseBlock)authorizeBlock;

@end
