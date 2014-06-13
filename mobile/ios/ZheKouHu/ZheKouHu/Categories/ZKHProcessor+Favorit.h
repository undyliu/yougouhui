//
//  ZKHProcessor+Favorit.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-28.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHProcessor.h"
#import "ZKHEntity.h"

@interface ZKHProcessor (Favorit)

typedef void (^FavoritsResponseBlock)(NSMutableArray* favorits);
- (void) saleFavorits: (NSString *) userId completionHandler:(FavoritsResponseBlock) favoritsBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) shopFavorits: (NSString *) userId completionHandler:(FavoritsResponseBlock) favoritsBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) isShopFavorit: (NSString *) userId shopId:(NSString *)shopId completionHandler:(BooleanResultResponseBlock) favoritBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) isSaleFavorit: (NSString *) userId saleId:(NSString *)saleId completionHandler:(BooleanResultResponseBlock) favoritBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) setShopFavorit: (NSString *) userId shop:(ZKHShopEntity *)shop completionHandler:(BooleanResultResponseBlock) favoritBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) setSaleFavorit: (NSString *) userId sale:(ZKHSaleEntity *)sale completionHandler:(BooleanResultResponseBlock) favoritBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) delShopFavorit: (NSString *) userId shopId:(NSString *)shopId completionHandler:(BooleanResultResponseBlock) favoritBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) delSaleFavorit: (NSString *) userId saleId:(NSString *)saleId completionHandler:(BooleanResultResponseBlock) favoritBlock errorHandler:(RestResponseErrorBlock) errorBlock;

@end
