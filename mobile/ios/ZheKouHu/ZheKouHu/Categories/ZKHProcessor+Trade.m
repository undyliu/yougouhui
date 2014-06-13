//
//  ZKHProcessor+Trade.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-6.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHProcessor+Trade.h"
#import "ZKHData.h"
#import "ZKHConst.h"

@implementation ZKHProcessor (Trade)

#define GET_TRADES_URL @"/getTrades"
- (void)trades:(Boolean)reload completionHandler:(TradesResponseBlock)tradesBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHTradeData *data = [[ZKHTradeData alloc] init];
    if (!reload) {
        NSMutableArray *trades = [data trades];
        if ([trades count] > 0) {
            tradesBlock(trades);
            return;
        }
    }
    
    ZKHRestRequest *request = [[ZKHRestRequest alloc] init];
    request.urlString = GET_TRADES_URL;
    request.method = METHOD_GET;
    
    [restClient executeWithJsonResponse:request completionHandler:^(id jsonObject) {
        NSMutableArray * trades = [[NSMutableArray alloc] initWithCapacity:10];
        if (jsonObject != nil) {
            for (NSDictionary *json in jsonObject) {
                ZKHTradeEntity *trade = [[ZKHTradeEntity alloc] init];
                trade.uuid = [json valueForKey:KEY_UUID];
                trade.code = [json valueForKey:KEY_CODE];
                trade.name = [json valueForKey:KEY_NAME];
                trade.ordIndex =[json valueForKey:KEY_ORD_INDEX];
                
                [trades addObject:trade];
            }
        }
        [data save:trades];
        
        tradesBlock(trades);
    } errorHandler:^(ZKHErrorEntity *error) {
        errorBlock(error);
    }];
}

- (void)trade:(NSString *)uuid completionHandler:(TradeResponseBlock)tradeBlock errorHandler:(RestResponseErrorBlock)errorBlock
{
    ZKHTradeData *data = [[ZKHTradeData alloc] init];
    ZKHTradeEntity *trade = [data trade:uuid];
    if (trade) {
        tradeBlock(trade);
        return;
    }
    
    [self trades:false completionHandler:^(NSMutableArray *trades) {
        tradeBlock([data trade:uuid]);
    } errorHandler:^(ZKHErrorEntity *error) {
        errorBlock(error);
    }];
}
@end
