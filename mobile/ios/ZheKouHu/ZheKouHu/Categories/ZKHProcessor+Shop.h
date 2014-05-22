//
//  ZKHProcessor+Shop.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-22.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHProcessor.h"

@interface ZKHProcessor (Shop)

typedef void (^LoginResponseBlock)(NSMutableDictionary *authObj);
- (void) loginShopByPhone: (NSString *) phone pwd:(NSString *)pwd completionHandler:(LoginResponseBlock) loginBlock errorHandler:(MKNKErrorBlock) errorBlock;

@end
