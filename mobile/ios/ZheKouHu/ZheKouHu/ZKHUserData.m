
#import "ZKHData.h"
#import "ZKHConst.h"
#import "ZKHEntity.h"

#define USER_TABLE @"e_user"
#define USER_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text) ", USER_TABLE, KEY_UUID, KEY_NAME, KEY_PWD, KEY_TYPE, KEY_PHONE, KEY_PHOTO, KEY_REGISTER_TIME]
#define USER_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@, %@, %@, %@, %@) values (?, ?, ?, ?, ?, ?, ?)", USER_TABLE, KEY_UUID, KEY_NAME, KEY_PWD, KEY_TYPE, KEY_PHONE, KEY_PHOTO, KEY_REGISTER_TIME]
#define USER_BY_PHONE_QUERY_SQL [NSString stringWithFormat:@" select %@, %@, %@, %@, %@, %@, %@ from %@ where %@ = ? ", KEY_UUID, KEY_NAME, KEY_PWD, KEY_TYPE, KEY_PHONE, KEY_PHOTO, KEY_REGISTER_TIME, USER_TABLE, KEY_PHONE]

@implementation ZKHUserData

- (id)init
{
    if (self = [super init]) {
        [self createTable:USER_CREATE_SQL];
    }
    return self;
}

- (void)save:(NSArray *)data
{
    if (data == nil || [data count] == 0) {
        return;
    }
    
    for (ZKHUserEntity *user in data) {
        [self executeUpdate:USER_UPDATE_SQL params:@[user.uuid, user.name, user.pwd, user.type, user.phone, user.photo, user.registerTime]];
    }
}

- (ZKHUserEntity *)getUser:(NSString *)phone
{
    NSLog(@"sql : %@", USER_BY_PHONE_QUERY_SQL);
    sqlite3 *database = nil;
    @try {
        database = [self openDatabase];
        sqlite3_stmt *stmt;
        
        @try {
            stmt = [self prepareStatement:USER_BY_PHONE_QUERY_SQL params:@[phone] database:database];
            if (sqlite3_step(stmt) == SQLITE_ROW) {
                ZKHUserEntity *user = [[ZKHUserEntity alloc] init];
                
                int i = 0;
                user.uuid = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
                user.name = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
                user.pwd = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
                user.type = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
                user.phone = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
                user.photo = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
                user.registerTime = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
                
                return user;
                
            }
        }
        @catch (NSException *exception) {
            @throw exception;
        }
        @finally {
            sqlite3_finalize(stmt);
        }
    }
    @catch (NSException *exception) {
        @throw exception;
    }
    @finally {
        [self closeDatabase:database];
    }
    
    return nil;
}

@end