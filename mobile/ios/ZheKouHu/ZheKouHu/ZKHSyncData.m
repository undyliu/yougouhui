#import "ZKHData.h"
#import "ZKHConst.h"


#define SYNC_TABLE @"e_update"
#define SYNC_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text, %@ text) ", SYNC_TABLE, KEY_UUID, KEY_TABLE_NAME, KEY_ITEM_ID, KEY_UPDATE_TIME]
#define SYNC_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@, %@) values (?, ?, ?, ?)", SYNC_TABLE, KEY_UUID, KEY_TABLE_NAME, KEY_ITEM_ID, KEY_UPDATE_TIME]
#define SYNC_QUERY_SQL [NSString stringWithFormat:@" select %@, %@, %@, %@ from %@ where %@ = ? and  %@ = ? ", KEY_UUID, KEY_TABLE_NAME, KEY_ITEM_ID, KEY_UPDATE_TIME, SYNC_TABLE, KEY_TABLE_NAME, KEY_ITEM_ID]

@implementation ZKHSyncData

- (id)init
{
    if (self = [super init]) {
        [self createTable:SYNC_CREATE_SQL];
    }
    return self;
}

- (void)save:(NSArray *)data
{
    if ([data count] == 0) {
        return;
    }
    
    for (ZKHSyncEntity *sync in data) {
        [self executeUpdate:SYNC_UPDATE_SQL params:@[sync.uuid, sync.tableName, sync.itemId, sync.updateTime]];
    }
}

- (id)processRow:(sqlite3_stmt *)stmt
{
    ZKHSyncEntity *sync = [[ZKHSyncEntity alloc] init];
    int i = 0;
    sync.uuid = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    sync.tableName = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    sync.itemId = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    sync.updateTime = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    
    return sync;
}

- (ZKHSyncEntity *)getSyncEntity:(NSString *)tableName itemId:(NSString *)itemId
{
    return [self queryOne:SYNC_QUERY_SQL params:@[tableName, itemId]];
}

@end