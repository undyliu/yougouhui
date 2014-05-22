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

@implementation ZKHProcessor (Sale)

#define GET_SALES_BY_CHANNEL_URL @"/getSalesByChannel"
- (void)salesForChannel:(NSString *)channelId updateTime:(ZKHSyncEntity *) syncEntity completionHandler:(SalesResponseBlock)salesBlock errorHandler:(MKNKErrorBlock)errorBlock
{
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@", GET_SALES_BY_CHANNEL_URL, [channelId mk_urlEncodedString], [syncEntity.updateTime mk_urlEncodedString]];
    
    MKNetworkOperation *op = [self operationWithPath:path params:nil httpMethod:METHOD_GET];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            NSMutableArray *sales = [[NSMutableArray alloc] initWithCapacity:10];
            if (jsonObject != nil) {
                NSString *updateTime = [jsonObject valueForKey:KEY_UPDATE_TIME];
                
                id saleJsons = [jsonObject valueForKey:KEY_DATA];
                for (id json in saleJsons) {
                    ZKHSaleEntity *sale = [[ZKHSaleEntity alloc] init];
                    sale.uuid = [json valueForKey:KEY_UUID];
                    sale.title = [json valueForKey:KEY_TITLE];
                    sale.content = [json valueForKey:KEY_CONTENT];
                    sale.startDate = [json valueForKey:KEY_START_DATE];
                    sale.endDate = [json valueForKey:KEY_END_DATE];
                    sale.tradeId = [json valueForKey:KEY_TRADE_ID];
                    sale.visitCount = [json valueForKey:KEY_VISIT_COUNT];
                    sale.discussCount = [json valueForKey:KEY_DIS_COUNT];
                    sale.publishTime = [json valueForKey:KEY_PUBLISH_TIME];
                    sale.img = [json valueForKey:KEY_IMG];
                    
                    [sales addObject:sale];
                }
                
                syncEntity.updateTime = updateTime;
                //[[[ZKHSyncData alloc] init] save:@[syncEntity]];
            }
            
            
            salesBlock(sales);
        }];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];
}

@end
