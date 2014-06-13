//
//  ZKHRequestSigner.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-26.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZKHRestRequest.h"
#import "ZKHEntity.h"

typedef void (^RestResponseErrorBlock)(ZKHErrorEntity *error);

@interface ZKHRequestSigner : NSObject

typedef void (^authResponseBlock)(ZKHRestRequest *request);
- (void) authorize:(ZKHRestRequest *)request completionHandler:(authResponseBlock)authorizeBlock errorHandler:(RestResponseErrorBlock)errorBlock;

@end
