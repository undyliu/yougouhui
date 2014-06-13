//
//  ZKHProcessor+Sale.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-21.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHProcessor.h"
#import "ZKHEntity.h"

@interface ZKHProcessor (Sale)

typedef void (^SalesResponseBlock)(NSMutableArray* sales);
- (void) salesForChannel: (NSString *) channelId updateTime:(ZKHSyncEntity *) syncEntity completionHandler:(SalesResponseBlock) salesBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) discussesForSale: (ZKHSaleEntity *) sale updateTime:(ZKHSyncEntity *) syncEntity completionHandler:(SalesResponseBlock) saleDiscussesBlock errorHandler:(RestResponseErrorBlock) errorBlock;

typedef void (^SaleResponseBlock)(ZKHSaleEntity* sale);
- (void) sale: (NSString *) uuid userId:(NSString *)userId completionHandler:(SaleResponseBlock) saleBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) publishSale: (ZKHSaleEntity *) sale completionHandler:(BooleanResultResponseBlock) publishSaleBlock errorHandler:(RestResponseErrorBlock) errorBlock;

-(void) salesGroupByPublishDate:(NSString *)searchWord shopId:(NSString *)shopId offset:(int)offset completionHandler:(SalesResponseBlock) salesBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) cancelSale: (ZKHSaleEntity *) sale completionHandler:(BooleanResultResponseBlock) cancelSaleBlock errorHandler:(RestResponseErrorBlock) errorBlock;

typedef void (^SaleImagesResponseBlock)(NSMutableArray* saleImages);
- (void) saleImages: (ZKHSaleEntity *) sale completionHandler:(SaleImagesResponseBlock) saleImagesBlock errorHandler:(RestResponseErrorBlock) errorBlock;

typedef void (^DiscussResponseBlock)(ZKHSaleDiscussEntity* discuss);
- (void) addDiscuss: (ZKHSaleDiscussEntity *) discuss completionHandler:(DiscussResponseBlock) addDiscussBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) deleteDiscuss: (ZKHSaleDiscussEntity *) discuss completionHandler:(BooleanResultResponseBlock) deleteDiscussBlock errorHandler:(RestResponseErrorBlock) errorBlock;
@end
