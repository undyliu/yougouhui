#import "ZKHData.h"
#import "ZKHConst.h"
#import "ZKHEntity.h"

#define SHARE_REPLY_TABLE @"e_share_shop_reply"
#define SHARE_REPLY_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text, %@ text, %@ text, %@ text, %@ integer, %@ text) ", SHARE_REPLY_TABLE, KEY_UUID, KEY_SHARE_ID, KEY_SHOP_ID, KEY_CONTENT, KEY_STATUS, KEY_REPLIER, KEY_GRADE, KEY_REPLY_TIME]
#define SHARE_REPLY_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@, %@,  %@,  %@,  %@,  %@) values (?, ?, ?, ?, ?, ?, ?, ?)", SHARE_REPLY_TABLE, KEY_UUID, KEY_SHARE_ID, KEY_SHOP_ID, KEY_CONTENT, KEY_STATUS, KEY_REPLIER, KEY_GRADE, KEY_REPLY_TIME]
#define SHARE_REPLY_BASE_QUERY_SQL [NSString stringWithFormat:@" select %@, %@, %@, %@, %@, %@, %@, %@ from %@ ", KEY_UUID, KEY_SHARE_ID, KEY_SHOP_ID, KEY_CONTENT, KEY_STATUS, KEY_REPLIER, KEY_GRADE, KEY_REPLY_TIME, SHARE_REPLY_TABLE]

@implementation ZKHShareReplyData

- (id)init
{
    if (self = [super init]) {
        [self createTable:SHARE_REPLY_CREATE_SQL];
    }
    return  self;
}

- (void)save:(NSArray *)data
{
    if ([data count] > 0) {
        for (ZKHShareReplyEntity *reply in data) {
            NSNumber *grade = [NSNumber numberWithInt:reply.grade];
            [self executeUpdate:SHARE_REPLY_UPDATE_SQL params:@[reply.uuid, reply.shareId, reply.shopId, reply.content, reply.status, reply.replier, grade, reply.replyTime]];
        }
    }
    
}

- (id)processRow:(sqlite3_stmt *)stmt
{
    ZKHShareReplyEntity *reply = [[ZKHShareReplyEntity alloc] init];
    
    int i = 0;
    
    reply.uuid = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    reply.shareId = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    reply.shopId = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    reply.content = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    reply.status = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    reply.replier = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    reply.grade = sqlite3_column_int(stmt, i++);
    reply.replyTime = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    
    return reply;
}

- (ZKHShareReplyEntity *)shopReplyForShare:(NSString *)shareId
{
    NSString *sql = [NSString stringWithFormat:@"%@ where share_id = ?", SHARE_REPLY_BASE_QUERY_SQL];
    NSArray *params = @[shareId];
    
    return [self queryOne:sql params:params];
}

@end