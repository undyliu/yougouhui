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
- (void)loginShopByPhone:(NSString *)phone pwd:(NSString *)pwd completionHandler:(LoginResponseBlock)loginBlock errorHandler:(MKNKErrorBlock)errorBlock
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
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

//修改商铺简介
#define UPDATE_SHOP_URL @"/updateShop"
- (void)changeShopDesc:(NSString *)uuid newDesc:(NSString *)newDesc completionHandler:(BooleanResultResponseBlock)changeDescBlock errorHandler:(RestResponseErrorBlock)errorBlock
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
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

-(void)changeShopName:(NSString *)uuid newName:(NSString *)newName completionHandler:(BooleanResultResponseBlock)changeNameBlock errorHandler:(RestResponseErrorBlock)errorBlock
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
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

#define UPDATE_SHOP_TRADES_URL @"/updateShopTrades"
- (void)changeShopTrades:(NSString *)uuid newTrades:(NSArray *)newTrades completionHandler:(ChangeTradesResponseBlock)changeTradesBlock errorHandler:(RestResponseErrorBlock)errorBlock
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
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

#define UPDATE_SHOP_EMP_PWD_URL @"/updateShopEmpPwd"
- (void)changeShopEmpPwd:(NSString *)uuid userId:(NSString *)userId oldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd completionHandler:(BooleanResultResponseBlock)changeShopEmpPwdBlock errorHandler:(RestResponseErrorBlock)errorBlock
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
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)changeShopImage:(NSString *)uuid shopImage:(ZKHFileEntity *)shopImage completionHandler:(BooleanResultResponseBlock)changeShopImageBlock errorHandler:(RestResponseErrorBlock)errorBlock
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
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];

}

- (void)changeBusiLicense:(NSString *)uuid busiLicense:(ZKHFileEntity *)busiLicense completionHandler:(BooleanResultResponseBlock)changeBusiLicenseBlock errorHandler:(RestResponseErrorBlock)errorBlock
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
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

#define  GET_SHOP_URL(__SHOP_ID__) [NSString stringWithFormat:@"/getShop/%@", __SHOP_ID__]
- (void)shop:(NSString *)uuid completionHandler:(ShopResponseBlock)shopBlock errorHandler:(MKNKErrorBlock)errorBlock
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
        if ([uuid isNull]) {
            shopBlock(nil);
        }
        shopBlock([[ZKHShopEntity alloc] initWithJsonObject:jsonObject]);
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

#define  CHECK_SHOP_EMP_URL(__SHOP_ID__,__USER_ID__) [NSString stringWithFormat:@"/checkShopEmp/%@/%@", __SHOP_ID__, __USER_ID__]
- (void)checkShopEmp:(NSString *)shopId userId:(NSString *)userId completionHandler:(BooleanResultResponseBlock)checkShopEmpBlock errorHandler:(MKNKErrorBlock)errorBlock
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.method = METHOD_GET;
    request.urlString = CHECK_SHOP_EMP_URL(shopId, userId);
    
    [restClient execute:request completionHandler:^(NSHTTPURLResponse *response, id jsonObject) {
        NSString *uuid = [jsonObject valueForKey:KEY_UUID];
        if ([uuid isNull]) {
            checkShopEmpBlock(false);
        }else{
            checkShopEmpBlock(true);
        }
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

@end
