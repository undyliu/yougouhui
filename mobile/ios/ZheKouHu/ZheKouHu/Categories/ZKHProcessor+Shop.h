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

- (void) changeShopName:(NSString *)uuid newName:(NSString *)newName completionHandler:(ChangeFieldResponseBlock) changeNameBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) changeShopDesc:(NSString *)uuid newDesc:(NSString *)newDesc completionHandler:(ChangeFieldResponseBlock) changeDescBlock errorHandler:(RestResponseErrorBlock) errorBlock;

typedef void (^ChangeTradesResponseBlock)(NSMutableArray *shopTrades);
- (void) changeShopTrades:(NSString *)uuid newTrades:(NSArray *)newTrades completionHandler:(ChangeTradesResponseBlock) changeTradesBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) changeShopEmpPwd:(NSString *)uuid userId:(NSString *)userId oldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd completionHandler:(ChangeFieldResponseBlock) changeShopEmpPwdBlock errorHandler:(RestResponseErrorBlock) errorBlock;

@end
