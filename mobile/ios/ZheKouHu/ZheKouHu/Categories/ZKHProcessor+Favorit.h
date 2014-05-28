//
//  ZKHProcessor+Favorit.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-28.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHProcessor.h"

@interface ZKHProcessor (Favorit)

typedef void (^FavoritsResponseBlock)(NSMutableArray* favorits);
- (void) saleFavorits: (NSString *) userId completionHandler:(FavoritsResponseBlock) favoritsBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) shopFavorits: (NSString *) userId completionHandler:(FavoritsResponseBlock) favoritsBlock errorHandler:(RestResponseErrorBlock) errorBlock;

@end
