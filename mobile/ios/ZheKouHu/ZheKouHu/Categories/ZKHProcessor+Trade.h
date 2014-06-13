//
//  ZKHProcessor+Trade.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-6.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHProcessor.h"
#import "ZKHEntity.h"

@interface ZKHProcessor (Trade)

//获取主营业务
typedef void (^TradesResponseBlock)(NSMutableArray* trades);
- (void) trades:(Boolean)reload completionHandler:(TradesResponseBlock) tradesBlock
   errorHandler:(RestResponseErrorBlock) errorBlock;

typedef void (^TradeResponseBlock)(ZKHTradeEntity* trade);
- (void) trade:(NSString *)uuid completionHandler:(TradeResponseBlock) tradeBlock
  errorHandler:(RestResponseErrorBlock) errorBlock;

@end
