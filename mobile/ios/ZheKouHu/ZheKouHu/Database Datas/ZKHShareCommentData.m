#import "ZKHData.h"
#import "ZKHConst.h"

#define SHARE_COMMENT_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text, %@ text, %@ text) ", SHARE_COMMENT_TABLE, KEY_UUID, KEY_SHARE_ID, KEY_CONTENT, KEY_PUBLISHER, KEY_PUBLISH_TIME]
#define SHARE_COMMENT_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@, %@,  %@) values (?, ?, ?, ?,?)", SHARE_COMMENT_TABLE, KEY_UUID, KEY_SHARE_ID, KEY_CONTENT, KEY_PUBLISHER, KEY_PUBLISH_TIME]

@implementation ZKHShareCommentData

- (id)init
{
    if (self = [super init]) {
        [self createTable:SHARE_COMMENT_CREATE_SQL];
    }
    return  self;
}

- (void)save:(NSArray *)data
{
    if ([data count] > 0) {
        ZKHUserData *userData = [[ZKHUserData alloc] init];
        for (ZKHShareCommentEntity *comment in data) {
            ZKHUserEntity *publisher = comment.pulisher;
            [self executeUpdate:SHARE_COMMENT_UPDATE_SQL params:@[comment.uuid, comment.shareId, comment.content, publisher.uuid, comment.publishTime]];
            [userData saveNoPwd:@[publisher]];
        }
    }
    
}

- (id)processRow:(sqlite3_stmt *)stmt
{
    ZKHShareCommentEntity *comment = [[ZKHShareCommentEntity alloc] init];
    
    int i = 0;
    
    comment.uuid = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    
    comment.shareId = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    comment.content = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    comment.publishTime = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    
    ZKHUserEntity *publisher = [[ZKHUserEntity alloc] init];
    publisher.uuid = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    publisher.name = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    publisher.phone = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    
    publisher.photo = [[ZKHFileEntity alloc] init];
    publisher.photo.aliasName = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    
    comment.pulisher = publisher;
    
    return comment;
}

- (NSMutableArray *)commentsForShare:(NSString *)shareId
{
    NSString *sql = @" select s.uuid, share_id, content, publish_time, publisher, u.name as user_name, u.phone, u.photo from e_share_comment s join e_user u where s.publisher = u.uuid and s.share_id = ? ";
    NSArray *params = @[shareId];
    
    return [self query:sql params:params];
}

- (void)deleteComment:(NSString *)uuid
{
    NSString *sql = @" delete from e_share_comment where uuid = ? ";
    NSArray *params = @[uuid];
    
    [self executeUpdate:sql params:params];
}

- (void)deleteCommentsByShare:(NSString *)shareId
{
    NSString *sql = @" delete from e_share_comment where share_id = ? ";
    NSArray *params = @[shareId];
    
    [self executeUpdate:sql params:params];
}

@end