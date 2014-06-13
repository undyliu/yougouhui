//
//  ZKHProcessor+Sale.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-21.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHProcessor+Sale.h"
#import "ZKHConst.h"
#import "ZKHData.h"
#import "NSString+Utils.h"

@implementation ZKHProcessor (Sale)

- (ZKHSaleEntity *) saleFormJsonObject:(id)json
{
    ZKHSaleEntity *sale = [[ZKHSaleEntity alloc] init];
    
    sale.uuid = [json valueForKey:KEY_UUID];
    sale.title = [json valueForKey:KEY_TITLE];
    sale.content = [json valueForKey:KEY_CONTENT];
    sale.img = [json valueForKey:KEY_IMG];
    sale.startDate = [json valueForKey:KEY_START_DATE];
    sale.endDate = [json valueForKey:KEY_END_DATE];
    sale.visitCount = [json valueForKey:KEY_VISIT_COUNT];
    sale.discussCount = [json valueForKey:KEY_DIS_COUNT];
    
    ZKHShopEntity *shop = [[ZKHShopEntity alloc] init];
    shop.uuid = [json valueForKey:KEY_SHOP_ID];
    shop.name = [json valueForKey:KEY_SHOP_NAME];
    shop.location = [[ZKHLocationEntity alloc] initWithString:[json valueForKey:KEY_LOCATION]];
    sale.shop = shop;
    
    ZKHUserEntity *publisher = [[ZKHUserEntity alloc] init];
    publisher.uuid = [json valueForKey:KEY_PUBLISHER];
    sale.publisher = publisher;
    
    sale.tradeId = [json valueForKey:KEY_TRADE_ID];
    sale.publishTime = [json valueForKey:KEY_PUBLISH_TIME];
    sale.publishDate = [json valueForKey:KEY_PUBLISH_DATE];
    sale.channelId = [json valueForKey:KEY_CHANNEL_ID];
    sale.status = [json valueForKey:KEY_STATUS];
    
    return sale;
}

#define GET_SALES_BY_CHANNEL_URL @"/getSalesByChannel"
- (void)salesForChannel:(NSString *)channelId updateTime:(ZKHSyncEntity *) syncEntity completionHandler:(SalesResponseBlock)salesBlock
{
    ZKHSaleData *saleData = [[ZKHSaleData alloc] init];
    NSMutableArray *sales = [saleData salesForChannel:channelId];
    if ([sales count] > 0) {
        salesBlock(sales);
        return;
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@", GET_SALES_BY_CHANNEL_URL, [channelId mk_urlEncodedString], [syncEntity.updateTime mk_urlEncodedString]];
    
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = path;
    request.method = METHOD_GET;
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSMutableArray *sales = [[NSMutableArray alloc] initWithCapacity:10];
        if (jsonObject != nil) {
            NSString *updateTime = [jsonObject valueForKey:KEY_UPDATE_TIME];
            
            id saleJsons = [jsonObject valueForKey:KEY_DATA];
            for (id json in saleJsons) {
                ZKHSaleEntity *sale = [self saleFormJsonObject:json];
                [sales addObject:sale];
            }
            
            [saleData save:sales];
            
            syncEntity.updateTime = updateTime;
            [[[ZKHSyncData alloc] init] save:@[syncEntity]];
        }
        
        
        salesBlock(sales);
    } ];
}

#define GET_DISCUSSES_BY_SALE_URL @"/getSaleDiscusses"
- (void)discussesForSale:(ZKHSaleEntity *) sale updateTime:(ZKHSyncEntity *)syncEntity completionHandler:(SalesResponseBlock)saleDiscussesBlock
{
    ZKHSaleDiscussData *disData = [[ZKHSaleDiscussData alloc] init];
    NSMutableArray *discusses = [disData discussesForSale:sale.uuid];
    if ([discusses count] > 0) {
        for (ZKHSaleDiscussEntity *dis in discusses) {
            dis.sale = sale;
        }
        saleDiscussesBlock(discusses);
        return;
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@", GET_DISCUSSES_BY_SALE_URL, [sale.uuid mk_urlEncodedString], [syncEntity.updateTime mk_urlEncodedString]];
    
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = path;
    request.method = METHOD_GET;
    
    [restClient execute:request completionHandler:^(NSHTTPURLResponse *response, id jsonObject) {
        NSMutableArray *discusses = [[NSMutableArray alloc] init];
        if (jsonObject != nil) {
            NSString *updateTime = [jsonObject valueForKey:KEY_UPDATE_TIME];
            
            id disJsons = [jsonObject valueForKey:KEY_DATA];
            for (id jsonDis in disJsons) {
                NSNumber *isDel = jsonDis[KEY_IS_DELETED];
                if ([isDel intValue] == 1) {
                    [disData deleteDiscuss:[jsonDis valueForKey:KEY_UUID]];
                    continue;
                }
                ZKHSaleDiscussEntity *dis = [[ZKHSaleDiscussEntity alloc] init];
                dis.uuid = [jsonDis valueForKey:KEY_UUID];
                dis.content = [jsonDis valueForKey:KEY_CONTENT];
                
                dis.sale = sale;
                dis.publishTime = [jsonDis valueForKey:KEY_PUBLISH_TIME];
                
                NSMutableDictionary *userJson = [jsonDis mutableCopy];
                [userJson setObject:userJson[KEY_PUBLISHER] forKey:KEY_UUID];
                [userJson setObject:userJson[KEY_USER_NAME] forKey:KEY_NAME];
                dis.publisher = [[ZKHUserEntity alloc]initWithJsonObject:userJson noPwd:true];
                
                [discusses addObject:dis];
            }
            
            [disData save:discusses];
            
            syncEntity.updateTime = updateTime;
            [[[ZKHSyncData alloc] init] save:@[syncEntity]];
            
        }
        saleDiscussesBlock(discusses);
    } ];
}

#define  GET_SALE_URL(__UUID__, __USER_ID__) [NSString stringWithFormat:@"/getSaleData/%@/%@", __UUID__, __USER_ID__]
- (void)sale:(NSString *)uuid userId:(NSString *)userId completionHandler:(SaleResponseBlock)saleBlock 
{
    ZKHSaleData *saleData = [[ZKHSaleData alloc] init];
    ZKHSaleEntity *sale = [saleData sale:uuid];
    if (sale) {
        saleBlock(sale);
        return;
    }
    
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = GET_SALE_URL(uuid, userId);
    request.method = METHOD_GET;
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        if (jsonObject) {
            ZKHSaleEntity *sale = [self saleFormJsonObject:jsonObject];
            [saleData save:@[sale]];
            saleBlock(sale);
        }else{
            saleBlock(nil);
        }
    } ];
    
}

//发布活动
#define ADD_SALE_URL @"/addSale"
- (void)publishSale:(ZKHSaleEntity *)sale completionHandler:(BooleanResultResponseBlock)publishSaleBlock 
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = ADD_SALE_URL;
    request.method = METHOD_POST;
    request.params = @{KEY_TITLE: sale.title, KEY_CONTENT: sale.content, KEY_SHOP_ID: sale.shop.uuid, KEY_TRADE_ID:sale.tradeId, KEY_START_DATE: sale.startDate, KEY_END_DATE: sale.endDate, KEY_PUBLISHER: sale.publisher.uuid};
    request.files = sale.images;
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSString *uuid = jsonObject[KEY_UUID];
        if ([NSString isNull:uuid]) {
            publishSaleBlock(false);
        }else{
            sale.uuid = uuid;
            sale.publishTime = jsonObject[KEY_PUBLISH_TIME];
            sale.publishDate = jsonObject[KEY_PUBLISH_DATE];
            sale.status = jsonObject[KEY_STATUS];
            sale.img = jsonObject[KEY_IMG];
            sale.visitCount = @"0";
            sale.discussCount = @"0";
            sale.channelId = jsonObject[KEY_CHANNEL_ID];
            if (sale.channelId == nil) {
                sale.channelId = @"";
            }
            
            NSMutableArray *files = [[NSMutableArray alloc] init];
            id jsonImages = jsonObject[KEY_IMAGES];
            for (id jsonImage in jsonImages) {
                ZKHFileEntity *file = [[ZKHFileEntity alloc] init];
                file.uuid = jsonImage[KEY_UUID];
                file.aliasName = jsonImage[KEY_IMG];
                file.ordIndex = jsonImage[KEY_ORD_INDEX];
                
                [files addObject:file];
            }
            
            sale.images = files;
            
            [[[ZKHSaleData alloc] init] save:@[sale]];
            
            publishSaleBlock(true);
        }
    } ];
}

//按发布时间分组获取活动列表
- (void)salesGroupByPublishDate:(NSString *)searchWord shopId:(NSString *)shopId offset:(int)offset completionHandler:(SalesResponseBlock)salesBlock 
{
    ZKHSaleData *saleData = [[ZKHSaleData alloc] init];
    NSMutableArray *sales = [saleData salesGroupByPublishDate:searchWord shopId:shopId offset:offset];
    //if ([sales count] > 0) {
        salesBlock(sales);
        return;
    //}
}

//作废活动
#define CANCEL_SALE_URL @"/cancelSale"
- (void)cancelSale:(ZKHSaleEntity *)sale completionHandler:(BooleanResultResponseBlock)cancelSaleBlock 
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = CANCEL_SALE_URL;
    request.method = METHOD_PUT;
    request.params = @{KEY_SALE_ID: sale.uuid};
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSString *uuid = jsonObject[KEY_UUID];
        if ([NSString isNull:uuid]) {
            cancelSaleBlock(false);
        }else{
            [[[ZKHSaleData alloc] init] cancelSale:sale.uuid];
            sale.status = jsonObject[KEY_STATUS];
            cancelSaleBlock(true);
        }
    } ];
}

- (void)saleImages:(ZKHSaleEntity *)sale completionHandler:(SaleImagesResponseBlock)saleImagesBlock 
{
    ZKHSaleData *saleData = [[ZKHSaleData alloc] init];
    sale.images = [saleData saleImages:sale.uuid];
    saleImagesBlock(sale.images);
}

#define ADD_SALE_DISCUSS @"/addSaleDiscuss"
- (void)addDiscuss:(ZKHSaleDiscussEntity *)discuss completionHandler:(DiscussResponseBlock)addDiscussBlock 
{
    @try {
        ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
        request.urlString = ADD_SALE_DISCUSS;
        request.method = METHOD_POST;
        request.params = @{KEY_SALE_ID: discuss.sale.uuid, KEY_PUBLISHER: discuss.publisher.uuid, KEY_CONTENT: discuss.content};
        
        [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
            NSString *uuid = jsonObject[KEY_UUID];
            if ([NSString isNull:uuid]) {
                //todo:
                addDiscussBlock(nil);
            }else{
                discuss.uuid = uuid;
                discuss.publishTime = jsonObject[KEY_PUBLISH_TIME];
                
                [[[ZKHSaleDiscussData alloc] init] save:@[discuss]];
                
                NSString *disCount = [NSString stringWithFormat:@"%d", [discuss.sale.discussCount intValue] + 1];
                [[[ZKHSaleData alloc] init] updateSale:discuss.sale.uuid fieldName:KEY_DIS_COUNT fieldValue:disCount];
                discuss.sale.discussCount = disCount;
                
                addDiscussBlock(discuss);
            }
        } ];

    }
    @catch (NSException *exception) {
        NSLog(@"%@", @"出现异常.");
    }
    @finally {
        
    }
    }

#define DEL_SALE_DISCUSS(__UUID__) [NSString stringWithFormat:@"/deleteSaleDiscuss/%@", __UUID__]
- (void)deleteDiscuss:(ZKHSaleDiscussEntity *)discuss completionHandler:(BooleanResultResponseBlock)deleteDiscussBlock 
{
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = DEL_SALE_DISCUSS(discuss.uuid);
    request.method = METHOD_DELETE;
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSString *uuid = jsonObject[KEY_UUID];
        if ([NSString isNull:uuid]) {
            deleteDiscussBlock(false);
        }else{
            [[[ZKHSaleDiscussData alloc] init] deleteDiscuss:uuid];
            NSString *disCount = [NSString stringWithFormat:@"%d", [discuss.sale.discussCount intValue] - 1];
            [[[ZKHSaleData alloc] init] updateSale:discuss.sale.uuid fieldName:KEY_DIS_COUNT fieldValue:disCount];
            discuss.sale.discussCount = disCount;
            
            deleteDiscussBlock(true);
        }
    } ];
}
@end
