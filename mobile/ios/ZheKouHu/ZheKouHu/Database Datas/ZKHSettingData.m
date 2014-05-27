#import "ZKHData.h"
#import "ZKHConst.h"


#define SETTING_TABLE @"e_setting"
#define SETTING_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text) ", SETTING_TABLE, KEY_UUID, KEY_CODE, KEY_NAME, KEY_IMG, KEY_VALUE, KEY_USER_ID, KEY_ORD_INDEX]
#define SETTING_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@, %@, %@, %@, %@) values (?, ?, ?, ?, ?, ?, ?)", SETTING_TABLE, KEY_UUID, KEY_CODE, KEY_NAME, KEY_IMG, KEY_VALUE, KEY_USER_ID, KEY_ORD_INDEX]
#define SETTING_QUERY_SQL [NSString stringWithFormat:@" select %@, %@, %@, %@, %@, %@, %@ from %@ where %@ = ? order by %@", KEY_UUID, KEY_CODE, KEY_NAME, KEY_IMG, KEY_VALUE, KEY_USER_ID, KEY_ORD_INDEX, SETTING_TABLE, KEY_USER_ID, KEY_ORD_INDEX]

@implementation ZKHSettingData

- (id)init
{
    if (self = [super init]) {
        [self createTable:SETTING_CREATE_SQL];
    }
    return self;
}

- (void)save:(NSArray *)data
{
    if ([data count] == 0) {
        return;
    }
    
    for (ZKHSettingEntity *setting in data) {
        [self executeUpdate:SETTING_UPDATE_SQL params:@[setting.uuid, setting.code, setting.name,setting.img, setting.value, setting.userId, setting.ordIndex]];
    }
}

- (id)processRow:(sqlite3_stmt *)stmt
{
    ZKHSettingEntity *setting = [[ZKHSettingEntity alloc] init];
    int i = 0;
    setting.uuid = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    setting.code = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    setting.name = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    
    char * img = (char*)sqlite3_column_text(stmt, i++);
    if (img != NULL) {
        setting.img = [[NSString alloc] initWithUTF8String:img];
    }
    
//    char * value = (char*)sqlite3_column_text(stmt, i++);
//    if (value != NULL) {
//        setting.value = [[NSString alloc] initWithUTF8String:img];
//    }
    setting.value = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    setting.userId = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    setting.ordIndex = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    return setting;
}

- (NSMutableArray *)getSettings:(NSString *)userId
{
    return [self query:SETTING_QUERY_SQL params:@[userId]];
}

@end