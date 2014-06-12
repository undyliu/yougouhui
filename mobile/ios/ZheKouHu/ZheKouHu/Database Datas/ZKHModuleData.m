
#import "ZKHData.h"
#import "ZKHConst.h"
#import "ZKHEntity.h"

#define MODULE_TABLE @"e_module"
#define MODULE_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text, %@ text, %@ text, %@ text,%@ integer) ", MODULE_TABLE, KEY_UUID, KEY_CODE, KEY_NAME, KEY_ICON, KEY_TYPE, KEY_URL, KEY_ORD_INDEX]
#define MODULE_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@, %@, %@,%@, %@) values (?, ?, ?, ?, ?, ?, ?)", MODULE_TABLE, KEY_UUID, KEY_CODE, KEY_NAME, KEY_ICON, KEY_TYPE, KEY_URL, KEY_ORD_INDEX]
#define MODULE_QUERY_SQL [NSString stringWithFormat:@" select %@, %@, %@, %@, %@, %@ from %@ where %@ = ? order by %@ ", KEY_UUID, KEY_CODE, KEY_NAME, KEY_ICON, KEY_TYPE, MODULE_TABLE, KEY_TYPE, KEY_URL, KEY_ORD_INDEX]

@implementation ZKHModuleData

- (id)init
{
    if (self = [super init]) {
        [self createTable:MODULE_CREATE_SQL];
    }
    return self;
}

- (void)save:(NSArray *)data
{
    if (data == nil || [data count] == 0) {
        return;
    }
    
    for (ZKHModuleEntity *module in data) {
        NSString *url = module.url == nil ? @"" : module.url;
        [self executeUpdate:MODULE_UPDATE_SQL params:@[module.uuid, module.code, module.name, module.icon, module.type, url, module.ordIndex]];
    }
}

- (id)processRow:(sqlite3_stmt *)stmt
{
    ZKHModuleEntity *module = [[ZKHModuleEntity alloc] init];
    
    int i = 0;
    module.uuid = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    module.code = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    module.name = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    module.icon = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    module.url = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    module.type = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    return module;
}

- (NSMutableArray *)modules:(NSString *)type
{
    return [self query:MODULE_QUERY_SQL params:@[type]];
}

@end