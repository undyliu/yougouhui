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
- (void) loginShopByPhone: (NSString *) phone pwd:(NSString *)pwd completionHandler:(LoginResponseBlock) loginBlock ;

- (void) changeShopName:(NSString *)uuid newName:(NSString *)newName completionHandler:(BooleanResultResponseBlock) changeNameBlock ;

- (void) changeShopDesc:(NSString *)uuid newDesc:(NSString *)newDesc completionHandler:(BooleanResultResponseBlock) changeDescBlock ;

typedef void (^ChangeTradesResponseBlock)(NSMutableArray *shopTrades);
- (void) changeShopTrades:(NSString *)uuid newTrades:(NSArray *)newTrades completionHandler:(ChangeTradesResponseBlock) changeTradesBlock ;

- (void) changeShopEmpPwd:(NSString *)uuid userId:(NSString *)userId oldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd completionHandler:(BooleanResultResponseBlock) changeShopEmpPwdBlock ;

- (void) changeShopImage:(NSString *)uuid shopImage:(ZKHFileEntity *)shopImage completionHandler:(BooleanResultResponseBlock) changeShopImageBlock ;

- (void) changeBusiLicense:(NSString *)uuid busiLicense:(ZKHFileEntity *)busiLicense completionHandler:(BooleanResultResponseBlock) changeBusiLicenseBlock ;

typedef void (^ShopResponseBlock)(ZKHShopEntity *shop);
- (void) shop: (NSString *) uuid  completionHandler:(ShopResponseBlock) shopBlock ;

- (void) checkShopEmp: (NSString *) shopId userId:(NSString *)userId completionHandler:(BooleanResultResponseBlock) checkShopEmpBlock ;

typedef void (^ShopEmpsResponseBlock)(NSMutableArray *shopEmps);
- (void) shopEmps: (NSString *) shopId  completionHandler:(ShopEmpsResponseBlock) shopEmpsBlock ;

- (void) addShopEmps:(NSString *)shopId emps:(NSMutableArray *)emps completionHandler:(BooleanResultResponseBlock) addShopEmpsBlock ;

- (void) deleteShopEmps:(NSString *)shopId emps:(NSMutableArray *)emps completionHandler:(BooleanResultResponseBlock) delShopEmpsBlock ;

typedef void (^ShopsResponseBlock)(NSMutableArray *shops);
- (void) searchShop: (NSString *) searchWord  completionHandler:(ShopsResponseBlock) shopsBlock ;

- (void) setShopEmpPwd: (NSString *) shopId userId:(NSString *)userId pwd:(NSString *)pwd completionHandler:(BooleanResultResponseBlock) setShopEmpPwdBlock ;

- (void) registerShop: (ZKHShopEntity *) shop completionHandler:(BooleanResultResponseBlock) registerShopBlock ;
@end
