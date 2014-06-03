//
//  ZKHProcessor+Share.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-3.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHProcessor.h"
#import "ZKHEntity.h"

@interface ZKHProcessor (Share)

- (void) publishShare:(ZKHShareEntity *)share completionHandler:(BooleanResultResponseBlock) publishShareBlock errorHandler:(RestResponseErrorBlock) errorBlock;

@end
