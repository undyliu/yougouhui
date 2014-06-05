//
//  ZKHProcessor+Favorit.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-28.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHProcessor+Favorit.h"
#import "ZKHData.h"
#import "ZKHConst.h"
#import "NSString+Utils.h"

@implementation ZKHProcessor (Favorit)

#define  GET_SALE_FAVORITS_URL(__USER_ID__) [NSString stringWithFormat:@"/getSaleFavoritesByUser/%@", __USER_ID__]
- (void)saleFavorits:(NSString *)userId completionHandler:(FavoritsResponseBlock)favoritsBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHSaleFavoritData *data = [[ZKHSaleFavoritData alloc] init];
    NSMutableArray *saleFavorits = [data saleFavorits:userId];
    if ([saleFavorits count] > 0) {
        favoritsBlock(saleFavorits);
        return;
    }
    
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = GET_SALE_FAVORITS_URL(userId);
    request.method = METHOD_GET;
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSMutableArray *saleFavorits = [[NSMutableArray alloc] init];
        for (id jsonFavorit in jsonObject) {
            ZKHFavoritEntity *favorit = [[ZKHFavoritEntity alloc] init];
            favorit.uuid = [jsonFavorit valueForKey:KEY_UUID];
            favorit.code = [jsonFavorit valueForKey:KEY_SALE_ID];
            favorit.title = [jsonFavorit valueForKey:KEY_TITLE];
            favorit.image = [jsonFavorit valueForKey:KEY_IMG];
            favorit.userId = [jsonFavorit valueForKey:KEY_USER_ID];
            favorit.lastModifyTime = [jsonFavorit valueForKey:KEY_LAST_MODIFY_TIME];
            
            [saleFavorits addObject:favorit];
        }
        
        [data save:saleFavorits];
        favoritsBlock(saleFavorits);
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

#define  GET_SHOP_FAVORITS_URL(__USER_ID__) [NSString stringWithFormat:@"/getShopFavoritesByUser/%@", __USER_ID__]
- (void)shopFavorits:(NSString *)userId completionHandler:(FavoritsResponseBlock)favoritsBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHShopFavoritData *data = [[ZKHShopFavoritData alloc] init];
    NSMutableArray *shopFavorits = [data shopFavorits:userId];
    if ([shopFavorits count] > 0) {
        favoritsBlock(shopFavorits);
        return;
    }
    
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = GET_SHOP_FAVORITS_URL(userId);
    request.method = METHOD_GET;
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSMutableArray *shopFavorits = [[NSMutableArray alloc] init];
        for (id jsonFavorit in jsonObject) {
            ZKHFavoritEntity *favorit = [[ZKHFavoritEntity alloc] init];
            favorit.uuid = [jsonFavorit valueForKey:KEY_UUID];
            favorit.code = [jsonFavorit valueForKey:KEY_SHOP_ID];
            favorit.title = [jsonFavorit valueForKey:KEY_TITLE];
            favorit.image = [jsonFavorit valueForKey:KEY_IMG];
            favorit.userId = [jsonFavorit valueForKey:KEY_USER_ID];
            favorit.lastModifyTime = [jsonFavorit valueForKey:KEY_LAST_MODIFY_TIME];
            
            [shopFavorits addObject:favorit];
        }
        
        [data save:shopFavorits];
        favoritsBlock(shopFavorits);
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];

}

- (void)isShopFavorit:(NSString *)userId shopId:(NSString *)shopId completionHandler:(BooleanResultResponseBlock)favoritBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHShopFavoritData *favoritData = [[ZKHShopFavoritData alloc] init];
    Boolean result = [favoritData isUserFavorie:userId shopId:shopId];
    if (result) {
        favoritBlock(result);
        return;
    }
    
    [self shopFavorits:userId completionHandler:^(NSMutableArray *favorits) {
        if ([favorits count] > 0) {
            favoritBlock([favoritData isUserFavorie:userId shopId:shopId]);
        }else{
            favoritBlock(false);
        }
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)isSaleFavorit:(NSString *)userId saleId:(NSString *)saleId completionHandler:(BooleanResultResponseBlock)favoritBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHSaleFavoritData *favoritData = [[ZKHSaleFavoritData alloc] init];
    Boolean result = [favoritData isUserFavorie:userId saleId:saleId];
    if (result) {
        favoritBlock(result);
        return;
    }
    
    [self saleFavorits:userId completionHandler:^(NSMutableArray *favorits) {
        if ([favorits count] > 0) {
            favoritBlock([favoritData isUserFavorie:userId saleId:saleId]);
        }else{
            favoritBlock(false);
        }
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

#define ADD_SHOP_FAVORIT @"addShopFavorit"
- (void)setShopFavorit:(NSString *)userId shop:(ZKHShopEntity *)shop completionHandler:(BooleanResultResponseBlock)favoritBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = ADD_SHOP_FAVORIT;
    request.method = METHOD_POST;
    request.params = @{KEY_SHOP_ID: shop.uuid, KEY_USER_ID: userId};
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSString *uuid = [jsonObject valueForKey:KEY_UUID];
        if ([NSString isNull:uuid]) {
            favoritBlock(false);
        }else{
            ZKHFavoritEntity *favorit = [[ZKHFavoritEntity alloc] init];
            favorit.uuid = uuid;
            favorit.code = shop.uuid;
            favorit.title = shop.name;
            favorit.image = shop.shopImg.aliasName;
            favorit.userId = userId;
            favorit.lastModifyTime = [jsonObject valueForKey:KEY_LAST_MODIFY_TIME];
            
            [[[ZKHShopFavoritData alloc] init] save:@[favorit]];
            
            favoritBlock(true);
        }
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];

}

//收藏
#define ADD_SALE_FAVORIT @"addSaleFavorit"
- (void)setSaleFavorit:(NSString *)userId sale:(ZKHSaleEntity *)sale completionHandler:(BooleanResultResponseBlock)favoritBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = ADD_SALE_FAVORIT;
    request.method = METHOD_POST;
    request.params = @{KEY_SALE_ID: sale.uuid, KEY_USER_ID: userId};
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSString *uuid = [jsonObject valueForKey:KEY_UUID];
        if ([NSString isNull:uuid]) {
            favoritBlock(false);
        }else{
            ZKHFavoritEntity *favorit = [[ZKHFavoritEntity alloc] init];
            favorit.uuid = uuid;
            favorit.code = sale.uuid;
            favorit.title = sale.title;
            favorit.image = sale.img;
            favorit.userId = userId;
            favorit.lastModifyTime = [jsonObject valueForKey:KEY_LAST_MODIFY_TIME];
            
            [[[ZKHSaleFavoritData alloc] init] save:@[favorit]];
            
            favoritBlock(true);
        }
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

#define  DEL_SHOP_FAVORIT_URL(__USER_ID__, __SHOP_ID__) [NSString stringWithFormat:@"/deleteShopFavorit/%@/%@", __USER_ID__, __SHOP_ID__]
- (void)delShopFavorit:(NSString *)userId shopId:(NSString *)shopId completionHandler:(BooleanResultResponseBlock)favoritBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = DEL_SHOP_FAVORIT_URL(userId, shopId);
    request.method = METHOD_DELETE;
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSString *deleted = jsonObject[KEY_IS_DELETED];
        if ([NSString isNull:deleted]) {
            favoritBlock(false);
        }else{
            [[[ZKHShopFavoritData alloc] init] deleteFavorit:userId shopId:shopId];
            favoritBlock(true);
        }
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

#define  DEL_SALE_FAVORIT_URL(__USER_ID__, __SALE_ID__) [NSString stringWithFormat:@"/deleteSaleFavorit/%@/%@", __USER_ID__, __SALE_ID__]
- (void)delSaleFavorit:(NSString *)userId saleId:(NSString *)saleId completionHandler:(BooleanResultResponseBlock)favoritBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = DEL_SALE_FAVORIT_URL(userId, saleId);
    request.method = METHOD_DELETE;
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSString *deleted = jsonObject[KEY_IS_DELETED];
        if ([NSString isNull:deleted]) {
            favoritBlock(false);
        }else{
            [[[ZKHSaleFavoritData alloc] init] deleteFavorit:userId saleId:saleId];
            favoritBlock(true);
        }
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
}

@end
