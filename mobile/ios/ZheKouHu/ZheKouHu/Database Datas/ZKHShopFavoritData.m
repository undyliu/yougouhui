
#import "ZKHData.h"
#import "ZKHConst.h"
#import "ZKHEntity.h"

#define SHOP_FAVORIT_TABLE @"e_shop_favorit"
#define SHOP_FAVORIT_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text, %@ text, %@ text, %@ integer) ", SHOP_FAVORIT_TABLE, KEY_UUID, KEY_SHOP_ID, KEY_TITLE, KEY_IMG, KEY_USER_ID, KEY_LAST_MODIFY_TIME]
#define SHOP_FAVORIT_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@, %@, %@, %@) values (?, ?, ?, ?, ?, ?)", SHOP_FAVORIT_TABLE, KEY_UUID, KEY_SHOP_ID, KEY_TITLE, KEY_IMG, KEY_USER_ID, KEY_LAST_MODIFY_TIME]
#define SHOP_FAVORIT_QUERY_SQL [NSString stringWithFormat:@" select %@, %@, %@, %@, %@ from %@ where %@ = ? order by %@ desc ", KEY_UUID, KEY_SHOP_ID, KEY_TITLE, KEY_IMG, KEY_USER_ID, SHOP_FAVORIT_TABLE, KEY_USER_ID, KEY_LAST_MODIFY_TIME]

@implementation ZKHShopFavoritData

- (id)init
{
    if (self = [super init]) {
        [self createTable:SHOP_FAVORIT_CREATE_SQL];
    }
    return self;
}

- (void)save:(NSArray *)data
{
    if (data == nil || [data count] == 0) {
        return;
    }
    
    for (ZKHFavoritEntity *favorit in data) {
        [self executeUpdate:SHOP_FAVORIT_UPDATE_SQL params:@[favorit.uuid, favorit.code, favorit.title, favorit.image, favorit.userId, favorit.lastModifyTime]];
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

- (NSMutableArray *)shopFavorits:(NSString *)userId
{
    return  [self query:SHOP_FAVORIT_QUERY_SQL params:@[userId]];
}

@end