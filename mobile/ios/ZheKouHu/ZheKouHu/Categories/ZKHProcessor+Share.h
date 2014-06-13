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

- (void) publishShare:(ZKHShareEntity *)share completionHandler:(BooleanResultResponseBlock) publishShareBlock ;

- (void) deleteShare:(ZKHShareEntity *)share completionHandler:(BooleanResultResponseBlock) deleteShareBlock ;

typedef void (^SharesResponseBlock)(NSMutableArray* shares);
- (void) friendShares:(NSString *)userId offset:(int)offset completionHandler:(SharesResponseBlock) sharesBlock ;

- (void) addComment:(ZKHShareCommentEntity *)comment completionHandler:(BooleanResultResponseBlock) addCommentBlock ;

- (void) deleteComment:(ZKHShareCommentEntity *)comment completionHandler:(BooleanResultResponseBlock) deleteCommentBlock ;

-(void) sharesGroupByPublishDate:(NSString *)searchWord userId:(NSString *)userId offset:(int)offset completionHandler:(SharesResponseBlock) shareBlock ;

- (void)sharesByShop:(NSString *)searchWord shopId:(NSString *)shopId offset:(int)offset completionHandler:(SharesResponseBlock) shareBlock ;

- (void) saveShareShopReply:(ZKHShareShopReplyEntity *)shopReply completionHandler:(BooleanResultResponseBlock) saveShopReplyBlock ;
@end
