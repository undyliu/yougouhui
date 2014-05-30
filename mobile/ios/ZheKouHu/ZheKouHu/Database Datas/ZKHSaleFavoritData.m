
#import "ZKHData.h"
#import "ZKHConst.h"
#import "ZKHEntity.h"

#define SALE_FAVORIT_TABLE @"e_sale_favorit"
#define SALE_FAVORIT_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text, %@ text, %@ text, %@ integer) ", SALE_FAVORIT_TABLE, KEY_UUID, KEY_SALE_ID, KEY_TITLE, KEY_IMG, KEY_USER_ID, KEY_LAST_MODIFY_TIME]
#define SALE_FAVORIT_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@, %@, %@, %@) values (?, ?, ?, ?, ?, ?)", SALE_FAVORIT_TABLE, KEY_UUID, KEY_SALE_ID, KEY_TITLE, KEY_IMG, KEY_USER_ID, KEY_LAST_MODIFY_TIME]
#define SALE_FAVORIT_QUERY_SQL [NSString stringWithFormat:@" select %@, %@, %@, %@, %@ from %@ where %@ = ? order by %@ desc ", KEY_UUID, KEY_SALE_ID, KEY_TITLE, KEY_IMG, KEY_USER_ID, SALE_FAVORIT_TABLE, KEY_USER_ID, KEY_LAST_MODIFY_TIME]

@implementation ZKHSaleFavoritData

- (id)init
{
    if (self = [super init]) {
        [self createTable:SALE_FAVORIT_CREATE_SQL];
    }
    return self;
}

- (void)save:(NSArray *)data
{
    if (data == nil || [data count] == 0) {
        return;
    }
    
    for (ZKHFavoritEntity *favorit in data) {
        [self executeUpdate:SALE_FAVORIT_UPDATE_SQL params:@[favorit.uuid, favorit.code, favorit.title, favorit.image, favorit.userId, favorit.lastModifyTime]];
    }
}

- (id)processRow:(sqlite3_stmt *)stmt
{
    ZKHFavoritEntity *favorit = [[ZKHFavoritEntity alloc] init];
    
    int i = 0;
    favorit.uuid = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    favorit.code = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    favorit.title = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    favorit.image = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    favorit.userId = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    return favorit;
}

- (NSMutableArray *)saleFavorits:(NSString *)userId
{
    return  [self query:SALE_FAVORIT_QUERY_SQL params:@[userId]];
}

- (Boolean)isUserFavorie:(NSString *)userId saleId:(NSString *)saleId
{
    NSString *sql = [NSString stringWithFormat:@" select count(1) from %@ where sale_id = ? and user_id = ? ", SALE_FAVORIT_TABLE];
    NSArray *params = @[saleId, userId];
    int count = [self queryCount:sql params:params];
    return count > 0;
}

- (void)deleteFavorit:(NSString *)userId saleId:(NSString *)saleId
{
    NSString *sql = [NSString stringWithFormat:@" delete from %@ where sale_id = ? and user_id = ? ", SALE_FAVORIT_TABLE];
    NSArray *params = @[saleId, userId];
    [self executeUpdate:sql params:params];
}
@end