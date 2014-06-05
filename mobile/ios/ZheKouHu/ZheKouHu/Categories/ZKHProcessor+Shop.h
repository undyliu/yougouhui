//
//  ZKHProcessor+Shop.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-22.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHProcessor.h"
#import "ZKHEntity.h"

@interface ZKHProcessor (Shop)

typedef void (^LoginResponseBlock)(NSMutableDictionary *authObj);
- (void) loginShopByPhone: (NSString *) phone pwd:(NSString *)pwd completionHandler:(LoginResponseBlock) loginBlock errorHandler:(MKNKErrorBlock) errorBlock;

- (void) changeShopName:(NSString *)uuid newName:(NSString *)newName completionHandler:(BooleanResultResponseBlock) changeNameBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) changeShopDesc:(NSString *)uuid newDesc:(NSString *)newDesc completionHandler:(BooleanResultResponseBlock) changeDescBlock errorHandler:(RestResponseErrorBlock) errorBlock;

typedef void (^ChangeTradesResponseBlock)(NSMutableArray *shopTrades);
- (void) changeShopTrades:(NSString *)uuid newTrades:(NSArray *)newTrades completionHandler:(ChangeTradesResponseBlock) changeTradesBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) changeShopEmpPwd:(NSString *)uuid userId:(NSString *)userId oldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd completionHandler:(BooleanResultResponseBlock) changeShopEmpPwdBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) changeShopImage:(NSString *)uuid shopImage:(ZKHFileEntity *)shopImage completionHandler:(BooleanResultResponseBlock) changeShopImageBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) changeBusiLicense:(NSString *)uuid busiLicense:(ZKHFileEntity *)busiLicense completionHandler:(BooleanResultResponseBlock) changeBusiLicenseBlock errorHandler:(RestResponseErrorBlock) errorBlock;

typedef void (^ShopResponseBlock)(ZKHShopEntity *shop);
- (void) shop: (NSString *) uuid  completionHandler:(ShopResponseBlock) shopBlock errorHandler:(MKNKErrorBlock) errorBlock;

- (void) checkShopEmp: (NSString *) shopId userId:(NSString *)userId completionHandler:(BooleanResultResponseBlock) checkShopEmpBlock errorHandler:(MKNKErrorBlock) errorBlock;

typedef void (^ShopEmpsResponseBlock)(NSMutableArray *shopEmps);
- (void) shopEmps: (NSString *) shopId  completionHandler:(ShopEmpsResponseBlock) shopEmpsBlock errorHandler:(MKNKErrorBlock) errorBlock;

- (void) addShopEmps:(NSString *)shopId emps:(NSMutableArray *)emps completionHandler:(BooleanResultResponseBlock) addShopEmpsBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) deleteShopEmps:(NSString *)shopId emps:(NSMutableArray *)emps completionHandler:(BooleanResultResponseBlock) delShopEmpsBlock errorHandler:(RestResponseErrorBlock) errorBlock;

typedef void (^ShopsResponseBlock)(NSMutableArray *shops);
- (void) searchShop: (NSString *) searchWord  completionHandler:(ShopsResponseBlock) shopsBlock errorHandler:(MKNKErrorBlock) errorBlock;

- (void) setShopEmpPwd: (NSString *) shopId userId:(NSString *)userId pwd:(NSString *)pwd completionHandler:(BooleanResultResponseBlock) setShopEmpPwdBlock errorHandler:(MKNKErrorBlock) errorBlock;

- (void) registerShop: (ZKHShopEntity *) shop completionHandler:(BooleanResultResponseBlock) registerShopBlock errorHandler:(MKNKErrorBlock) errorBlock;
@end
