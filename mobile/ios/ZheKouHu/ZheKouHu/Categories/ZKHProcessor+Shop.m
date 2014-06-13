//
//  ZKHProcessor+Shop.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-22.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHProcessor+Shop.h"
#import "ZKHConst.h"
#import "ZKHEntity.h"
#import "ZKHData.h"
#import "NSString+Utils.h"
#import "ZKHContext.h"
#import "ZKHConst.h"

@implementation ZKHProcessor (Shop)

//登录商铺
#define LOGIN_URL @"/loginShopByPhone"
- (void)loginShopByPhone:(NSString *)phone pwd:(NSString *)pwd completionHandler:(LoginResponseBlock)loginBlock 
{
    NSDictionary *params = @{KEY_PHONE : phone, KEY_PWD : pwd};
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = LOGIN_URL;
    request.params = params;
    request.method = METHOD_POST;
    
    [restClient execute:request completionHandler:^(NSHTTPURLResponse *response, id jsonObject) {
        NSString *cookieValue = [[response allHeaderFields] valueForKey:KET_SET_COOKIE];
        if (cookieValue != nil) {
            [ZKHContext getInstance].sessionId = cookieValue;
        }
        
        NSMutableDictionary *authedObj = [[NSMutableDictionary alloc] init];
        Boolean authed = [[jsonObject valueForKey:KEY_AUTHED] boolValue];
        switch (authed) {
            case 1:
            {
                NSDictionary *userJson = [jsonObject valueForKey:KEY_USER];
                
                ZKHUserEntity *user = [[ZKHUserEntity alloc] init];
                user.uuid = [userJson valueForKey:KEY_UUID];
                user.name = [userJson valueForKey:KEY_NAME];
                //user.pwd = [userJson valueForKey:KEY_PWD];密码和类别未返回
                //user.type = [userJson valueForKey:KEY_TYPE];
                user.pwd = pwd;
                user.type = VAL_TYPE_USER_APP;
                user.phone = [userJson valueForKey:KEY_PHONE];
                
                user.photo = [[ZKHFileEntity alloc] init];
                user.photo.aliasName = [userJson valueForKey:KEY_PHOTO];
                
                user.registerTime = [userJson valueForKey:KEY_REGISTER_TIME];
                
                NSMutableArray * shops = [[NSMutableArray alloc] init];
                id shopList = [jsonObject valueForKey:KEY_DATA];
                for (NSDictionary *jsonShop in shopList) {
                    [shops addObject:[[ZKHShopEntity alloc] initWithJsonObject:jsonShop]];
                }
                
                [[[ZKHShopData alloc] init] save:shops];
                
                [authedObj setObject:shops forKey:KEY_SHOP_LIST];
                [authedObj setObject:user forKey:KEY_USER];
                [authedObj setObject:@"true" forKey:KEY_AUTHED];
            }
                break;
                
            default:
            {
                [authedObj setObject:[jsonObject valueForKey:KEY_ERROR_TYPE] forKey:KEY_ERROR_TYPE];
                [authedObj setObject:@"false" forKey:KEY_AUTHED];
            }
                break;
        }
        
        loginBlock(authedObj);
    } ];
}

//修改商铺简介
#define UPDATE_SHOP_URL @"/updateShop"
- (void)changeShopDesc:(NSString *)uuid newDesc:(NSString *)newDesc completionHandler:(BooleanResultResponseBlock)changeDescBlock 
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.method = METHOD_POST;
    request.urlString = UPDATE_SHOP_URL;
    request.params = @{KEY_SHOP_ID: uuid, KEY_FIELD: KEY_DESC, KEY_VALUE: newDesc};
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        if ([[jsonObject valueForKey:KEY_UUID] length] > 0) {
            [[[ZKHShopData alloc] init] updateShopDesc:uuid desc:newDesc];
            changeDescBlock(true);
        }else{
            changeDescBlock(false);
        }
    } ];
}

-(void)changeShopName:(NSString *)uuid newName:(NSString *)newName completionHandler:(BooleanResultResponseBlock)changeNameBlock 
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.method = METHOD_POST;
    request.urlString = UPDATE_SHOP_URL;
    request.params = @{KEY_SHOP_ID: uuid, KEY_FIELD: KEY_NAME, KEY_VALUE: newName};
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        if ([[jsonObject valueForKey:KEY_UUID] length] > 0) {
            [[[ZKHShopData alloc] init] updateShopName:uuid name:newName];
            changeNameBlock(true);
        }else{
            changeNameBlock(false);
        }
    } ];
}

#define UPDATE_SHOP_TRADES_URL @"/updateShopTrades"
- (void)changeShopTrades:(NSString *)uuid newTrades:(NSArray *)newTrades completionHandler:(ChangeTradesResponseBlock)changeTradesBlock 
{
    NSMutableString *tradeString = [NSMutableString stringWithString:@""];
    for (int i = 0; i < [newTrades count]; i++) {
        if (i == 0) {
            [tradeString appendString:newTrades[i]];
        }else{
            [tradeString appendFormat:@"|%@", newTrades[i]];
        }
    }
    
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = UPDATE_SHOP_TRADES_URL;
    request.method = METHOD_PUT;
    request.params = @{KEY_SHOP_ID: uuid, KEY_TRADE_LIST: tradeString};
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        id jsonTrades = [jsonObject valueForKey:KEY_TRADE_LIST];
        if ([jsonTrades count] > 0) {
            NSMutableArray *shopTrades = [[NSMutableArray alloc] init];
            for (id jsonShopTrade in jsonTrades) {
                ZKHTradeEntity *trade = [[ZKHTradeEntity alloc] init];
                trade.uuid = [jsonShopTrade valueForKey:KEY_TRADE_ID];
                ZKHShopTradeEntity *shopTrade = [[ZKHShopTradeEntity alloc] init];
                shopTrade.uuid = [jsonShopTrade valueForKey:KEY_UUID];
                shopTrade.trade = trade;
                
                [shopTrades addObject:shopTrade];
            }
            
            ZKHShopData *shopData  = [[ZKHShopData alloc] init];
            [shopData updateshopTrades:uuid trades:[[NSArray alloc] initWithArray:shopTrades]];
            
            changeTradesBlock([shopData shopTrades:uuid]);
        }
    } ];
}

#define UPDATE_SHOP_EMP_PWD_URL @"/updateShopEmpPwd"
- (void)changeShopEmpPwd:(NSString *)uuid userId:(NSString *)userId oldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd completionHandler:(BooleanResultResponseBlock)changeShopEmpPwdBlock 
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.method = METHOD_PUT;
    request.urlString = UPDATE_SHOP_EMP_PWD_URL;
    request.params = @{KEY_SHOP_ID: uuid, KEY_USER_ID :userId, KEY_OLD_PWD :oldPwd, KEY_PWD :newPwd};
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSString *errorType = [jsonObject valueForKey:KEY_ERROR_TYPE];
        if (errorType == nil) {
            changeShopEmpPwdBlock(true);
        }else{
            changeShopEmpPwdBlock(false);
        }
    } ];
}

- (void)changeShopImage:(NSString *)uuid shopImage:(ZKHFileEntity *)shopImage completionHandler:(BooleanResultResponseBlock)changeShopImageBlock 
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.method = METHOD_POST;
    request.urlString = UPDATE_SHOP_URL;
    request.files = @[shopImage];
    request.params = @{KEY_SHOP_ID: uuid, KEY_FIELD: KEY_SHOP_IMG, KEY_VALUE: shopImage.aliasName};
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        if ([[jsonObject valueForKey:KEY_UUID] length] > 0) {
            [[[ZKHShopData alloc] init] updateShopImage:uuid shopImage:shopImage.aliasName];
            changeShopImageBlock(true);
        }else{
            changeShopImageBlock(false);
        }
    } ];

}

- (void)changeBusiLicense:(NSString *)uuid busiLicense:(ZKHFileEntity *)busiLicense completionHandler:(BooleanResultResponseBlock)changeBusiLicenseBlock 
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.method = METHOD_POST;
    request.urlString = UPDATE_SHOP_URL;
    request.files = @[busiLicense];
    request.params = @{KEY_SHOP_ID: uuid, KEY_FIELD: KEY_BUSI_LICENSE, KEY_VALUE: busiLicense.aliasName};
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        if ([[jsonObject valueForKey:KEY_UUID] length] > 0) {
            [[[ZKHShopData alloc] init] updateBusiLicense:uuid busiLicense:busiLicense.aliasName];
            changeBusiLicenseBlock(true);
        }else{
            changeBusiLicenseBlock(false);
        }
    } ];
}

#define  GET_SHOP_URL(__SHOP_ID__) [NSString stringWithFormat:@"/getShop/%@", __SHOP_ID__]
- (void)shop:(NSString *)uuid completionHandler:(ShopResponseBlock)shopBlock
{
    ZKHShopData *shopData = [[ZKHShopData alloc] init];
    ZKHShopEntity *shop = [shopData shop:uuid];
    if (shop != nil) {
        shopBlock(shop);
        return;
    }
    
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = GET_SHOP_URL(uuid);
    request.method = METHOD_GET;
    
    [restClient execute:request completionHandler:^(NSHTTPURLResponse *response, id jsonObject) {
        NSString *uuid = [jsonObject valueForKey:KEY_UUID];
        if ([NSString isNull:uuid]) {
            shopBlock(nil);
        }
        shopBlock([[ZKHShopEntity alloc] initWithJsonObject:jsonObject]);
    } ];
}

#define  CHECK_SHOP_EMP_URL(__SHOP_ID__,__USER_ID__) [NSString stringWithFormat:@"/checkShopEmp/%@/%@", __SHOP_ID__, __USER_ID__]
- (void)checkShopEmp:(NSString *)shopId userId:(NSString *)userId completionHandler:(BooleanResultResponseBlock)checkShopEmpBlock 
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.method = METHOD_GET;
    request.urlString = CHECK_SHOP_EMP_URL(shopId, userId);
    
    [restClient execute:request completionHandler:^(NSHTTPURLResponse *response, id jsonObject) {
        NSString *uuid = [jsonObject valueForKey:KEY_UUID];
        if ([NSString isNull:uuid]) {
            checkShopEmpBlock(false);
        }else{
            checkShopEmpBlock(true);
        }
    } ];
}

//获取商铺职员列表
#define  GET_SHOP_EMPS_URL(__SHOP_ID__) [NSString stringWithFormat:@"/getShopEmps/%@", __SHOP_ID__]
- (void)shopEmps:(NSString *)shopId completionHandler:(ShopEmpsResponseBlock)shopEmpsBlock 
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = GET_SHOP_EMPS_URL(shopId);
    request.method = METHOD_GET;
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSMutableArray *emps = [[NSMutableArray alloc] init];
        for (id jsonEmp in jsonObject) {
            ZKHUserEntity *emp = [[ZKHUserEntity alloc] initWithJsonObject:jsonEmp noPwd:false];
            [emps addObject:emp];
        }
        shopEmpsBlock(emps);
    } ];
}

//添加商铺职员
#define ADD_SHOP_EMPS_URL  @"/addShopEmps"
- (void)addShopEmps:(NSString *)shopId emps:(NSMutableArray *)emps completionHandler:(BooleanResultResponseBlock)addShopEmpsBlock 
{
    NSMutableString *empIds = [[NSMutableString alloc] init];
    for (ZKHUserEntity *emp in emps) {
        [empIds appendFormat:@"|%@", emp.uuid];
    }
    
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = ADD_SHOP_EMPS_URL;
    request.method = METHOD_POST;
    request.params = @{KEY_SHOP_ID: shopId, KEY_EMPS: [empIds substringFromIndex:1]};
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSString *uuid = jsonObject[KEY_UUID];
        if ([NSString isNull:uuid]) {
            addShopEmpsBlock(false);
        }else{
            addShopEmpsBlock(true);
        }
    } ];
}

//删除商铺职员
#define DEL_SHOP_EMPS_URL(__SHOP_ID__, __EMP_IDS__) [NSString stringWithFormat:@"/deleteShopEmps/%@/%@", __SHOP_ID__, __EMP_IDS__]
- (void)deleteShopEmps:(NSString *)shopId emps:(NSMutableArray *)emps completionHandler:(BooleanResultResponseBlock)delShopEmpsBlock 
{
    NSMutableString *empIds = [[NSMutableString alloc] init];
    for (ZKHUserEntity *emp in emps) {
        [empIds appendFormat:@"|%@", emp.uuid];
    }
    
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = DEL_SHOP_EMPS_URL(shopId, [empIds substringFromIndex:1]);
    request.method = METHOD_DELETE;
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSString *uuid = jsonObject[KEY_UUID];
        if ([NSString isNull:uuid]) {
            delShopEmpsBlock(false);
        }else{
            delShopEmpsBlock(true);
        }
    }];
}

//搜索商铺
#define SEARCH_SHOPS_URL @"/searchShops"
- (void)searchShop:(NSString *)searchWord completionHandler:(ShopsResponseBlock)shopsBlock 
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.method = METHOD_POST;
    request.urlString = SEARCH_SHOPS_URL;
    request.params = @{KEY_SEARCH_WORD: searchWord};
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSMutableArray *shops = [[NSMutableArray alloc] init];
        for (id jsonShop in jsonObject) {
            ZKHShopEntity *shop = [[ZKHShopEntity alloc] init];
            shop.uuid = jsonShop[KEY_UUID];
            shop.name = jsonShop[KEY_NAME];
            
            shop.shopImg = [[ZKHFileEntity alloc] init];
            shop.shopImg.aliasName = jsonShop[KEY_SHOP_IMG];
            
            shop.owner = jsonShop[KEY_OWNER];
            
            shop.barcode = [[ZKHFileEntity alloc] init];
            shop.barcode.aliasName = jsonShop[KEY_BARCODE];
            
            [shops addObject:shop];
        }
        shopsBlock(shops);
    } ];
}

//设置职员密码
#define SET_SHOP_EMP_PWD_URL @"/setShopEmpPwd"
- (void)setShopEmpPwd:(NSString *)shopId userId:(NSString *)userId pwd:(NSString *)pwd completionHandler:(BooleanResultResponseBlock)setShopEmpPwdBlock {
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = SET_SHOP_EMP_PWD_URL;
    request.method = METHOD_PUT;
    request.params = @{KEY_SHOP_ID: shopId, KEY_USER_ID: userId, KEY_PWD: pwd};
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSString *pwd = jsonObject[KEY_PWD];
        if ([NSString isNull:pwd]) {
            setShopEmpPwdBlock(false);
        }else{
            setShopEmpPwdBlock(true);
        }
    } ];
}

//注册店铺
#define REGISTER_SHOP_URL @"/registerShop"
- (void)registerShop:(ZKHShopEntity *)shop completionHandler:(BooleanResultResponseBlock)registerShopBlock 
{    
    NSMutableString *tradeIds = [[NSMutableString alloc] init];
    for (ZKHShopTradeEntity *shopTrade in shop.trades) {
        [tradeIds appendFormat:@"|%@",shopTrade.trade.uuid];
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary: @{KEY_NAME: shop.name, KEY_DESC: shop.desc, KEY_ADDR: shop.addr, KEY_SHOP_IMG: shop.shopImg.aliasName, KEY_BUSI_LICENSE: shop.busiLicense.aliasName}];
    
    [params setObject:[tradeIds substringFromIndex:1] forKey:KEY_TRADE_LIST];
    
    ZKHUserEntity *emp = shop.employees[0];
    if (shop.owner) {
        [params setObject:shop.owner forKey:KEY_OWNER];
        [params setObject:emp.pwd forKey:KEY_PWD];
    }else{
        [params setObject:emp.pwd forKey:KEY_PWD];
        [params setObject:emp.phone forKey:KEY_PHONE];
        [params setObject:emp.name forKey:KEY_USER_NAME];
    }
    
    [params setObject:[shop.location toString] forKey:KEY_LOCATION];
    
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = REGISTER_SHOP_URL;
    request.method = METHOD_POST;
    request.params = params;
    request.files = @[shop.shopImg, shop.busiLicense];
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSString *uuid = jsonObject[KEY_UUID];
        if ([NSString isNull:uuid]) {
            registerShopBlock(false);
        }else{
            shop.uuid = uuid;
            shop.registerTime = jsonObject[KEY_REGISTER_TIME];
            shop.status = jsonObject[KEY_STATUS];
            
            shop.barcode = [[ZKHFileEntity alloc] init];
            shop.barcode.aliasName = jsonObject[KEY_BARCODE];
            
            id jsonTrades = jsonObject[KEY_TRADE_LIST];
            for (id jsonTrade in jsonTrades) {
                NSString *tradeId = jsonTrade[KEY_TRADE_ID];
                for (ZKHShopTradeEntity *shopTrade in shop.trades) {
                    if ([tradeId isEqualToString:shopTrade.trade.uuid]) {
                        shopTrade.uuid = jsonTrade[KEY_UUID];
                        break;
                    }
                }
            }
            
            id jsonEmps = jsonObject[KEY_EMP_LIST];
            //for (id jsonEmp in jsonEmps) {
                shop.owner = jsonEmps[KEY_USER_ID];
            //}
            
            [[[ZKHShopData alloc] init] save:@[shop]];
            
            registerShopBlock(true);
        }
    } ];
}

@end
