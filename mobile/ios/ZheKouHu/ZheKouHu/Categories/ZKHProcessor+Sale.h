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
- (void) salesForChannel: (NSString *) channelId updateTime:(ZKHSyncEntity *) syncEntity completionHandler:(SalesResponseBlock) salesBlock ;

- (void) discussesForSale: (ZKHSaleEntity *) sale updateTime:(ZKHSyncEntity *) syncEntity completionHandler:(SalesResponseBlock) saleDiscussesBlock ;

typedef void (^SaleResponseBlock)(ZKHSaleEntity* sale);
- (void) sale: (NSString *) uuid userId:(NSString *)userId completionHandler:(SaleResponseBlock) saleBlock ;

- (void) publishSale: (ZKHSaleEntity *) sale completionHandler:(BooleanResultResponseBlock) publishSaleBlock ;

-(void) salesGroupByPublishDate:(NSString *)searchWord shopId:(NSString *)shopId offset:(int)offset completionHandler:(SalesResponseBlock) salesBlock ;

- (void) cancelSale: (ZKHSaleEntity *) sale completionHandler:(BooleanResultResponseBlock) cancelSaleBlock ;

typedef void (^SaleImagesResponseBlock)(NSMutableArray* saleImages);
- (void) saleImages: (ZKHSaleEntity *) sale completionHandler:(SaleImagesResponseBlock) saleImagesBlock ;

typedef void (^DiscussResponseBlock)(ZKHSaleDiscussEntity* discuss);
- (void) addDiscuss: (ZKHSaleDiscussEntity *) discuss completionHandler:(DiscussResponseBlock) addDiscussBlock ;

- (void) deleteDiscuss: (ZKHSaleDiscussEntity *) discuss completionHandler:(BooleanResultResponseBlock) deleteDiscussBlock ;
@end
