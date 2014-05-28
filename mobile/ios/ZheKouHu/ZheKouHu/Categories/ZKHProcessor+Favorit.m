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

@end
