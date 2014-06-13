//
//  ZKHProcessor+Share.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-3.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHProcessor.h"
#import "ZKHEntity.h"

@interface ZKHProcessor (Share)

- (void) publishShare:(ZKHShareEntity *)share completionHandler:(BooleanResultResponseBlock) publishShareBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) deleteShare:(ZKHShareEntity *)share completionHandler:(BooleanResultResponseBlock) deleteShareBlock errorHandler:(RestResponseErrorBlock) errorBlock;

typedef void (^SharesResponseBlock)(NSMutableArray* shares);
- (void) friendShares:(NSString *)userId offset:(int)offset completionHandler:(SharesResponseBlock) sharesBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) addComment:(ZKHShareCommentEntity *)comment completionHandler:(BooleanResultResponseBlock) addCommentBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) deleteComment:(ZKHShareCommentEntity *)comment completionHandler:(BooleanResultResponseBlock) deleteCommentBlock errorHandler:(RestResponseErrorBlock) errorBlock;

-(void) sharesGroupByPublishDate:(NSString *)searchWord userId:(NSString *)userId offset:(int)offset completionHandler:(SharesResponseBlock) shareBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void)sharesByShop:(NSString *)searchWord shopId:(NSString *)shopId offset:(int)offset completionHandler:(SharesResponseBlock) shareBlock errorHandler:(RestResponseErrorBlock) errorBlock;

- (void) saveShareShopReply:(ZKHShareShopReplyEntity *)shopReply completionHandler:(BooleanResultResponseBlock) saveShopReplyBlock errorHandler:(RestResponseErrorBlock) errorBlock;
@end
